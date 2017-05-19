package com.gs.controller;

import ch.qos.logback.classic.Logger;
import com.gs.bean.User;
import com.gs.common.Constants;
import com.gs.common.bean.ControllerResult;
import com.gs.common.message.IndustrySMS;
import com.gs.common.util.SessionGetUtil;
import com.gs.service.CompanyService;
import com.gs.service.UserService;
import com.jh.email.Mail;
import com.jh.email.MailSender;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.mail.BodyPart;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;

/**
 * Created by WangGenshen on 5/17/16.
 */
@Controller
@RequestMapping("/")
public class IndexController {

    private Logger logger = (Logger) LoggerFactory.getLogger(IndexController.class);


    @Resource
    private CompanyService companyService;

    @Resource
    private UserService userService;

    @RequestMapping(value = "index", method = RequestMethod.GET)
    public ModelAndView index() {
        logger.info("进入首页");
        ModelAndView mav = new ModelAndView();
        mav.setViewName("index/index");
        mav.addObject("companys", companyService.queryByTop(6));
        return mav;
    }

    @RequestMapping(value = "adminHome", method = RequestMethod.GET)
    public String adminHome() {
        if (!SessionGetUtil.isUser()) {
            logger.info("Session已失效，请重新登入");
            return "index/index";
        }
        logger.info("进入管理员后台主页");
        return "index/home";
    }

    @RequestMapping(value = "customerHome", method = RequestMethod.GET)
    public String customerHome() {
        if (!SessionGetUtil.isUser()) {
            logger.info("Session已失效，请重新登入");
            return "index/index";
        }
        logger.info("进入车主后台主页");
        return "customerClient/home";
    }

    @ResponseBody
    @RequestMapping(value = "sub_me", method = RequestMethod.GET)
    public ControllerResult subscribeMe(String email) {
        User user = userService.queryAdmin();
        String to = user.getUserPhone();
        String smsContent = "【创意科技】尊敬的" + user.getUserName() + "管理员，您好，有用户订阅我们的平台，请尽快与他联系，用户邮箱：" + email;
        IndustrySMS is = new IndustrySMS(to, smsContent);
        is.execute();

        Mail mail = new Mail();
        mail.setRecipients(user.getUserEmail());
        mail.setSubject("订阅提醒");
        mail.setType(Mail.HTML);
        Multipart multipart = new MimeMultipart();
        BodyPart part1 = new MimeBodyPart();
        try {
            part1.setContent("<p>【创意科技】尊敬的" + user.getUserName() + "管理员，您好，有用户订阅我们的平台，请尽快与他联系，用户邮箱：" + email, mail.getType());
            multipart.addBodyPart(part1);
            mail.setMultipart(multipart);
        } catch (MessagingException e) {
        }
        MailSender mailSender = new MailSender();
        mailSender.sendEmailByType(Constants.MAIL_TYPE, mail, Constants.MAIL_SENDER, Constants.MAIL_PASSWORD);

        return ControllerResult.getSuccessResult("订阅成功，我们管理员会尽快与您联系");
    }

}
