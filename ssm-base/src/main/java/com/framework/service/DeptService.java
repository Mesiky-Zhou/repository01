package com.framework.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.bean.Dept;
import com.framework.dao.DeptMapper;

@Service
public class DeptService {

	@Autowired
	DeptMapper deptMapper;
	
	public List<Dept> getAll(){
		
		return deptMapper.selectByExample(null);
	}
}
