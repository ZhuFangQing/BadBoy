package com.i7colors.commons.dto;

/**
 * Created by Echos on 2016/11/21.
 */
public class JSONResult {
    private boolean result = false;
    private String msg;
    private Object data;

    public JSONResult() {
    }

    public JSONResult(boolean result) {
        this.result = result;
    }

    public JSONResult(boolean result, String msg, Object data) {
        this.result = result;
        this.msg = msg;
        this.data = data;
    }

    public boolean isResult() {
        return result;
    }

    public void setResult(boolean result) {
        this.result = result;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
