package com.wanghao.ssm.Entity;

/**
 * @Class-NAME User
 * @Author wanghao
 * @Date 2021/11/25
 * @Description:
 **/
public class User {
    private Integer uid;
    private String uname;

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    @Override
    public String toString() {
        return "User{" +
                "uid=" + uid +
                ", uname='" + uname + '\'' +
                ", password='" + password + '\'' +
                '}';
    }

    public User() {
    }

    public User(Integer uid, String uname, String password) {
        this.uid = uid;
        this.uname = uname;
        this.password = password;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    private String password;
}
