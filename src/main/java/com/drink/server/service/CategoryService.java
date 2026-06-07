package com.drink.server.service;

import com.drink.server.entity.Category;
import java.util.List;

public interface CategoryService {

    List<Category> list();

    void add(Category category);

    void update(Category category);

    void delete(Long id);

    void updateStatus(Long id, Integer status);

    void updateSort(List<Long> ids);
}
