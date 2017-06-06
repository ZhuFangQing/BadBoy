package com.i7colors.test;


import com.google.gson.Gson;
import com.i7colors.util.DateUtils;
import com.i7colors.util.JerseyUtils;
import com.i7colors.util.PropertyUtils;
import org.glassfish.jersey.client.JerseyClient;
import org.glassfish.jersey.client.JerseyClientBuilder;
import org.glassfish.jersey.client.JerseyWebTarget;

import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Form;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;


public class Test {
	
	public static void get(){
		JerseyClient client = JerseyClientBuilder.createClient();
		JerseyWebTarget target = client.target("http://localhost:8080/info-app/service/information/talent_exchange");
        Response response = target.request().get();  
		System.out.println(response.readEntity(String.class));
	}
	
	//Form 表单 post提交
	public static void formPost(){
	    String url = "http://localhost:8080/info-app/service/information/textile_order";
	    JerseyClient client = JerseyClientBuilder.createClient();
	    JerseyWebTarget target = client.target(url);
	    Form form = new Form();
	    form.param("name", "111");
	    Response response = target.request().buildPost(Entity.entity(form, MediaType.APPLICATION_FORM_URLENCODED)).invoke();
	    System.out.println(response.readEntity(String.class));
	}
	
	//Form 表单json提交
		public static void jsonPost(){
		    String url = "http://localhost:8080/info-app/service/information/hot_information";
		    JerseyClient client = JerseyClientBuilder.createClient();
		    JerseyWebTarget target = client.target(url);
		    Map<String,Object> map = new HashMap<String, Object>();
		    map.put("name", "2333333");
		    map.put("name2", "2444444");
		    Response response = target.request().post(Entity.entity(new Gson().toJson(map).toString(), MediaType.APPLICATION_JSON));
		    System.out.println(response.readEntity(String.class));
		}

		public static void testGet(){


		}

	public static void main(String[] args) {
//		String str = JerseyUtils.get("http://localhost:8080/info-app/service/information/talent_exchange");
//		System.out.print(str);
//		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		String str[] = {"1","2","3"};
//		String str = "1@qq.com";
//		String str2 = str.substring(0,str.indexOf("@"));
//		String str3 = str.substring(str.indexOf("@"));
//		if(str2.length()>3){
//			str2 = str2.substring(0,str2.length()-3)+"***"+str3;
//		}else{
//			str2 ="***"+str3;
//		}
//		System.out.println(str2);

	}
}
