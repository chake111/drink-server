package com.drink.server.common;

import lombok.Data;

import java.util.List;

/**
 * 分页结果封装
 * @param <T> 记录类型
 */
@Data
public class PageResult<T> {

    /** 总记录数 */
    private Long total;

    /** 当前页数据 */
    private List<T> records;

    public PageResult() {}

    public PageResult(Long total, List<T> records) {
        this.total = total;
        this.records = records;
    }
}
