package com.framework.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.framework.bean.Dept;
import com.framework.core.Msg;
import com.framework.service.DeptService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/sysmgr/dept")
public class DeptController {
	@Autowired
	DeptService deptService;

	
	
	@RequestMapping("/service/listWithNoPage")
	@ResponseBody
	public Msg listWithNoPage(
			Map<String,Object> map){
		List<Dept> list = this.deptService.getAll();
		
		return  Msg.success().add("list", list);
	}
	
	@RequestMapping("/service/list")
	@ResponseBody
	public Msg list(@RequestParam(value="pageNo",defaultValue="1") int pageNo,
			Map<String,Object> map){
		PageHelper.startPage(pageNo, 6);
		List<Dept> list = this.deptService.getAll();
		PageInfo<Dept> pageInfo = new PageInfo<Dept>(list,5);
		
		return  Msg.success().add("pageInfo", pageInfo);
	}
}
