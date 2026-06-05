package com.drink.server.mapper;

import com.drink.server.entity.DrinkFlavor;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface DrinkFlavorMapper {

    /** 根据饮品ID查询口味 */
    List<DrinkFlavor> listByDrinkId(@Param("drinkId") Long drinkId);

    /** 批量插入 */
    int insertBatch(@Param("list") List<DrinkFlavor> list);

    /** 删除某饮品的所有口味 */
    int deleteByDrinkId(@Param("drinkId") Long drinkId);
}
