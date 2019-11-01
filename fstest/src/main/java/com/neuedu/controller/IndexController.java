package com.neuedu.controller;

import com.neuedu.pojo.User;
import com.neuedu.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;


@Controller
public class IndexController {
    public static final String code="abcdefghijkmnpqrstuvwxyABCDEFGHJKLMNPQRSTUVWXY3456789";
    @Resource
    UserService userService;
    @RequestMapping("/index")
    public String index(){
        return "index";
    }
    @RequestMapping("/welcome")
    public String welcome(){
        return "welcome";
    }

    @RequestMapping("/")
    public String login(){
        return "login";
    }

    public char[] getCode(){
        char[] chars = new char[4];
        Random random = new Random();
        for(int i=0;i<chars.length;i++)
            chars[i]= code.charAt( random.nextInt(code.length()));

        return chars;
    }

    @RequestMapping("/img")
    public void img(HttpServletRequest request, HttpServletResponse response){
        HttpSession session=request.getSession();
        BufferedImage image = new BufferedImage(120,30,BufferedImage.TYPE_INT_RGB);
        Graphics graphics = image.getGraphics();
        graphics.setColor(Color.BLACK);
        graphics.fillRect(0,0,120,30);
        graphics.setColor(Color.WHITE);
        graphics.setFont(new Font("微软雅黑",Font.BOLD,24));
        char[] chars = getCode();
        session.setAttribute("code",String.valueOf(chars));
        for(int i=0;i<chars.length;i++)
            graphics.drawString(String.valueOf(chars[i]),5+(i*30),20);
        try {
            ImageIO.write(image,"jpg",response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @RequestMapping("/login")
    public String doLogin(HttpSession session,User user,String code){
        User u=userService.login(user.getId());
        if(null==u){
            //用户名输入错误
            session.setAttribute("msg","用户名错误");
            return "redirect:/";
        }else if(!u.getPwd().equals(user.getPwd())){
            // 密码错误
            session.setAttribute("msg","密码错误");
            return "redirect:/";
        }else{
            String c= session.getAttribute("code").toString();
            if(code.equalsIgnoreCase(c)){
                // 登录成功
                session.setAttribute("user",u);
                return "redirect:index";
            }else{
                // 验证码错误
                session.setAttribute("msg","验证码错误");
                return "redirect:/";
            }
        }
    }
}
