package com.drink.server.controller;

import com.drink.server.common.PageResult;
import com.drink.server.common.Result;
import com.drink.server.dto.DrinkPageQuery;
import com.drink.server.entity.Drink;
import com.drink.server.service.DrinkService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 饮品管理控制器（管理端）
 */
@RestController
@RequestMapping("/api/drink")
public class DrinkController {

    private final DrinkService drinkService;

    public DrinkController(DrinkService drinkService) {
        this.drinkService = drinkService;
    }

    @GetMapping("/page")
    public Result<PageResult<Drink>> page(DrinkPageQuery query) {
        return Result.success(drinkService.pageQuery(query));
    }

    @GetMapping("/{id}")
    public Result<Drink> getById(@PathVariable Long id) {
        return Result.success(drinkService.getById(id));
    }

    @PostMapping
    public Result<Void> add(@RequestParam("name") String name,
                            @RequestParam("categoryId") Long categoryId,
                            @RequestParam("price") java.math.BigDecimal price,
                            @RequestParam(value = "image", required = false) MultipartFile image,
                            @RequestParam(value = "description", required = false) String description,
                            @RequestParam(value = "flavors", required = false) String flavors) {
        Drink drink = new Drink();
        drink.setName(name);
        drink.setCategoryId(categoryId);
        drink.setPrice(price);
        drink.setDescription(description);
        drinkService.add(drink, image, flavors);
        return Result.success("新增成功", null);
    }

    @PutMapping
    public Result<Void> update(@RequestParam("id") Long id,
                               @RequestParam("name") String name,
                               @RequestParam("categoryId") Long categoryId,
                               @RequestParam("price") java.math.BigDecimal price,
                               @RequestParam(value = "image", required = false) MultipartFile image,
                               @RequestParam(value = "description", required = false) String description,
                               @RequestParam(value = "flavors", required = false) String flavors) {
        Drink drink = new Drink();
        drink.setId(id);
        drink.setName(name);
        drink.setCategoryId(categoryId);
        drink.setPrice(price);
        drink.setDescription(description);
        drinkService.update(drink, image, flavors);
        return Result.success("修改成功", null);
    }

    @PostMapping("/status/{status}")
    public Result<Void> updateStatus(@PathVariable Integer status, @RequestParam String ids) {
        List<Long> idList = parseIds(ids);
        drinkService.updateStatus(idList, status);
        return Result.success("操作成功", null);
    }

    @DeleteMapping
    public Result<Void> delete(@RequestParam String ids) {
        List<Long> idList = parseIds(ids);
        drinkService.delete(idList);
        return Result.success("删除成功", null);
    }

    /**
     * 解析逗号分隔的ID字符串
     */
    private List<Long> parseIds(String ids) {
        return Arrays.stream(ids.split(","))
                .map(String::trim)
                .map(Long::parseLong)
                .collect(Collectors.toList());
    }
}
