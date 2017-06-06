package com.i7colors.util;

import org.glassfish.jersey.filter.LoggingFilter;
import org.glassfish.jersey.server.ResourceConfig;

public class RestInit extends ResourceConfig {  
  
    public RestInit() {  
  
        packages("com.i7colors.resource");//包路径下符合要求的类将被发布成webservice  
        register(LoggingFilter.class);//注册logger  
        register(GsonJsonProvider.class);//注册json支持  
    }  
  
}  
