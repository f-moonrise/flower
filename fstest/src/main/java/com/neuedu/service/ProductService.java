package com.neuedu.service;

import com.neuedu.pojo.Product;

import java.util.List;

public interface ProductService {
    List<Product> list(Product product);
    int add(Product product);
    Product getProductById(Integer id);
    int update(Product product);
    int batchdel(List<Integer> ids);
}
