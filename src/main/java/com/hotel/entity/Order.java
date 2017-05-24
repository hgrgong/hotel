package com.hotel.entity;

/**
 * Created by Wong on 2017/5/25.
 */
public class Order {
    public Order() {
    }

    public Order(Integer orderId, Integer userId, Integer roomId, Integer liveDays) {
        this.orderId = orderId;
        this.userId = userId;
        this.roomId = roomId;
        this.liveDays = liveDays;
    }

    private Integer orderId;
    private Integer userId;
    private Integer roomId;
    private Integer liveDays;

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    public Integer getLiveDays() {
        return liveDays;
    }

    public void setLiveDays(Integer liveDays) {
        this.liveDays = liveDays;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", roomId=" + roomId +
                ", liveDays=" + liveDays +
                '}';
    }
}
