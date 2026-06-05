package com.drink.server.service.impl;

import com.drink.server.common.BusinessException;
import com.drink.server.common.JwtUtil;
import com.drink.server.common.Md5Util;
import com.drink.server.entity.Employee;
import com.drink.server.mapper.EmployeeMapper;
import com.drink.server.service.AdminService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {

    private final EmployeeMapper employeeMapper;
    private final JwtUtil jwtUtil;

    public AdminServiceImpl(EmployeeMapper employeeMapper, JwtUtil jwtUtil) {
        this.employeeMapper = employeeMapper;
        this.jwtUtil = jwtUtil;
    }

    @Override
    public Map<String, Object> login(String account, String password) {
        Employee employee = employeeMapper.getByAccount(account);
        if (employee == null) {
            throw new BusinessException("账号不存在");
        }
        if (employee.getStatus() == 0) {
            throw new BusinessException("账号已被禁用");
        }
        String encryptedPassword = Md5Util.encrypt(password);
        if (!encryptedPassword.equals(employee.getPassword())) {
            throw new BusinessException("密码错误");
        }

        // 生成JWT
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", employee.getId());
        claims.put("account", employee.getAccount());
        claims.put("role", employee.getRole());
        claims.put("type", "admin");
        String token = jwtUtil.generateToken(claims);

        // 返回结果
        Map<String, Object> result = new HashMap<>();
        result.put("id", employee.getId());
        result.put("name", employee.getName());
        result.put("account", employee.getAccount());
        result.put("role", employee.getRole());
        result.put("token", token);
        return result;
    }
}
