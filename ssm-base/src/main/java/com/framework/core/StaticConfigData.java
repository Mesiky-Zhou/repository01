package com.framework.core;

import java.util.HashMap;
import java.util.Map;

public class StaticConfigData {
	private static Map<String,Object> datas = new HashMap<>();
	
	static {
		String listConfigStr = "#:id,�û���:userName,�Ա�:gendar:colProcFunForGendar,����:email,����ʱ��:createTime";
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
