package com.drink.server.common;

import lombok.Data;

/**
 * 分页请求封装
 */
@Data
public class PageQuery {

    /** 页码，从1开始 */
    private Integer page = 1;

    /** 每页条数 */
    private Integer pageSize = 10;

    /**
     * 计算偏移量（MySQL LIMIT offset, size）
     */
    public int getOffset() {
        return (page - 1) * pageSize;
    }
}
