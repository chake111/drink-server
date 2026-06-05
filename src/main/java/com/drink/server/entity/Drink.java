package com.drink.server.entity;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 饮品实体
 */
@Data
public class Drink {
    private Long id;
    private String name;
    private Long categoryId;
    private BigDecimal price;
    private String image;
    private String description;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /** 非数据库字段：分类名称 */
    private String categoryName;

    /** 非数据库字段：口味列表 */
    private List<DrinkFlavor> flavors;
}
