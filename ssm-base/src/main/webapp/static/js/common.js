/**
 * 
 */

function request(reqMethod, urlStr,reqData,successFun,errorFun){
	$.ajax({
		url:urlStr,
		type:reqMethod,
		data:reqData,
		cache:false,
		success:successFun,
		error:errorFun
	});
}

function getRequest(urlStr,reqData,successFun,errorFun){
	request('GET', urlStr,reqData,successFun,errorFun);
}

function postRequest(urlStr,reqData,successFun,errorFun){
	request('POST', urlStr,reqData,successFun,errorFun);
}

function putRequest(urlStr,reqData,successFun,errorFun){
	reqData['_method'] = 'PUT';
	request('POST', urlStr,reqData,successFun,errorFun);
}

function deleteRequest(urlStr,reqData,successFun,errorFun){
	alert(urlStr);
	reqData['_method'] = 'DELETE';
	request('POST', urlStr,reqData,successFun,errorFun);
}

function gridColProcFun(colValue){
	return colValue;
}

