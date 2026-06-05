package com.drink.server.mapper;

import com.drink.server.entity.Employee;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface EmployeeMapper {

    /** 根据账号查询 */
    Employee getByAccount(@Param("account") String account);

    /** 分页查询 */
    List<Employee> pageQuery(@Param("name") String name,
                             @Param("role") String role,
                             @Param("offset") int offset,
                             @Param("pageSize") int pageSize);

    /** 查询总数 */
    long count(@Param("name") String name, @Param("role") String role);

    /** 根据ID查询 */
    Employee getById(@Param("id") Long id);

    /** 新增 */
    int insert(Employee employee);

    /** 修改 */
    int update(Employee employee);

    /** 更新状态 */
    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    /** 删除 */
    int deleteById(@Param("id") Long id);
}
