package com.wanghao.ssm.Entity;

import java.util.HashMap;
import java.util.Map;

/**
 * @Class-NAME Message
 * @Author wanghao
 * @Date 2021/11/22
 * @Description:
 **/
public class Message {

    //状态码
    private int code;
    //提示信息
    private String msg;

    //用户要返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<> ();

    public static Message Success()
    {
        Message result = new Message ();
        result.setCode (200);
        result.setMsg ("处理成功");
        return result;
    }

    public static Message Failure()
    {
        Message result = new Message ();
        result.setCode (250);
        result.setMsg ("处理失败");
        return result;
    }
//    满足链式操作
    public Message add(String key,Object value)
    {
        this.getExtend ().put (key, value);
        return this;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
