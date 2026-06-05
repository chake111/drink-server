package com.drink.server.controller;

import com.drink.server.common.Result;
import com.drink.server.service.DashboardService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 工作台控制器（管理端）
 */
@RestController
@RequestMapping("/api/dashboard")
public class DashboardController {

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping("/today")
    public Result<Map<String, Object>> today() {
        return Result.success(dashboardService.todayOverview());
    }

    @GetMapping("/trend")
    public Result<List<Map<String, Object>>> trend() {
        return Result.success(dashboardService.recentTrend());
    }

    @GetMapping("/top")
    public Result<List<Map<String, Object>>> top() {
        return Result.success(dashboardService.topDrinks());
    }
}
