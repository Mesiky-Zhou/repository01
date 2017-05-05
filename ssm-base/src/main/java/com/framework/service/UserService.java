package com.framework.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.bean.User;
import com.framework.bean.UserCondition;
import com.framework.dao.UserMapper;

@Service
public class UserService {

	@Autowired
	UserMapper userMapper;
	
	public List<User> getAll(){
		
		return userMapper.selectByExample(null);
	}
	
	public User getByPrimaryKey(Integer id){
		return this.userMapper.selectByPrimaryKey(id);
	}
	
	public void updateByPrimaryKey(User user){
		this.userMapper.updateByPrimaryKeySelective(user);
	}
	
	public void save(User user){
		this.userMapper.insertSelective(user);
	}
	
	public void deleteByPrimaryKey(Integer id){
		this.userMapper.deleteByPrimaryKey(id);
	}
	
	public void deleteByBatch(List<Integer> ids){
		UserCondition condition = new UserCondition();
		condition.createCriteria().andIdIn(ids);
		userMapper.deleteByExample(condition);
	}
}
