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
        return orderMapper.todayOverview();
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
