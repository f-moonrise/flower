package com.neuedu.controller;

import com.neuedu.pojo.Student;
import com.neuedu.service.StudentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/student")
public class TestController {
    @Resource
    StudentService studentService;
    @RequestMapping("/list")
    public String list(ModelMap modelMap){
        List<Student> list = studentService.list();
        modelMap.addAttribute("list",list);
        return "list";
    }
}
