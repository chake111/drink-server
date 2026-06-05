package com.drink.server.service;

import java.util.Map;

/**
 * 管理端登录服务
 */
public interface AdminService {

    /**
     * 管理端登录
     * @param account 账号
     * @param password 密码（明文）
     * @return 登录信息（含token）
     */
    Map<String, Object> login(String account, String password);
}
