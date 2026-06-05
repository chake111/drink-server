package com.drink.server.mapper;

import com.drink.server.entity.OrderDetail;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface OrderDetailMapper {

    /** 根据订单ID查询明细 */
    List<OrderDetail> listByOrderId(@Param("orderId") Long orderId);

    /** 批量插入 */
    int insertBatch(@Param("list") List<OrderDetail> list);
}
