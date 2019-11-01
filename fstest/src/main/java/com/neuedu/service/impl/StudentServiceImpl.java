package com.neuedu.service.impl;

import com.neuedu.dao.StudentDao;
import com.neuedu.pojo.Student;
import com.neuedu.service.StudentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {
    @Resource
    StudentDao studentDao;

    public List<Student> list() {
        return studentDao.list();
    }
}
