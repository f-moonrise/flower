package com.neuedu.controller;

import com.neuedu.pojo.Product;
import com.neuedu.service.ProductService;
import javafx.scene.input.DataFormat;
import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.xml.crypto.Data;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/product")
public class ProductController {
    @Resource
    ProductService productService;

    @RequestMapping("/list")
    public String list(ModelMap modelMap,Product product){
        List<Product> list = productService.list(product);
        modelMap.addAttribute("list",list);
        return "product/list";
    }

    @RequestMapping(value = "/add",method = RequestMethod.GET)
    public String goAdd(){
        return "product/add";
    }

    @RequestMapping(value="/add",method = RequestMethod.POST)
    public String doAdd(HttpServletRequest request, Product product, MultipartFile imgage){
        try {
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
            StringBuilder builder = new StringBuilder(df.format(new Date()));
            Random random = new Random();
            for(int i=0;i<4;i++)
                builder.append(random.nextInt(10));
            builder.append(".").append(FilenameUtils.getExtension(imgage.getOriginalFilename()));
            imgage.transferTo(new File(request.getServletContext().getRealPath("/resource/images/")+builder.toString()));
            product.setImg(builder.toString());
            productService.add(product);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:list";
    }

    @RequestMapping(value="/update",method = RequestMethod.GET)
    public String goUpdate(Integer id,ModelMap modelMap){
        // 根据ID读取出要修改的数据
        Product product = productService.getProductById(id);
        // 放数据放进作用域
        modelMap.addAttribute("product",product);
        // 转发到修改页面
        return "product/edit";
    }

    @RequestMapping(value="/update",method = RequestMethod.POST)
    public String doUpdate(HttpServletRequest request,Product product,MultipartFile image){
        System.out.println(image);
        if(null != image){
            try {
                SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
                StringBuilder builder = new StringBuilder(df.format(new Date()));
                Random random = new Random();
                for(int i=0;i<4;i++)
                    builder.append(random.nextInt(10));
                builder.append(".").append(FilenameUtils.getExtension(image.getOriginalFilename()));
                image.transferTo(new File(request.getServletContext().getRealPath("/resource/images/")+builder.toString()));
                product.setImg(builder.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        productService.update(product);
        return "redirect:list";
    }

    @RequestMapping("/del")
    public String del(Product product){
        productService.update(product);
        return "redirect:list";
    }

    @RequestMapping("/batchdel")
    public String batchdel(String ids){
        List<Integer> list = new ArrayList<>();
        for(String str :ids.split(",")){
            list.add(Integer.valueOf(str));
        }
        productService.batchdel(list);
        return "redirect:list";
    }
}
