package com.drink.server.mapper;

import com.drink.server.entity.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {

    /** 分页查询（管理端，含用户名） */
    List<Order> pageQuery(@Param("status") Integer status,
                          @Param("orderNo") String orderNo,
                          @Param("offset") int offset,
                          @Param("pageSize") int pageSize);

    /** 查询总数 */
    long count(@Param("status") Integer status, @Param("orderNo") String orderNo);

    /** 根据ID查询 */
    Order getById(@Param("id") Long id);

    /** 新增 */
    int insert(Order order);

    /** 更新状态 */
    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    /** 拒单（含原因） */
    int reject(@Param("id") Long id, @Param("status") Integer status, @Param("rejectReason") String rejectReason);

    /** 用户端：按用户ID查询订单列表 */
    List<Order> listByUserId(@Param("userId") Long userId, @Param("status") Integer status);

    /** 今日概览 */
    Map<String, Object> todayOverview();

    /** 昨日概览（用于环比计算） */
    Map<String, Object> yesterdayOverview();

    /** 近7日销售趋势 */
    List<Map<String, Object>> recentTrend();

    /** 热销TOP5 */
    List<Map<String, Object>> topDrinks();

    /** 统计指定状态的订单数 */
    long countByStatus(@Param("status") int status);
}
