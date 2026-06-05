package com.drink.server.service;

import com.drink.server.common.PageResult;
import com.drink.server.dto.EmployeePageQuery;
import com.drink.server.entity.Employee;

public interface EmployeeService {

    PageResult<Employee> pageQuery(EmployeePageQuery query);

    void add(Employee employee);

    void update(Employee employee);

    void updateStatus(Long id, Integer status);

    void delete(Long id);
}
