package com.drink.server.dto;

import lombok.Data;

/**
 * 管理端登录请求
 */
@Data
public class AdminLoginDTO {
    private String account;
    private String password;
}
