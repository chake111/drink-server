package com.drink.server.controller;

import com.drink.server.common.JwtUtil;
import com.drink.server.common.PageResult;
import com.drink.server.common.Result;
import com.drink.server.dto.OrderPageQuery;
import com.drink.server.dto.OrderSubmitDTO;
import com.drink.server.entity.Order;
import com.drink.server.service.OrderService;
import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 订单控制器
 */
@RestController
@RequestMapping("/api")
public class OrderController {

    private final OrderService orderService;
    private final JwtUtil jwtUtil;

    public OrderController(OrderService orderService, JwtUtil jwtUtil) {
        this.orderService = orderService;
        this.jwtUtil = jwtUtil;
    }

    // ==================== 管理端 ====================

    @GetMapping("/order/page")
    public Result<PageResult<Order>> page(OrderPageQuery query) {
        return Result.success(orderService.pageQuery(query));
    }

    @GetMapping("/order/{id}")
    public Result<Order> getOrderById(@PathVariable Long id) {
        return Result.success(orderService.getById(id));
    }

    @PostMapping("/order/confirm/{id}")
    public Result<Void> confirm(@PathVariable Long id) {
        orderService.confirm(id);
        return Result.success("操作成功", null);
    }

    @PostMapping("/order/complete/{id}")
    public Result<Void> complete(@PathVariable Long id) {
        orderService.complete(id);
        return Result.success("操作成功", null);
    }

    @PostMapping("/order/pickup/{id}")
    public Result<Void> pickup(@PathVariable Long id) {
        orderService.pickup(id);
        return Result.success("操作成功", null);
    }

    @PostMapping("/order/reject/{id}")
    public Result<Void> reject(@PathVariable Long id, @RequestBody Map<String, String> body) {
        orderService.reject(id, body.get("rejectReason"));
        return Result.success("操作成功", null);
    }

    // ==================== 用户端 ====================

    @PostMapping("/user/order")
    public Result<Map<String, Object>> submitOrder(@RequestBody OrderSubmitDTO dto,
                                                    HttpServletRequest request) {
        Long userId = getUserId(request);
        return Result.success("下单成功", orderService.submit(userId, dto));
    }

    @GetMapping("/user/order/list")
    public Result<List<Order>> userOrderList(@RequestParam(required = false) Integer status,
                                              HttpServletRequest request) {
        Long userId = getUserId(request);
        return Result.success(orderService.listByUserId(userId, status));
    }

    @PostMapping("/user/order/cancel/{id}")
    public Result<Void> cancelOrder(@PathVariable Long id, HttpServletRequest request) {
        Long userId = getUserId(request);
        orderService.cancel(userId, id);
        return Result.success("取消成功", null);
    }

    /**
     * 从JWT中获取用户ID
     */
    private Long getUserId(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new com.drink.server.common.BusinessException("未登录");
        }
        Claims claims = jwtUtil.parseToken(authHeader.substring(7));
        return claims.get("id", Long.class);
    }
}
