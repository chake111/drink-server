package com.drink.server.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 员工实体（管理端）
 */
@Data
public class Employee {
    private Long id;
    private String name;
    private String account;
    private String password;
    private String phone;
    private String role;
    private Integer status;
    private String note;
    private LocalDateTime createTime;
}
