package com.wanghao.ssm.Controller;

import com.sun.xml.internal.fastinfoset.vocab.Vocabulary;
import com.wanghao.ssm.Entity.Message;
import com.wanghao.ssm.Entity.User;
import com.wanghao.ssm.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;

/**
 * @Class-NAME PageController
 * @Author wanghao
 * @Date 2021/11/25
 * @Description:
 **/
@Controller
public class UserController {


    @Autowired
    private UserService userService;

    /**
     * 验证登录
     */
    @RequestMapping(value = "/loginVerify",method = RequestMethod.POST)
    @ResponseBody
    public Message login(User user, HttpServletRequest req)
    {

        String userName = user.getUname ();
        User isContainUser = userService.IsContainUser (userName);
        //获取session中的验证码后，删除验证码
        String code = (String)req.getSession ().getAttribute (KAPTCHA_SESSION_KEY);
        req.getSession().removeAttribute(KAPTCHA_SESSION_KEY);
        //验证验证码
        String verifycode = req.getParameter ("code");
        //用户名密码验证
        if(isContainUser == null)
        {
            return Message.Failure ().add ("errmsg","用户不存在");
        }else if(isContainUser.getPassword ().equals (user.getPassword ())==false)
        {
            return Message.Failure ().add ("errmsg","密码错误");
        }else if(code.equalsIgnoreCase (verifycode)==false)
        {
          return Message.Failure ().add ("errmsg","验证码错误");
        } else {
            System.out.println ("success");
            return Message.Success ();
        }
    }

    @RequestMapping("/login_success")
    public String login_success()
    {
        return "manager";
    }

    @RequestMapping("/regist")
    public String userRegist()
    {
        return "register";
    }

}
