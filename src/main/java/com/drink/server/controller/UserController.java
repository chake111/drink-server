package com.drink.server.controller;

import com.drink.server.common.Result;
import com.drink.server.entity.Category;
import com.drink.server.service.CategoryService;
import com.drink.server.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 用户端控制器
 */
@RestController
@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;
    private final CategoryService categoryService;

    public UserController(UserService userService, CategoryService categoryService) {
        this.userService = userService;
        this.categoryService = categoryService;
    }

    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestBody Map<String, String> body) {
        String account = body.get("account");
        Map<String, Object> data = userService.login(account);
        return Result.success(data);
    }

    /**
     * 用户端获取分类列表（仅启用的分类）
     */
    @GetMapping("/category/list")
    public Result<List<Category>> categoryList() {
        List<Category> all = categoryService.list();
        List<Category> enabled = all.stream()
                .filter(c -> c.getStatus() != null && c.getStatus() == 1)
                .collect(Collectors.toList());
        return Result.success(enabled);
    }
}
