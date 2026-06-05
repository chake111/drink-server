package com.drink.server.service;

import com.drink.server.common.PageResult;
import com.drink.server.dto.OrderPageQuery;
import com.drink.server.dto.OrderSubmitDTO;
import com.drink.server.entity.Order;
import java.util.List;
import java.util.Map;

public interface OrderService {

    /** 管理端分页查询 */
    PageResult<Order> pageQuery(OrderPageQuery query);

    /** 订单详情 */
    Order getById(Long id);

    /** 接单 */
    void confirm(Long id);

    /** 完成制作 */
    void complete(Long id);

    /** 确认取餐 */
    void pickup(Long id);

    /** 拒单 */
    void reject(Long id, String reason);

    /** 用户端提交订单 */
    Map<String, Object> submit(Long userId, OrderSubmitDTO dto);

    /** 用户端查询订单列表 */
    List<Order> listByUserId(Long userId, Integer status);

    /** 用户端取消订单 */
    void cancel(Long userId, Long orderId);
}
