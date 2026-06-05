package com.drink.server.service.impl;

import com.drink.server.common.BusinessException;
import com.drink.server.common.JwtUtil;
import com.drink.server.entity.User;
import com.drink.server.mapper.UserMapper;
import com.drink.server.service.UserService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final JwtUtil jwtUtil;

    public UserServiceImpl(UserMapper userMapper, JwtUtil jwtUtil) {
        this.userMapper = userMapper;
        this.jwtUtil = jwtUtil;
    }

    @Override
    public Map<String, Object> login(String account) {
        // 模拟微信登录：用account作为openid
        User user = userMapper.getByOpenid(account);
        if (user == null) {
            // 自动注册
            user = new User();
            user.setOpenid(account);
            user.setNickname("用户" + account.substring(0, Math.min(4, account.length())));
            user.setAvatar("");
            userMapper.insert(user);
        }

        // 生成JWT
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", user.getId());
        claims.put("openid", user.getOpenid());
        claims.put("type", "user");
        String token = jwtUtil.generateToken(claims);

        // 返回结果
        Map<String, Object> result = new HashMap<>();
        result.put("id", user.getId());
        result.put("nickname", user.getNickname());
        result.put("avatar", user.getAvatar());
        result.put("token", token);
        return result;
    }
}
