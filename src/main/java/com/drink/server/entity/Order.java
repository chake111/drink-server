package com.drink.server.entity;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 订单实体
 */
@Data
public class Order {
    private Long id;
    private Long userId;
    private String orderNo;
    private BigDecimal amount;
    /** 状态：1待接单 2制作中 3待取餐 4已完成 5已取消 */
    private Integer status;
    private String pickupType;
    private String pickupNo;
    private LocalDateTime createTime;

    /** 非数据库字段：用户名 */
    private String userName;

    /** 非数据库字段：订单明细 */
    private List<OrderDetail> details;
}
