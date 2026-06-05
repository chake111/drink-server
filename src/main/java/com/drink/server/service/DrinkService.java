package com.drink.server.service;

import com.drink.server.common.PageResult;
import com.drink.server.dto.DrinkPageQuery;
import com.drink.server.entity.Drink;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

public interface DrinkService {

    /** 管理端分页查询 */
    PageResult<Drink> pageQuery(DrinkPageQuery query);

    /** 根据ID查询（含口味） */
    Drink getById(Long id);

    /** 新增饮品 */
    void add(Drink drink, MultipartFile image, String flavorsJson);

    /** 修改饮品 */
    void update(Drink drink, MultipartFile image, String flavorsJson);

    /** 启售/停售 */
    void updateStatus(List<Long> ids, Integer status);

    /** 删除 */
    void delete(List<Long> ids);

    /** 用户端：按分类查询饮品（含口味，优先Redis缓存） */
    List<Drink> listByCategoryId(Long categoryId);
}
