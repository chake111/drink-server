package com.drink.server.service;

import java.util.Map;

/**
 * 用户端登录服务
 */
public interface UserService {

    /**
     * 用户端登录（模拟微信登录）
     * @param account 用户账号
     * @return 登录信息（含token）
     */
    Map<String, Object> login(String account);
}
