package com.drink.server.controller;

import com.drink.server.common.Result;
import com.drink.server.entity.Drink;
import com.drink.server.service.DrinkService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户端饮品浏览控制器
 */
@RestController
@RequestMapping("/api/user/drink")
public class UserDrinkController {

    private final DrinkService drinkService;

    public UserDrinkController(DrinkService drinkService) {
        this.drinkService = drinkService;
    }

    @GetMapping("/list")
    public Result<List<Drink>> listByCategory(@RequestParam Long categoryId) {
        return Result.success(drinkService.listByCategoryId(categoryId));
    }

    @GetMapping("/{id}")
    public Result<Drink> getById(@PathVariable Long id) {
        return Result.success(drinkService.getById(id));
    }
}
