package com.i7colors.util;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class JsonUtils {

	public static String replace(String json, String field, String content,
			String str, String str2) throws Exception {
		JSONObject jsonObject = new JSONObject(json);
		JSONArray array = (JSONArray) jsonObject.get("rows");
		JSONArray newArray = new JSONArray();
		for (int i = 0; i < array.length(); i++) {
			JSONObject o = (JSONObject) array.get(i);
			o.put(field, content.replace(str, o.getString(str2)));
			newArray.put(o);
		}
		jsonObject.put("rows", newArray);
		return jsonObject.toString();
	}

    public static String list2OJson(List<Map<String,Object>> list){
    	JSONArray array=new JSONArray(list);
    	return array.toString();
    }

	public static Map<String,Object> parseJSON2Map(String json) throws JSONException {
		Map<String,Object> reMap = new HashMap<String,Object>();
		JSONObject jsonObject ;
		JSONObject jTemp ;

		jsonObject = new JSONObject(json);
		String k ;
		@SuppressWarnings("unchecked")
		Iterator<String> keysIt = jsonObject.keys();
		while (keysIt.hasNext()){
			k = keysIt.next();
			Object v =  jsonObject.get(k);
			//如果内层还是数组的话，继续解析
			if(v instanceof JSONArray){
				List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
				for(int i = 0;i< ((JSONArray) v).length();i++){
					jTemp = ((JSONArray) v).getJSONObject(i);
					list.add(parseJSON2Map(jTemp.toString()));
				}
				reMap.put(k, list);
			}else if(v instanceof JSONObject){
				reMap.put(k,parseJSON2Map(v.toString()));
			}
			else {
				reMap.put(k, v);
			}
		}

		return reMap;
	}
	public static List<Map<String,Object>> parseJSON2List(String json) throws JSONException {
		List<Map<String,Object>> reList = new ArrayList<Map<String, Object>>();

		JSONArray jsonArray = new JSONArray(json);

		for(int i = 0;i< jsonArray.length();i++){
			Object v = jsonArray.get(i);
			if (v instanceof JSONObject ){
				reList.add(parseJSON2Map(v.toString()));
			}
		}

		return reList;
	}

	public static String listO2Json(List<Map<String, Object>> list) {
		JSONArray array = new JSONArray(list);
		return array.toString();

	}

	public static String map2Json(Map<String, Object> map) {
		JSONObject jsonObj = new JSONObject(map);
		return jsonObj.toString();
	}

	public static String map2json(Map<String, String> map) {
		JSONObject jsonObj = new JSONObject(map);
		return jsonObj.toString();
	}
}
