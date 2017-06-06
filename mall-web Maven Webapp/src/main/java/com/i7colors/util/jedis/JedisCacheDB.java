package com.i7colors.util.jedis;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import redis.clients.jedis.Jedis;

import java.util.Map;

/*
 * 类名：JedisCacheDB
 * 功能：对Redis进行缓存管理的纯管理类。 
 * 
 * 
 * */
public class JedisCacheDB {

	private static final Log logger = LogFactory.getLog(JedisCacheDB.class);
	
	public static Map<String,String> getAllFromHash(String key){
		Jedis jedis = null;
		Map<String,String> dataMap=null;
		try{
			jedis=JedisFactory.getJedis();
			dataMap=jedis.hgetAll(key);
		}catch(Exception e){
			logger.error("",e);
		}finally{
			JedisFactory.returnJedis(jedis);
		}
		return dataMap;
	}
	
	/*功能：保存对象到redis缓存数据库中。 
	 * expireSecond表示本会话的失效时间（多少秒），如果小于等于0，则表示永远不失效。
	 * 成功则返回true；失败则返回false
	*/
	public static boolean saveObject(String key, Object value, int expireSecond){
		//把字符串转换为byte[]	
		byte[] keyByte = key.getBytes();
		byte[] valueByte = SerializeUtil.serialize(value);
		if(keyByte==null || valueByte==null)
			return false;
		
		boolean bSuccess = false;
		
		//从redis中查找此keyByte。
		Jedis jedis = null;
		try{
			//得到一个可用的jedis
			jedis = JedisFactory.getJedis();
			jedis.set(keyByte, valueByte);
			
			//失效时间只有大于0时才设置
			if(expireSecond>0)
				jedis.expire(keyByte, expireSecond);
			
			bSuccess = true;
		}catch(Exception e){
			bSuccess = false;
			logger.error("JedisCacheDB的saveObject函数出现异常：",e);
			
		}finally{//返回用完的jedis
			JedisFactory.returnJedis(jedis);
		}
		
		return bSuccess;
	}
	
	
	//根据key到redis缓存数据库中查找对象；成功则返回对象，失败则返回null。
	public static Object getObject(String key){
		
		Object object = null;
		if (key==null){
			return null;
		}
		byte[] keyByte = key.getBytes();
		byte[] byteValue = null;
		
		//从redis中查找此keyByte 。
		Jedis jedis = null;
		try{
			//得到一个可用的jedis
			jedis = JedisFactory.getJedis();
			byteValue = jedis.get(keyByte);
			if(byteValue!=null)
				object = SerializeUtil.unserialize(byteValue);
		}catch(Exception e){
			object = null;
			logger.error("JedisCacheDB的getObject函数出现异常：",e);
			
		}finally{//返回用完的jedis
			JedisFactory.returnJedis(jedis);
		}
		
		
		return object;
	}
	
	//从redis缓存数据库中删除指定key对应的记录
	public static boolean deleteObject(String key){
		
		//把字符串转换为byte[]	
		byte[] keyByte = key.getBytes();		
		if(keyByte==null)
			return false;
		
		boolean bSuccess = false;
		
		//从redis中查找此keyByte。
		Jedis jedis = null;
		try{
			//得到一个可用的jedis
			jedis = JedisFactory.getJedis();			
			jedis.del(keyByte);			
			bSuccess = true;
		}catch(Exception e){
			bSuccess = false;
			logger.error("JedisCacheDB的deleteObject函数出现异常：",e);
			
		}finally{//返回用完的jedis
			JedisFactory.returnJedis(jedis);
		}
		
		return bSuccess;
	}
	
	
	public static  boolean expireObject(String key, int expireSecond){
		byte[] keyByte = key.getBytes();
		if(keyByte==null)
			return false;
		boolean bSuccess=true;
		Jedis jedis = null;
		try{
			//得到一个可用的jedis
			jedis = JedisFactory.getJedis();
			if(expireSecond>0)
				jedis.expire(keyByte, expireSecond);
		}catch(Exception e){
			bSuccess = false;
			logger.error("JedisCacheDB的expireObject函数出现异常：",e);
		}finally{//返回用完的jedis
			JedisFactory.returnJedis(jedis);
		}
		return bSuccess;
	}
	
	public static void main(String[] args) {
		System.out.println(getObject("BP_JSAPI_TICKET"));
	}
}
