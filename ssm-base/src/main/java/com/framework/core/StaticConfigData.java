package com.framework.core;

import java.util.HashMap;
import java.util.Map;

public class StaticConfigData {
	private static Map<String,Object> datas = new HashMap<>();
	
	static {
		String listConfigStr = "#:id,用户名:userName,性别:gendar:colProcFunForGendar,邮箱:email,创建时间:createTime";
		ListConfig userListConfig = new ListConfig(listConfigStr);
		StaticConfigData.add("sysmgr.user.listconfig", userListConfig);
		
	}
	
	public static Object getByKey(String key){
		return datas.get(key);
	}
	
	public static void add(String key, Object value){
		datas.put(key, value);
	}
	

}
