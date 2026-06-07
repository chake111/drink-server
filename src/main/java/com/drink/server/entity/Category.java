package com.drink.server.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 饮品分类实体
 */
@Data
public class Category {
    private Long id;
    private String name;
    private String icon;
    private Integer sort;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /**
     * 该分类下的饮品数量（非数据库字段，由查询聚合）
     */
    private Integer drinkCount;
}
