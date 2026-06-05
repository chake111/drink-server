package com.drink.server.controller;

import com.drink.server.common.Result;
import com.drink.server.dto.AdminLoginDTO;
import com.drink.server.service.AdminService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 管理端登录控制器
 */
@RestController
@RequestMapping("/api/admin")
public class AdminController {

    private final AdminService adminService;

    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }

    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestBody AdminLoginDTO dto) {
        Map<String, Object> data = adminService.login(dto.getAccount(), dto.getPassword());
        return Result.success(data);
    }
}
