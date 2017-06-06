package com.i7colors.controller.user;

import com.i7colors.bean.user.CompanyInvoice;
import com.i7colors.commons.dto.JSONResult;
import com.i7colors.service.user.CompanyInvoiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by Echos on 2016/11/25.
 */
@Controller
@RequestMapping("/companies")
public class CompanyInvoiceController {

    @Autowired
    private CompanyInvoiceService companyInvoiceService;

    /**
     * 查看所有发票
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    @ResponseBody
    public JSONResult getAll() {
        List<CompanyInvoice> list = companyInvoiceService.getAll();
        return new JSONResult(true, "", list);
    }

    /**
     * 查看指定发票详情
     * @return
     */
    @RequestMapping(value = "/{invoiceId}", method = RequestMethod.GET)
    @ResponseBody
    public JSONResult get(@PathVariable Long invoiceId) {
        CompanyInvoice companyInvoice = companyInvoiceService.get(invoiceId);
        return new JSONResult(true, "", companyInvoice);
    }

    /**
     * 新增发票
     * @param companyInvoice
     * @return
     */
    @RequestMapping(value = "/", method = RequestMethod.POST)
    @ResponseBody
    public JSONResult add(@RequestParam CompanyInvoice companyInvoice) {
        boolean result = companyInvoiceService.add(companyInvoice);
        return new JSONResult(result);
    }

    /**
     * 更新发票信息
     * @param companyInvoice
     * @return
     */
    @RequestMapping(value = "/{invoiceId}", method = RequestMethod.PUT)
    @ResponseBody
    public JSONResult update(@PathVariable Long invoiceId, @RequestParam CompanyInvoice companyInvoice) {
        boolean result = companyInvoiceService.update(invoiceId, companyInvoice);
        return new JSONResult(result);
    }

    /**
     * 删除发票
     * @param invoiceId
     * @return
     */
    @RequestMapping(value = "/{invoiceId}", method = RequestMethod.DELETE)
    @ResponseBody
    public JSONResult delete(@PathVariable Long invoiceId) {
        boolean result = companyInvoiceService.delete(invoiceId);
        return new JSONResult(result);
    }
}
