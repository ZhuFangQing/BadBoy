package com.i7colors.commons.dto;

/**
 * Created by Echos on 2016/11/22.
 */
public class CreateOrder {
    //收货信息
    private String delivery_province;
    private String delivery_city;
    private String delivery_area;
    private String delivery_address;
    private String delivery_people_name;
    private String tel_1;

    //发票信息
    private String[] invoices;

    //商品
    private String productIds;

    //使用余额
    private Float useBalance;

    public String getDelivery_province() {
        return delivery_province;
    }

    public void setDelivery_province(String delivery_province) {
        this.delivery_province = delivery_province;
    }

    public String getDelivery_city() {
        return delivery_city;
    }

    public void setDelivery_city(String delivery_city) {
        this.delivery_city = delivery_city;
    }

    public String getDelivery_area() {
        return delivery_area;
    }

    public void setDelivery_area(String delivery_area) {
        this.delivery_area = delivery_area;
    }

    public String getDelivery_address() {
        return delivery_address;
    }

    public void setDelivery_address(String delivery_address) {
        this.delivery_address = delivery_address;
    }

    public String getDelivery_people_name() {
        return delivery_people_name;
    }

    public void setDelivery_people_name(String delivery_people_name) {
        this.delivery_people_name = delivery_people_name;
    }

    public String getTel_1() {
        return tel_1;
    }

    public void setTel_1(String tel_1) {
        this.tel_1 = tel_1;
    }

    public String[] getInvoices() {
        return invoices;
    }

    public void setInvoices(String[] invoices) {
        this.invoices = invoices;
    }

    public String getProductIds() {
        return productIds;
    }

    public void setProductIds(String productIds) {
        this.productIds = productIds;
    }

    public Float getUseBalance() {
        return useBalance;
    }

    public void setUseBalance(Float useBalance) {
        this.useBalance = useBalance;
    }
}
