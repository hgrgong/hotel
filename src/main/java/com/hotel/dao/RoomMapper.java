package com.hotel.dao;

import com.hotel.entity.Room;

import java.util.List;

/**
 * Created by Wong on 2017/5/28.
 */
public interface RoomMapper {
    // select all the room that living in the hotel
    List<Room> selectAll();

    // select all the room by category
    List<Room> selectByCategory(String category);

    // select all the room by status
    List<Room> selectByStatus(Integer status);

    // insert room
    void insert(Room room);

    // insert rooms once
    void insertBatch(List<Room> rooms);

    // update room
    void update(Room room);

    // update all room's price
    void updatePrice(Integer price, String category);

    // delete room by id
    void deleteById(Integer roomId);

}
