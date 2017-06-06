package com.i7colors.controller.kefu;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.i7colors.bean.trade.Balance;
import com.i7colors.bean.trade.Credit;
import com.i7colors.bean.trade.ParentOrder;
import com.i7colors.bean.trade.PaymentInfo;
import com.i7colors.controller.BaseController;
import com.i7colors.domain.BaseResponse;
import com.i7colors.domain.PageResponse;
import com.i7colors.enums.BusinessType;
import com.i7colors.enums.OrderStatus;
import com.i7colors.enums.ResultCode;
import com.i7colors.util.Logger;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Echos on 2016/12/6.
 */
@Controller
@RequestMapping("/kefu")
public class KeFuController extends BaseController {
    /**
     * 跳转到客服页面
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView goList() {
        Logger.info(this, "跳转到客服页面" );
        return new ModelAndView("/kefu/kefu");
    }

}
