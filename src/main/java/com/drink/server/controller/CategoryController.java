package com.drink.server.controller;

import com.drink.server.common.Result;
import com.drink.server.entity.Category;
import com.drink.server.service.CategoryService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 饮品分类控制器（管理端）
 */
@RestController
@RequestMapping("/api/category")
public class CategoryController {

    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping("/list")
    public Result<List<Category>> list() {
        return Result.success(categoryService.list());
    }

    @PostMapping
    public Result<Void> add(@RequestBody Category category) {
        categoryService.add(category);
        return Result.success("新增成功", null);
    }

    @PutMapping
    public Result<Void> update(@RequestBody Category category) {
        categoryService.update(category);
        return Result.success("修改成功", null);
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        categoryService.delete(id);
        return Result.success("删除成功", null);
    }

    @PostMapping("/status/{status}")
    public Result<Void> updateStatus(@PathVariable Integer status, @RequestParam Long id) {
        categoryService.updateStatus(id, status);
        return Result.success("操作成功", null);
    }

    @PutMapping("/sort")
    public Result<Void> updateSort(@RequestBody Map<String, List<Long>> body) {
        List<Long> ids = body.get("ids");
        categoryService.updateSort(ids);
        return Result.success("排序成功", null);
    }
}
