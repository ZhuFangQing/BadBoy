package com.i7colors.controller.tool;

import com.google.gson.Gson;
import com.i7colors.domain.BaseResponse;
import com.i7colors.enums.ResultCode;
import com.i7colors.filter.UserFilter;
import com.i7colors.util.ExceptionUtil;
import com.i7colors.util.Logger;
import com.i7colors.util.PropertyUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

/**
 * Created by Echos on 2017/1/11.
 */

@Controller
@RequestMapping("/tools")
public class ToolController {
	
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/displayRLZIP", method = RequestMethod.GET)
    public
    @ResponseBody
    Object displayRLZIP(HttpServletRequest req) {
		BaseResponse resp = new BaseResponse();

		resp.setMsg(req.getRemoteAddr());

		return new Gson().toJson(resp);
    }
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/setRLZGameIP", method = RequestMethod.GET)
    public
    @ResponseBody
    Object setRLZGameIP(@RequestParam String ip) {
    	BaseResponse resp = new BaseResponse();

        try {

        	UserFilter.RLZGameIP = ip;
        } catch (Exception ex) {
            resp.setCode(ResultCode.FAIL);
            resp.setMsg(ExceptionUtil.getExceptionStr(ex));
        }

        return new Gson().toJson(resp);
    }
    
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getRLZGameIP", method = RequestMethod.GET)
	public @ResponseBody
	Object getRLZGameIP() {

		BaseResponse resp = new BaseResponse();

		resp.setMsg(UserFilter.RLZGameIP);

		return new Gson().toJson(resp);
	}
	
	

    @SuppressWarnings("rawtypes")
	@RequestMapping(value = "/setRLZIP", method = RequestMethod.GET)
    public
    @ResponseBody
    Object setRLZIP(@RequestParam String ip) {
    	BaseResponse resp = new BaseResponse();

        try {

        	UserFilter.RLZIP = ip;
        } catch (Exception ex) {
            resp.setCode(ResultCode.FAIL);
            resp.setMsg(ExceptionUtil.getExceptionStr(ex));
        }

        return new Gson().toJson(resp);
    }
    
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getRLZIP", method = RequestMethod.GET)
	public @ResponseBody
	Object getRLZIP() {

		BaseResponse resp = new BaseResponse();

		resp.setMsg(UserFilter.RLZIP);

		return new Gson().toJson(resp);
	}
	

    /**
     * pdf预览
     */
    @RequestMapping("/pdfViewer")
    public ModelAndView pdfViewer(){
        return new ModelAndView("/common/pdfViewer");
    }

    /**
     * 读取远程PDF文件，解决跨域问题
     * @param file
     * @param response
     */
    @RequestMapping("/pdfOutput")
    public void pdfOutput(String file, HttpServletResponse response){

        response.addHeader("pragma","NO-cache");
        response.addHeader("Cache-Control","no-cache");
        response.addDateHeader("Expries",0);
        response.setContentType("application/application/pdf;charset=utf-8");

        if (StringUtils.isNotEmpty(file)) {

            ServletOutputStream out;
            try {

                // 通过文件路径获得File对象
                URL url = new URL(file);

                //检查pdf地址是否在白名单
                if(!pdfHostsCheck(url.getHost())) return;

                //读取网络文件
                URLConnection conn = url.openConnection();
                conn.setConnectTimeout(3000);
                conn.setReadTimeout(10000);
                InputStream inputStream = conn.getInputStream();

                //通过response获取ServletOutputStream对象(out)
                out = response.getOutputStream();

                int b = 0;
                byte[] buffer = new byte[1024];
                while ((b = inputStream.read(buffer)) != -1) {
                    //写到输出流(out)中
                    out.write(buffer, 0, b);
                }

                inputStream.close();
                out.flush();
                out.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    /**
     * 检查pdf地址是否在白名单
     * @param origin
     * @return
     */
    private boolean pdfHostsCheck(String origin){
        if(StringUtils.isEmpty(origin)){
            return false;
        }
        boolean result = false;

        String str = PropertyUtils.getProperty("pdf_allow_hosts");
        if(StringUtils.isNotEmpty(str)){
            String[] allows = str.split(",");

            for(String host : allows){
                if(origin.endsWith(host)){
                    result = true;
                    break;
                }
            }
        }

        return result;
    }
}
