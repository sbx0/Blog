package service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class CookieService {
    HttpServletRequest request;
    HttpServletResponse response;
    Cookie cookie;

    public void setCookie(String c_name, String value, int day) {
        cookie = new Cookie("cookiename", "cookievalue");

        cookie.setMaxAge(day * 24 * 60 * 60);

        // 设置路径，这个路径即该工程下都可以访问该cookie 如果不设置路径，那么只有设置该cookie路径及其子路径可以访问

        cookie.setPath("/");

        response.addCookie(cookie);
    }
}
