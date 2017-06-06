import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.domain.BaseResponse;
import org.glassfish.jersey.client.JerseyClient;
import org.glassfish.jersey.client.JerseyClientBuilder;
import org.glassfish.jersey.client.JerseyWebTarget;

import javax.ws.rs.client.Entity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Echos on 2016/11/24.
 */
public class JerseyTest {
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

    public static void main(String[] args) {
        String data = JerseyTest.get("http://192.168.11.59:8080/info-app/service/information/talent_exchange");

        System.out.println(data);
        BaseResponse baseResponse = new Gson().fromJson(data, new TypeToken<BaseResponse>(){}.getType());

        System.out.println((String) baseResponse.getData());
    }
}
