package com.drink.server.service.impl;

import com.drink.server.common.BusinessException;
import com.drink.server.common.PageResult;
import com.drink.server.dto.OrderPageQuery;
import com.drink.server.dto.OrderSubmitDTO;
import com.drink.server.entity.Drink;
import com.drink.server.entity.Order;
import com.drink.server.entity.OrderDetail;
import com.drink.server.mapper.DrinkMapper;
import com.drink.server.mapper.OrderDetailMapper;
import com.drink.server.mapper.OrderMapper;
import com.drink.server.service.OrderService;
import com.drink.server.websocket.OrderWebSocketHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class OrderServiceImpl implements OrderService {

    private final OrderMapper orderMapper;
    private final OrderDetailMapper orderDetailMapper;
    private final DrinkMapper drinkMapper;
    private final OrderWebSocketHandler webSocketHandler;

    public OrderServiceImpl(OrderMapper orderMapper, OrderDetailMapper orderDetailMapper,
                            DrinkMapper drinkMapper, OrderWebSocketHandler webSocketHandler) {
        this.orderMapper = orderMapper;
        this.orderDetailMapper = orderDetailMapper;
        this.drinkMapper = drinkMapper;
        this.webSocketHandler = webSocketHandler;
    }

    @Override
    public PageResult<Order> pageQuery(OrderPageQuery query) {
        long total = orderMapper.count(query.getStatus(), query.getOrderNo());
        List<Order> records = new ArrayList<>();
        if (total > 0) {
            records = orderMapper.pageQuery(query.getStatus(), query.getOrderNo(),
                    query.getOffset(), query.getPageSize());
            for (Order order : records) {
                order.setDetails(orderDetailMapper.listByOrderId(order.getId()));
            }
        }
        return new PageResult<>(total, records);
    }

    @Override
    public Order getById(Long id) {
        Order order = orderMapper.getById(id);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        order.setDetails(orderDetailMapper.listByOrderId(id));
        return order;
    }

    @Override
    public void confirm(Long id) {
        Order order = orderMapper.getById(id);
        if (order == null || order.getStatus() != 1) {
            throw new BusinessException("订单状态异常");
        }
        orderMapper.updateStatus(id, 2);
        broadcast();
    }

    @Override
    public void complete(Long id) {
        Order order = orderMapper.getById(id);
        if (order == null || order.getStatus() != 2) {
            throw new BusinessException("订单状态异常");
        }
        orderMapper.updateStatus(id, 3);
    }

    @Override
    public void pickup(Long id) {
        Order order = orderMapper.getById(id);
        if (order == null || order.getStatus() != 3) {
            throw new BusinessException("订单状态异常");
        }
        orderMapper.updateStatus(id, 4);
    }

    @Override
    public void reject(Long id, String reason) {
        Order order = orderMapper.getById(id);
        if (order == null || order.getStatus() != 1) {
            throw new BusinessException("订单状态异常");
        }
        orderMapper.reject(id, 5, reason);
        broadcast();
    }

    @Override
    @Transactional
    public Map<String, Object> submit(Long userId, OrderSubmitDTO dto) {
        if (dto.getItems() == null || dto.getItems().isEmpty()) {
            throw new BusinessException("购物车不能为空");
        }

        // 计算金额并构建明细
        BigDecimal totalAmount = BigDecimal.ZERO;
        List<OrderDetail> details = new ArrayList<>();
        for (OrderSubmitDTO.OrderItem item : dto.getItems()) {
            Drink drink = drinkMapper.getById(item.getDrinkId());
            if (drink == null || drink.getStatus() != 1) {
                throw new BusinessException("饮品[" + item.getDrinkId() + "]不存在或已停售");
            }
            OrderDetail detail = new OrderDetail();
            detail.setDrinkId(drink.getId());
            detail.setDrinkName(drink.getName());
            detail.setSpec(item.getSpec());
            detail.setQuantity(item.getQuantity());
            detail.setPrice(drink.getPrice());
            details.add(detail);
            totalAmount = totalAmount.add(drink.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
        }

        // 生成订单号
        String orderNo = generateOrderNo();
        // 生成取餐号
        String pickupNo = generatePickupNo();

        // 创建订单
        Order order = new Order();
        order.setUserId(userId);
        order.setOrderNo(orderNo);
        order.setAmount(totalAmount);
        order.setStatus(1);
        order.setPickupType(dto.getPickupType());
        order.setPickupNo(pickupNo);
        orderMapper.insert(order);

        // 保存明细
        for (OrderDetail d : details) {
            d.setOrderId(order.getId());
        }
        orderDetailMapper.insertBatch(details);

        Map<String, Object> result = new HashMap<>();
        result.put("orderNo", orderNo);
        result.put("amount", totalAmount);
        broadcast();
        return result;
    }

    @Override
    public List<Order> listByUserId(Long userId, Integer status) {
        List<Order> orders = orderMapper.listByUserId(userId, status);
        for (Order order : orders) {
            order.setDetails(orderDetailMapper.listByOrderId(order.getId()));
        }
        return orders;
    }

    @Override
    public void cancel(Long userId, Long orderId) {
        Order order = orderMapper.getById(orderId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        if (!order.getUserId().equals(userId)) {
            throw new BusinessException("无权操作此订单");
        }
        if (order.getStatus() != 1) {
            throw new BusinessException("仅待接单状态可取消");
        }
        orderMapper.updateStatus(orderId, 5);
        broadcast();
    }

    @Override
    public long getPendingCount() {
        return orderMapper.countByStatus(1);
    }

    /**
     * 广播待接单数量给管理端
     */
    private void broadcast() {
        try {
            long count = orderMapper.countByStatus(1);
            webSocketHandler.broadcastPendingCount(count);
        } catch (Exception e) {
            log.warn("广播待接单数量失败: {}", e.getMessage());
        }
    }

    /**
     * 生成订单号：年月日时分秒 + 4位随机数
     */
    private String generateOrderNo() {
        String dateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        int random = (int) (Math.random() * 10000);
        return dateTime + String.format("%04d", random);
    }

    /**
     * 生成取餐号：字母 + 2位随机数字
     */
    private String generatePickupNo() {
        char letter = (char) ('A' + (int) (Math.random() * 26));
        int num = (int) (Math.random() * 100);
        return letter + String.format("%02d", num);
    }
}
