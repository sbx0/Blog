package test;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import service.ArticleService;
import service.UserService;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Junit4Test {
    ApplicationContext context;
    ArticleService articleService;
    UserService userService;

    @Before
    public void before() {
        context = new ClassPathXmlApplicationContext("springConfig.xml");
        articleService = (ArticleService) context.getBean("articleService");
        userService = (UserService) context.getBean("userService");
    }

    @Test
    public void randomNum() {
        System.out.println("开始测试");
        int[] random = userService.random();
        for (int a : random) {
            System.out.println(a);
        }
    }

    @Test
    public void text() {
        for (int i = 0; i < 100; i++) {
            Date date = new Date();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmssS");
            String vsNum = simpleDateFormat.format(date);
            int randomNum = (int) (Math.random() * 899 + 100);
            vsNum += randomNum;
            System.out.println(vsNum);
        }
    }

    @Test
    public void textSimpleHtml() {
        String html = "<p style=\"text-indent: 2em;\">因为历史原因，有些图片还是http访问，会在后续的更新中修复。暂时自动跳转会出现端口号，这也会在以后的更新中修复。</p><p><img src=\"https://blog.ducsr.cn/upload/image/20171114/1510670722460088290.jpg\" title=\"1510670722460088290.jpg\" alt=\"截屏_20171114_224234-1.jpg\"/></p>";

        String result = articleService.imgResponsive("img", "img-responsive", html);

        System.out.println(result);

        result = articleService.imgResponsive("img", "img-responsive", result);

        System.out.println(result);

        result = articleService.imgResponsive("img", "img-responsive", result);

        System.out.println(result);

        result = articleService.imgResponsive("img", "img-responsive", result);

        System.out.println(result);


    }

    @After
    public void after() {

    }
}
