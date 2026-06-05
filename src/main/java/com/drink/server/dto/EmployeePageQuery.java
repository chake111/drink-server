package com.drink.server.dto;

import com.drink.server.common.PageQuery;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 员工分页查询参数
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class EmployeePageQuery extends PageQuery {
    private String name;
    private String role;
}
