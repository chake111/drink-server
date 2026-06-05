package com.drink.server.mapper;

import com.drink.server.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {

    /** 根据openid查询 */
    User getByOpenid(@Param("openid") String openid);

    /** 新增 */
    int insert(User user);

    /** 根据ID查询 */
    User getById(@Param("id") Long id);
}
