package com.drink.server.mapper;

import com.drink.server.entity.Drink;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface DrinkMapper {

    /** 分页查询（含分类名称） */
    List<Drink> pageQuery(@Param("name") String name,
                          @Param("categoryId") Long categoryId,
                          @Param("status") Integer status,
                          @Param("offset") int offset,
                          @Param("pageSize") int pageSize);

    /** 查询总数 */
    long count(@Param("name") String name,
               @Param("categoryId") Long categoryId,
               @Param("status") Integer status);

    /** 根据ID查询 */
    Drink getById(@Param("id") Long id);

    /** 按分类查询（仅起售，用户端用） */
    List<Drink> listByCategoryId(@Param("categoryId") Long categoryId);

    /** 新增 */
    int insert(Drink drink);

    /** 修改 */
    int update(Drink drink);

    /** 批量更新状态 */
    int updateStatus(@Param("ids") List<Long> ids, @Param("status") Integer status);

    /** 批量删除 */
    int deleteByIds(@Param("ids") List<Long> ids);

    /** 统计某分类下的饮品数量 */
    int countByCategoryId(@Param("categoryId") Long categoryId);
}
