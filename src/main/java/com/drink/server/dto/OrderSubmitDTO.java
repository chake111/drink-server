package com.drink.server.dto;

import lombok.Data;
import java.util.List;

/**
 * 用户端提交订单请求
 */
@Data
public class OrderSubmitDTO {
    private String pickupType;
    private List<OrderItem> items;

    @Data
    public static class OrderItem {
        private Long drinkId;
        private String spec;
        private Integer quantity;
    }
}
