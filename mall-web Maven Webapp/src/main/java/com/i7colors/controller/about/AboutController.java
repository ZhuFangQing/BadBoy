package com.i7colors.controller.about;

import com.i7colors.controller.BaseController;
import com.i7colors.util.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Echos on 2016/11/29.
 */

@Controller
@RequestMapping
public class AboutController extends BaseController {

    @RequestMapping("/about")
    public ModelAndView about(@RequestParam(defaultValue="1") Integer t){
        return new ModelAndView("/about/about").addObject("t",t);
    }

    @RequestMapping("/i7Service")
    public ModelAndView i7Service(@RequestParam(defaultValue="1") Integer t){
        return new ModelAndView("/about/i7Service").addObject("t",t);
    }

    @RequestMapping("/i7Logistics")
    public ModelAndView i7Logistics(@RequestParam(defaultValue="1") Integer t){
        return new ModelAndView("/about/i7Logistics").addObject("t",t);
    }

    @RequestMapping("/i7CustomerService")
    public ModelAndView i7CustomerService(@RequestParam(defaultValue="1") Integer t){
        return new ModelAndView("/about/i7CustomerService").addObject("t",t);
    }

    @RequestMapping("/i7Partner")
    public ModelAndView i7Partner(@RequestParam(defaultValue="1") Integer t){
        return new ModelAndView("/about/i7Partner").addObject("t",t);
    }

}
