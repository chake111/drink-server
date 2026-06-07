package com.drink.server.service.impl;

import com.drink.server.mapper.OrderMapper;
import com.drink.server.service.DashboardService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class DashboardServiceImpl implements DashboardService {

    private final OrderMapper orderMapper;

    public DashboardServiceImpl(OrderMapper orderMapper) {
        this.orderMapper = orderMapper;
    }

    @Override
    public Map<String, Object> todayOverview() {
        Map<String, Object> today = orderMapper.todayOverview();
        Map<String, Object> yesterday = orderMapper.yesterdayOverview();

        long todayOrders = toLong(today.get("todayOrders"));
        long yesterdayOrders = toLong(yesterday.get("yesterdayOrders"));
        double todayAmount = toDouble(today.get("todayAmount"));
        double yesterdayAmount = toDouble(yesterday.get("yesterdayAmount"));
        long todayPending = toLong(today.get("pendingOrders"));
        long yesterdayPending = toLong(yesterday.get("pendingOrders"));
        long todayCompleted = toLong(today.get("completedOrders"));
        long yesterdayCompleted = toLong(yesterday.get("completedOrders"));

        today.put("ordersChange", calcChange(todayOrders, yesterdayOrders));
        today.put("amountChange", calcChange(todayAmount, yesterdayAmount));
        today.put("pendingChange", calcChange(todayPending, yesterdayPending));
        today.put("completedChange", calcChange(todayCompleted, yesterdayCompleted));

        return today;
    }

    /** 计算环比百分比：(今-昨)/昨*100，昨日为0时返回0 */
    private int calcChange(long today, long yesterday) {
        if (yesterday == 0) return 0;
        return (int) Math.round((today - yesterday) * 100.0 / yesterday);
    }

    private int calcChange(double today, double yesterday) {
        if (yesterday == 0) return 0;
        return (int) Math.round((today - yesterday) * 100.0 / yesterday);
    }

    private long toLong(Object val) {
        if (val == null) return 0L;
        return ((Number) val).longValue();
    }

    private double toDouble(Object val) {
        if (val == null) return 0.0;
        return ((Number) val).doubleValue();
    }

    @Override
    public List<Map<String, Object>> recentTrend() {
        return orderMapper.recentTrend();
    }

    @Override
    public List<Map<String, Object>> topDrinks() {
        return orderMapper.topDrinks();
    }
}
