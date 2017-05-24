package com.hotel.entity;

/**
 * Created by Wong on 2017/5/25.
 */
public class Room {
    public Room() {
    }

    public Room(Integer roomId, Integer price, Integer status, String category) {

        this.roomId = roomId;
        this.price = price;
        this.status = status;
        this.category = category;
    }

    private Integer roomId;
    private Integer price;
    private Integer status;
    private String category;

    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomId=" + roomId +
                ", price=" + price +
                ", status=" + status +
                ", category='" + category + '\'' +
                '}';
    }
}
