package com.neuedu.service.impl;

import com.neuedu.dao.ProductMapper;
import com.neuedu.pojo.Product;
import com.neuedu.pojo.ProductExample;
import com.neuedu.service.ProductService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class ProductServiceImpl implements ProductService {
    @Resource
    ProductMapper productMapper;
    @Override
    public List<Product> list(Product product) {
        ProductExample productExample = new ProductExample();
        ProductExample.Criteria criteria = productExample.createCriteria();
        if(StringUtils.isNotBlank(product.getName()))
            criteria.andNameLike("%"+product.getName()+"%");
        if(product.getActive()!=null)
            criteria.andActiveEqualTo(product.getActive());
        return productMapper.selectByExampleWithBLOBs(productExample);
    }
    @Override
    public int add(Product product) {
        return productMapper.insertSelective(product);
    }

    @Override
    public Product getProductById(Integer id) {
        return productMapper.selectByPrimaryKey(id);
    }

    @Override
    public int update(Product product) {
        return productMapper.updateByPrimaryKeySelective(product);
    }

    public int batchdel(List<Integer> ids){
        Product product = new Product();
        product.setActive(0);
        ProductExample productExample = new ProductExample();
        ProductExample.Criteria criteria = productExample.createCriteria();
        criteria.andIdIn(ids);
        return productMapper.updateByExampleSelective(product,productExample);
    }
}
