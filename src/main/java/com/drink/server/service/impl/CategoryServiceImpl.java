package com.drink.server.service.impl;

import com.drink.server.common.BusinessException;
import com.drink.server.entity.Category;
import com.drink.server.mapper.CategoryMapper;
import com.drink.server.mapper.DrinkMapper;
import com.drink.server.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class CategoryServiceImpl implements CategoryService {

    private final CategoryMapper categoryMapper;
    private final DrinkMapper drinkMapper;

    public CategoryServiceImpl(CategoryMapper categoryMapper, DrinkMapper drinkMapper) {
        this.categoryMapper = categoryMapper;
        this.drinkMapper = drinkMapper;
    }

    @Override
    public List<Category> list() {
        List<Category> list = categoryMapper.list();
        log.info("category list 返回 {} 条, 顺序: {}", list.size(), list.stream().map(c -> c.getId() + "(sort=" + c.getSort() + ")").toList());
        return list;
    }

    @Override
    public void add(Category category) {
        if (category.getStatus() == null) {
            category.setStatus(1);
        }
        if (category.getSort() == null) {
            category.setSort(0);
        }
        categoryMapper.insert(category);
    }

    @Override
    public void update(Category category) {
        categoryMapper.update(category);
    }

    @Override
    public void delete(Long id) {
        // 检查分类下是否有饮品
        int count = drinkMapper.countByCategoryId(id);
        if (count > 0) {
            throw new BusinessException("该分类下存在饮品，不允许删除");
        }
        categoryMapper.deleteById(id);
    }

    @Override
    public void updateStatus(Long id, Integer status) {
        categoryMapper.updateStatus(id, status);
    }

    @Override
    public void updateSort(List<Long> ids) {
        log.info("updateSort 收到 ids = {}", ids);
        for (int i = 0; i < ids.size(); i++) {
            int rows = categoryMapper.updateSort(ids.get(i), i);
            log.info("updateSort id={}, sort={}, 影响行数={}", ids.get(i), i, rows);
        }
    }
}
