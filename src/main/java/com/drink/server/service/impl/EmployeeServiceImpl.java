package com.drink.server.service.impl;

import com.drink.server.common.BusinessException;
import com.drink.server.common.Md5Util;
import com.drink.server.common.PageResult;
import com.drink.server.dto.EmployeePageQuery;
import com.drink.server.entity.Employee;
import com.drink.server.mapper.EmployeeMapper;
import com.drink.server.service.EmployeeService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    private final EmployeeMapper employeeMapper;

    public EmployeeServiceImpl(EmployeeMapper employeeMapper) {
        this.employeeMapper = employeeMapper;
    }

    @Override
    public PageResult<Employee> pageQuery(EmployeePageQuery query) {
        long total = employeeMapper.count(query.getName(), query.getRole());
        List<Employee> records = new ArrayList<>();
        if (total > 0) {
            records = employeeMapper.pageQuery(query.getName(), query.getRole(),
                    query.getOffset(), query.getPageSize());
        }
        return new PageResult<>(total, records);
    }

    @Override
    public void add(Employee employee) {
        // 检查账号是否已存在
        Employee existing = employeeMapper.getByAccount(employee.getAccount());
        if (existing != null) {
            throw new BusinessException("账号已存在");
        }
        // 密码MD5加密
        employee.setPassword(Md5Util.encrypt(employee.getPassword()));
        if (employee.getStatus() == null) {
            employee.setStatus(1);
        }
        employeeMapper.insert(employee);
    }

    @Override
    public void update(Employee employee) {
        // 如果传了密码，加密后更新
        if (employee.getPassword() != null && !employee.getPassword().isEmpty()) {
            employee.setPassword(Md5Util.encrypt(employee.getPassword()));
        }
        employeeMapper.update(employee);
    }

    @Override
    public void updateStatus(Long id, Integer status) {
        employeeMapper.updateStatus(id, status);
    }

    @Override
    public void delete(Long id) {
        Employee employee = employeeMapper.getById(id);
        if (employee == null) {
            throw new BusinessException("员工不存在");
        }
        if ("店长".equals(employee.getRole())) {
            throw new BusinessException("岗位为店长的员工不可删除");
        }
        employeeMapper.deleteById(id);
    }
}
