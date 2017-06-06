package com.i7colors.util;

import com.google.gson.Gson;
import org.glassfish.jersey.client.JerseyClient;
import org.glassfish.jersey.client.JerseyClientBuilder;
import org.glassfish.jersey.client.JerseyWebTarget;

import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Form;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.Map;

/**
 * Created by Max
 */
public class JerseyUtils {

	public static String get(String url){
        JerseyClient client = JerseyClientBuilder.createClient();
        JerseyWebTarget target = client.target(url);
        Response response = target.request().get();
        return response.readEntity(String.class);
    }

    public static String post(String url,Map<String,Object> map) {
        Gson gson  = new Gson();
        String json = gson.toJson(map);
        JerseyClient client = JerseyClientBuilder.createClient();
        JerseyWebTarget target = client.target(url);
        Response response = target.request().post(Entity.entity(json, MediaType.APPLICATION_JSON));
        return response.readEntity(String.class);
    }

    public static String post(String url,Form form) {
        JerseyClient client = JerseyClientBuilder.createClient();
        JerseyWebTarget target = client.target(url);
        Response response = target.request().buildPost(Entity.entity(form, MediaType.APPLICATION_FORM_URLENCODED)).invoke();
        return response.readEntity(String.class);
    }
}
