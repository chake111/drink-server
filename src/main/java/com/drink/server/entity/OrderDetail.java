package com.drink.server.entity;

import lombok.Data;
import java.math.BigDecimal;

/**
 * 订单明细实体
 */
@Data
public class OrderDetail {
    private Long id;
    private Long orderId;
    private Long drinkId;
    private String drinkName;
    private String image;
    private String spec;
    private Integer quantity;
    private BigDecimal price;
}
