package com.drink.server.dto;

import com.drink.server.common.PageQuery;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 饮品分页查询参数
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class DrinkPageQuery extends PageQuery {
    private String name;
    private Long categoryId;
    private Integer status;
}
