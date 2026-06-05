package com.drink.server.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 拦截器注册配置
 */
@Configuration
public class WebMvcInterceptorConfig implements WebMvcConfigurer {

    @Autowired
    private JwtInterceptor jwtInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(jwtInterceptor)
                .addPathPatterns("/api/**")
                .excludePathPatterns(
                        "/api/admin/login",      // 管理端登录
                        "/api/user/login",       // 用户端登录
                        "/api/category/list",    // 分类列表（公开）
                        "/api/upload/**",        // 静态资源
                        "/upload/**"             // 上传文件访问
                );
    }
}
