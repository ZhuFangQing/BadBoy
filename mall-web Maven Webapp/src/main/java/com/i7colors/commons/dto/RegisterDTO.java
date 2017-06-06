package com.i7colors.commons.dto;

/**
 * Created by Echos on 2016/12/1.
 */
public class RegisterDTO {
    private String mobile;
    private String username;
    private String captcha;
    private String password;
    private String password_confirm;

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCaptcha() {
        return captcha;
    }

    public void setCaptcha(String captcha) {
        this.captcha = captcha;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword_confirm() {
        return password_confirm;
    }

    public void setPassword_confirm(String password_confirm) {
        this.password_confirm = password_confirm;
    }

    @Override
    public String toString() {
        return "RegisterDTO{" +
                "mobile='" + mobile + '\'' +
                ", username='" + username + '\'' +
                ", captcha='" + captcha + '\'' +
                ", password='" + password + '\'' +
                ", password_confirm='" + password_confirm + '\'' +
                '}';
    }
}
