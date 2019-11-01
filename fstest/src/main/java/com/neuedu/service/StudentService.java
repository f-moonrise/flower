package com.neuedu.service;

import com.neuedu.pojo.Student;
import org.springframework.stereotype.Service;

import java.util.List;

public interface StudentService {
    List<Student> list();
}
