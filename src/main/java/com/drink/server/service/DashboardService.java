package com.drink.server.service;

import java.util.List;
import java.util.Map;

public interface DashboardService {

    /** 今日概览 */
    Map<String, Object> todayOverview();

    /** 近7日销售趋势 */
    List<Map<String, Object>> recentTrend();

    /** 热销TOP5 */
    List<Map<String, Object>> topDrinks();
}
