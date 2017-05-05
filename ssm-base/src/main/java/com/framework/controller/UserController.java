package com.framework.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.framework.bean.User;
import com.framework.core.Msg;
import com.framework.core.StaticConfigData;
import com.framework.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/sysmgr/user")
public class UserController {
	@Autowired
	UserService userService;

	@RequestMapping("/web/list1")
	public String list1(@RequestParam(value="pageNo",defaultValue="1") int pageNo,
			Map<String,Object> map){
		PageHelper.startPage(pageNo, 6);
		List<User> users = this.userService.getAll();
		PageInfo<User> pageInfo = new PageInfo<User>(users,5);
		
		map.put("pageInfo", pageInfo);
		return  "/user/list1";
	}
	
	@RequestMapping("/service/list")
	@ResponseBody
	public Msg list(@RequestParam(value="pageNo",defaultValue="1") int pageNo,
			Map<String,Object> map){
		PageHelper.startPage(pageNo, 6);
		List<User> users = this.userService.getAll();
		PageInfo<User> pageInfo = new PageInfo<User>(users,5);
		
		return  Msg.success().add("pageInfo", pageInfo)
				.add("listConfig", StaticConfigData.getByKey("sysmgr.user.listconfig"));
	}
	
	@RequestMapping(value="/service/add", method=RequestMethod.POST)
	@ResponseBody
	public Msg add(@Valid User user,BindingResult result){
		if(result.hasErrors()){
			List<FieldError> fes = result.getFieldErrors();
			Map<String,String> map = new HashMap<>();
			for(FieldError fe : fes){
				map.put(fe.getField(), fe.getDefaultMessage());
			}
			
			return  Msg.fail().add("errorMessages", map);
		}else{
			user.setCreateTime(new Date());
			this.userService.save(user);
			
			return  Msg.success();
		}
	}
	
	@RequestMapping(value="/service/delete", method=RequestMethod.DELETE)
	@ResponseBody
	public Msg delete(@RequestParam("ids") String ids){
		if(ids!=null && ids.indexOf("-")>0){
			List<Integer> idList = new ArrayList<>();
			String idArr[] = ids.split("-");
			for(String id : idArr){
				idList.add(Integer.parseInt(id));
			}
			
			this.userService.deleteByBatch(idList);
			
		}else{
			Integer id = Integer.parseInt(ids);
			
			this.userService.deleteByPrimaryKey(id);
		}
		
		return Msg.success();
	}
	
	@RequestMapping(value="/service/{id}", method=RequestMethod.PUT)
	@ResponseBody
	public Msg update(User user){
		this.userService.updateByPrimaryKey(user);
		
		return Msg.success();
	}
	
	@RequestMapping(value="/service/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Msg get(@PathVariable("id") Integer id){
		User user = this.userService.getByPrimaryKey(id);
		
		return Msg.success().add("bean", user);
	}
}
