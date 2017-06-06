package com.i7colors.util;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Date;

/**
 * Created by Max on 2016/12/12.
 */
public class FTPFileUploadUtils {

    private static String username = PropertyUtils.getProperty("ftpUsername");
    private static String password = PropertyUtils.getProperty("ftpPassword");
    private static String addr = PropertyUtils.getProperty("ftpAddr");
    private static int port = Integer.parseInt(PropertyUtils.getProperty("ftpPort"));

    /**
     * @param path 上传到ftp服务器哪个路径下
     * @return
     * @throws Exception
     */
    public static String uploadFile(String path, MultipartFile file) {
        FTPClient ftp = new FTPClient();
        int reply;
        try {
            String end =file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            String filename = System.currentTimeMillis() + NonceStrUtils.generateCommonStr(6)+end;
            CommonsMultipartFile cf = (CommonsMultipartFile) file;
            DiskFileItem fi = (DiskFileItem) cf.getFileItem();
            File f = fi.getStoreLocation();
            ftp.connect(addr, port);
            ftp.login(username, password);
            reply = ftp.getReplyCode();
            if (!FTPReply.isPositiveCompletion(reply)) {
                ftp.disconnect();
            }
            ftp.setControlEncoding("UTF-8");
            ftp.setFileType(FTPClient.BINARY_FILE_TYPE);
//            ftp.enterRemotePassiveMode();
            ftp.enterLocalPassiveMode();
            if (!ftp.changeWorkingDirectory(path)) {

                if (ftp.makeDirectory(path)) {

                    ftp.changeWorkingDirectory(path);
                }
            }
            if(upload(ftp, f,filename)){
                Logger.info("Daniel"+filename);
                 return "/"+path+"/"+filename;
            }
        } catch (IOException e) {
            e.printStackTrace();
            Logger.error("", e);
        }
        return null;
    }

    /**
     * @param ftp  ftp客户端实例
     * @param file 上传的文件或文件夹
     * @return 错误信息（为空表示成功）
     * @throws Exception
     */
    public static Boolean upload(FTPClient ftp, File file,String filename) {
        try {
            FileInputStream input = new FileInputStream(file);
            ftp.storeFile(filename, input);
            input.close();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            Logger.error("", e);
            return false;
        }
    }

    public static void main(String[] args) {
        File file = new File("D:\\税务登记.jpg");
//        uploadFile("company", file,"111");
    }
}
