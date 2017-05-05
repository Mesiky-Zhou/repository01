/**
 * 
 */

//定义页面全局变量
var totalRecord;//总记录数
var currentPage;//当前页面
var selectRowId;//当前选择行的ID
var selectRowData = [];//当前选择的行

function bindEvent(){
	$("#btn_add").click(function(){
		open_ui_add();
	});
	
	$("#btn_delete").click(function(){
		batchDelete();
	});
	
	$("#ui_add_btn_ok").click(function(){
		save_and_close();
	});
}

function batchDelete(){
	var idArr = getCheckIds();
	if(idArr.length<=0){
		alert("请至少选择1条记录！");
	}else{
		var ids = '';
		for(var i=0;i<idArr.length;i++){
			ids = ids +  idArr[i] + '-';
		}
		ids = ids.substring(0, ids.length-1);
		
		if(confirm('确认删除选择记录吗？')){
			alert(ids);
			deleteRequest('${APP_PATH}/sysmgr/user/service/delete',{ids:ids},function(result){
				alert(result.desc);
				initPage(currentPage);
			});
		}
	}
}

function getCheckIds(){
	var ids = [];
	var checks = $("#table_list tbody").find(".checkItem:checked");
	$.each(checks, function(index, item){
		ids[index] = $(item).val();
	});
	
	return ids;
}