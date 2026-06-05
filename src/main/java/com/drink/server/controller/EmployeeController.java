package com.drink.server.controller;

import com.drink.server.common.PageResult;
import com.drink.server.common.Result;
import com.drink.server.dto.EmployeePageQuery;
import com.drink.server.entity.Employee;
import com.drink.server.service.EmployeeService;
import org.springframework.web.bind.annotation.*;

/**
 * 员工管理控制器（管理端）
 */
@RestController
@RequestMapping("/api/employee")
public class EmployeeController {

    private final EmployeeService employeeService;

    public EmployeeController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    @GetMapping("/page")
    public Result<PageResult<Employee>> page(EmployeePageQuery query) {
        return Result.success(employeeService.pageQuery(query));
    }

    @PostMapping
    public Result<Void> add(@RequestBody Employee employee) {
        employeeService.add(employee);
        return Result.success("新增成功", null);
    }

    @PutMapping
    public Result<Void> update(@RequestBody Employee employee) {
        employeeService.update(employee);
        return Result.success("修改成功", null);
    }

    @PostMapping("/status/{status}")
    public Result<Void> updateStatus(@PathVariable Integer status, @RequestParam Long id) {
        employeeService.updateStatus(id, status);
        return Result.success("操作成功", null);
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        employeeService.delete(id);
        return Result.success("删除成功", null);
    }
}
