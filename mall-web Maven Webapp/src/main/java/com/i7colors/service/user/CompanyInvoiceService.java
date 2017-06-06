package com.i7colors.service.user;

import com.i7colors.bean.user.CompanyInvoice;
import com.i7colors.remoteService.AbstractRemoteService;
import com.i7colors.util.PropertyUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Echos on 2016/11/25.
 */
@Service
public class CompanyInvoiceService extends AbstractRemoteService {
    private Logger logger = Logger.getLogger(this.getClass());

    @Override
    public String getAppHost() {
        return PropertyUtils.getProperty("userAppServiceHost");
    }

    /**
     * 查看所有发票
     * @return
     */
    public List<CompanyInvoice> getAll(){
        List<CompanyInvoice> companyInvoiceList = new ArrayList<CompanyInvoice>();

        CompanyInvoice companyInvoice = new CompanyInvoice();
        companyInvoice.setTitle("发票1");
        companyInvoiceList.add(companyInvoice);

        companyInvoice = new CompanyInvoice();
        companyInvoice.setTitle("发票2");
        companyInvoiceList.add(companyInvoice);

        return companyInvoiceList;
    }

    /**
     * 查看指定发票详情
     * @param invoiceId
     * @return
     */
    public CompanyInvoice get(Long invoiceId){
        CompanyInvoice companyInvoice = new CompanyInvoice();
        companyInvoice.setTitle("发票" + invoiceId);

        return companyInvoice;
    }

    /**
     * 新增发票
     * @param companyInvoice
     * @return
     */
    public boolean add(CompanyInvoice companyInvoice){
        logger.info("新增发票：" + companyInvoice);
        return true;
    }

    /**
     * 更新发票
     * @param invoiceId
     * @param companyInvoice
     * @return
     */
    public boolean update(Long invoiceId, CompanyInvoice companyInvoice){
        logger.info("更新发票：" + companyInvoice);
        return true;
    }

    /**
     * 更新发票
     * @param invoiceId
     * @return
     */
    public boolean delete(Long invoiceId){
        logger.info("删除发票：" + invoiceId);
        return true;
    }
}
