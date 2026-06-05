package com.drink.server.controller;

import com.drink.server.common.Result;
import com.drink.server.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 用户端登录控制器
 */
@RestController
@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestBody Map<String, String> body) {
        String account = body.get("account");
        Map<String, Object> data = userService.login(account);
        return Result.success(data);
    }
}
