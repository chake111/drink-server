package com.drink.server.mapper;

import com.drink.server.entity.Category;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface CategoryMapper {

    List<Category> list();

    Category getById(@Param("id") Long id);

    int insert(Category category);

    int update(Category category);

    int deleteById(@Param("id") Long id);

    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    int updateSort(@Param("id") Long id, @Param("sort") Integer sort);

    Integer maxSort();
}
