package com.hotel.entity;

/**
 * Created by Wong on 2017/5/24.
 */
public class User {
    public User() {
    }

    public User(Integer id, String name, String gender, String password,
                String mobile, String email) {
        this.id = id;
        this.name = name;
        this.gender = gender;
        this.password = password;
        this.mobile = mobile;
        this.email = email;
    }

    private Integer id;
    private String name;
    private String gender;
    private String password;
    private String mobile;
    private String email;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getMobile() {
        return mobile;
    }
    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", password='" + password + '\'' +
                ", mobile='" + mobile + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
