package com.drink.server.service.impl;

import com.drink.server.common.BusinessException;
import com.drink.server.common.PageResult;
import com.drink.server.common.RedisUtil;
import com.drink.server.dto.DrinkPageQuery;
import com.drink.server.entity.Drink;
import com.drink.server.entity.DrinkFlavor;
import com.drink.server.mapper.DrinkFlavorMapper;
import com.drink.server.mapper.DrinkMapper;
import com.drink.server.service.DrinkService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class DrinkServiceImpl implements DrinkService {

    private final DrinkMapper drinkMapper;
    private final DrinkFlavorMapper drinkFlavorMapper;
    private final RedisUtil redisUtil;
    private final ObjectMapper objectMapper;

    public DrinkServiceImpl(DrinkMapper drinkMapper, DrinkFlavorMapper drinkFlavorMapper,
                            RedisUtil redisUtil, ObjectMapper objectMapper) {
        this.drinkMapper = drinkMapper;
        this.drinkFlavorMapper = drinkFlavorMapper;
        this.redisUtil = redisUtil;
        this.objectMapper = objectMapper;
    }

    @Override
    public PageResult<Drink> pageQuery(DrinkPageQuery query) {
        long total = drinkMapper.count(query.getName(), query.getCategoryId(), query.getStatus());
        List<Drink> records = new ArrayList<>();
        if (total > 0) {
            records = drinkMapper.pageQuery(query.getName(), query.getCategoryId(),
                    query.getStatus(), query.getOffset(), query.getPageSize());
            // 为每条记录填充口味
            for (Drink drink : records) {
                drink.setFlavors(drinkFlavorMapper.listByDrinkId(drink.getId()));
            }
        }
        return new PageResult<>(total, records);
    }

    @Override
    public Drink getById(Long id) {
        Drink drink = drinkMapper.getById(id);
        if (drink == null) {
            throw new BusinessException("饮品不存在");
        }
        drink.setFlavors(drinkFlavorMapper.listByDrinkId(id));
        return drink;
    }

    @Override
    @Transactional
    public void add(Drink drink, String flavorsJson) {
        if (drink.getStatus() == null) {
            drink.setStatus(1);
        }
        drinkMapper.insert(drink);

        // 保存口味
        saveFlavors(drink.getId(), flavorsJson);

        // 清除缓存
        clearCategoryCache(drink.getCategoryId());
    }

    @Override
    @Transactional
    public void update(Drink drink, String flavorsJson) {
        // 先查旧记录，用于清除旧分类缓存
        Drink old = drinkMapper.getById(drink.getId());
        if (old == null) {
            throw new BusinessException("饮品不存在");
        }

        drinkMapper.update(drink);

        // 更新口味：先删后增
        drinkFlavorMapper.deleteByDrinkId(drink.getId());
        saveFlavors(drink.getId(), flavorsJson);

        // 清除旧分类缓存
        clearCategoryCache(old.getCategoryId());
        // 如果分类变了，也清除新分类缓存
        if (drink.getCategoryId() != null && !drink.getCategoryId().equals(old.getCategoryId())) {
            clearCategoryCache(drink.getCategoryId());
        }
    }

    @Override
    @Transactional
    public void updateStatus(List<Long> ids, Integer status) {
        drinkMapper.updateStatus(ids, status);
        // 清除相关分类的缓存
        for (Long id : ids) {
            Drink drink = drinkMapper.getById(id);
            if (drink != null) {
                clearCategoryCache(drink.getCategoryId());
            }
        }
    }

    @Override
    @Transactional
    public void delete(List<Long> ids) {
        // 清除相关缓存
        for (Long id : ids) {
            Drink drink = drinkMapper.getById(id);
            if (drink != null) {
                clearCategoryCache(drink.getCategoryId());
                drinkFlavorMapper.deleteByDrinkId(id);
            }
        }
        drinkMapper.deleteByIds(ids);
    }

    @Override
    public List<Drink> listByCategoryId(Long categoryId) {
        // 先从Redis缓存读取
        String cacheKey = "drink:category:" + categoryId;
        String cached = redisUtil.get(cacheKey);
        if (cached != null) {
            try {
                return objectMapper.readValue(cached, new TypeReference<List<Drink>>() {});
            } catch (Exception e) {
                // 缓存解析失败，继续查数据库
            }
        }

        // 从数据库查询
        List<Drink> drinks = drinkMapper.listByCategoryId(categoryId);
        for (Drink drink : drinks) {
            drink.setFlavors(drinkFlavorMapper.listByDrinkId(drink.getId()));
        }

        // 写入缓存（1小时过期）
        try {
            String json = objectMapper.writeValueAsString(drinks);
            redisUtil.set(cacheKey, json, 1, TimeUnit.HOURS);
        } catch (Exception e) {
            // 缓存写入失败不影响业务
        }

        return drinks;
    }

    /**
     * 保存口味数据
     */
    private void saveFlavors(Long drinkId, String flavorsJson) {
        if (flavorsJson == null || flavorsJson.isEmpty()) {
            return;
        }
        try {
            List<DrinkFlavor> flavors = objectMapper.readValue(flavorsJson, new TypeReference<List<DrinkFlavor>>() {});
            if (flavors != null && !flavors.isEmpty()) {
                for (DrinkFlavor f : flavors) {
                    f.setDrinkId(drinkId);
                }
                drinkFlavorMapper.insertBatch(flavors);
            }
        } catch (Exception e) {
            throw new BusinessException("口味数据格式错误");
        }
    }

    /**
     * 清除分类缓存
     */
    private void clearCategoryCache(Long categoryId) {
        if (categoryId != null) {
            redisUtil.delete("drink:category:" + categoryId);
        }
    }
}
