package com.hotel.entity;

import java.util.List;

/**
 * Created by Wong on 2017/5/29.
 */
public class QueryItem {

    private List<?> rows;
    private Long total;

    public List<?> getRows() {
        return rows;
    }

    public void setRows(List<?> rows) {
        this.rows = rows;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public QueryItem() {
    }

    public QueryItem(List<?> rows, Long total) {
        this.rows = rows;
        this.total = total;
    }

    @Override
    public String toString() {
        return "QueryItem{" +
                "rows=" + rows +
                ", total=" + total +
                '}';
    }
}
