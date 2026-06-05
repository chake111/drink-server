package com.drink.server.entity;

import lombok.Data;

/**
 * 饮品口味实体
 */
@Data
public class DrinkFlavor {
    private Long id;
    private Long drinkId;
    private String name;
    private String value;
}
