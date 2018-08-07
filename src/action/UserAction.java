package action;

import entity.Code;
import entity.Data;
import entity.Message;
import entity.User;
import net.sf.json.JSONArray;
import service.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

public class UserAction extends BaseAction {
    private Message message;
    private User user;
    private String check;
    private String code;
    private int pageNo;
    private int pageSize = 10;
    private int id;
    private String url;

    private int num;
    private int bet;
    private String vsNum;

    public String count() {
        if (id > 0) {
            getJson().put("a_count", articleService.countByUser(id));
            getJson().put("c_count", commentService.countByUser(id));
            getJson().put("b_count", bugService.countByUser(id));
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public String send() {
        User user = loginUser();
        User to_user = userService.getUser(id);
        if (user.getUser_id() == id) {
            getJson().put("status", 1);
        } else if (to_user == null || user == null) {
            getJson().put("status", 2);
        } else {
            if (message.getContent().length() > 140) message.setContent(message.getContent().substring(0, 140));
            message.setSendTime(new Date());
            message.setSendUser(user);
            message.setReceiveUser(to_user);
            message.setIsRead(0);
            message.setType(0);
            messageService.send(message);
            getJson().put("status", 0);
        }
        return "json";
    }

    public String chat() {
        User user = loginUser();
        User send_user = userService.getUser(id);
        if (send_user == null || user == null) {
            getJson().put("status", 1);
        } else {
            List<Message> messages = messageService.chat(id, user.getUser_id());
            getJson().put("message", messageService.messagesJson(messages));
            getJson().put("user_name", send_user.getUser_name());
            getJson().put("user_id", id);
            getJson().put("my_id", user.getUser_id());
            getJson().put("status", 0);
        }
        return "json";
    }

    public String vsComputer() {
        user = loginUser();
        user = userService.getUser(user.getUser_id());
        int aiNum;
        int aiBet;
        String svsNum = (String) getSession().get("vsNum");
        int vsRound = (int) getSession().get("vsRound");
        if (!svsNum.equals(vsNum) || vsRound < 0 || vsRound > 3) {
            getJson().put("status", 2);
        } else if (vsRound > 3) {
            getJson().put("status", 1);
        } else {
            getJson().put("status", 0);
            // 狡猾的AI
            aiNum = (int) (Math.random() * 8 + 1);
            aiBet = (int) (Math.random() * 20 + (bet / 2));
            // 结算
            if (aiNum > num) {
                user.setUser_integral(user.getUser_integral() - bet);
                getJson().put("result", "<p class='text-danger'>失败</p><p>" + num + " < " + aiNum + "</p>");
                getJson().put("integral", "<p class='text-danger'>-" + bet + "</p>");
                userService.register(user);
            } else if (aiNum < num) {
                user.setUser_integral(user.getUser_integral() + aiBet);
                getJson().put("result", "<p class='text-success'>获胜</p><p>" + num + " > " + aiNum + "</p>");
                getJson().put("integral", "<p class='text-success'>+" + aiBet + "</p>");
                userService.register(user);
            } else {
                getJson().put("result", "<p class='text-info'>流局</p><p>" + num + " = " + aiNum + "</p>");
                getJson().put("integral", "<p class='text-info'>" + 0 + "</p>");
            }
            vsRound++;
            getSession().put("vsRound", vsRound);
            getJson().put("userIntegral", user.getUser_integral());
        }
        return "json";
    }

    public String betVSComputer() {
        // 用户的数字
        JSONArray userNumJson = new JSONArray();
        int[] userNum = userService.random();
        for (int i = 0; i < userNum.length; i++) {
            userNumJson.element(userNum[i]);
        }
        getJson().put("userNum", userNumJson);
        // 创建当前战局编号 session中存
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String vsNum = simpleDateFormat.format(date);
        int randomNum = (int) (Math.random() * 899 + 100);
        vsNum += randomNum;
        getJson().put("vsNum", vsNum);
        getSession().put("vsNum", vsNum);
        getSession().put("vsRound", 1);
        // 获取用户积分
        user = (User) getSession().get("user");
        user = userService.getUser(user.getUser_id());
        getJson().put("userIntegral", user.getUser_integral());
        return "json";
    }

    public String bet() {

        return "json";
    }

    // 更新用户信息
    public String update() {
        try {
            User newUser = user;
            userService.register(newUser);
            getJson().put("status", 0);
        } catch (Exception e) {
            getJson().put("status", 1);
        }
        return "json";
    }

    // 查看用户信息
    public String info() {
        user = userService.getUser(id);
        if (user == null) getRequest().put("user", null);
        else getRequest().put("user", user);
        return "info";
    }

    // 删除账户
    public String delete() {
        int status = 0;
        user = loginUser();
        if (user != null) {
            if (id == 0) id = user.getUser_id();
            if (user.getUser_is_admin() != 0 || user.getUser_id() == id) {
                try {
                    commentService.deleteByUser(id);
                    articleService.deleteByUser(id);
                    messageService.deleteByUser(id);
                    statusService.deleteByUser(id);
                    codeService.deleteByUser(id);
                    bugService.removeUser(id);
                    status = userService.delete(id);
                } catch (Exception e) {
                    status = 1;
                }
            } else if (user.getUser_id() != id) {
                status = 2;
            }
        } else {
            status = 3;
        }
        getJson().put("status", status);
        return "json";
    }

    // 查看消息
    public String message() {
        // 获取登陆信息
        User user = loginUser();
        List<Message> messages = messageService.receive(user.getUser_id());
        getJson().put("message", messageService.messagesJson(messages));
        return "json";
    }

    // 登陆
    public String login() {
        // 密码哈希
        user.setUser_password(PasswordHash.getHash(user.getUser_password(), "MD5"));
        if (userService.login(user)) {
            getJson().put("status", 1);
            user = userService.getUser(user.getUser_email());
            if (user.getUser_name().length() >= 6) {
                user.setUser_name(user.getUser_name().substring(0, 5) + "...");
            }
            getSession().put("user", user);

            // 在线列表
            List userOlList;
            if (context.getAttribute("userOlList") == null) {
                userOlList = new ArrayList();
                userOlList.add(user.getUser_id());
            } else {
                userOlList = (List) context.getAttribute("userOlList");
                int i;
                for (i = 0; i < userOlList.size(); i++) {
                    if (user.getUser_id() == userOlList.get(i)) break;
                }
                if (i == userOlList.size()) {
                    userOlList.add(user.getUser_id());
                }
            }
            context.setAttribute("userOlList", userOlList);

            // 获取当前在线人数
            long userCount = userOlList.size();

            if (userCount < 0L) userCount = 0L;

            // > 1 保存当前在线人数
            if (userCount > 0L) {
                Data data = new Data();
                data.setName("登陆统计");
                data.setDescription("统计登陆人数");
                data.setType(1);
                data.setData(userCount);
                data.setUpdate_time(new Date());
                dataService.saveOrUpdate(data);
            }

        } else {
            getJson().put("status", 0);
        }
        return "json";
    }

    // 验证邮箱地址是否重复
    public String checkEmail() {
        if (userService.checkEmail(check)) {
            getJson().put("status", 1);
        } else {
            getJson().put("status", 0);
        }
        return "json";
    }

    // 验证姓名是否重复
    public String checkName() {
        if (userService.checkName(check)) {
            getJson().put("status", 1);
        } else {
            getJson().put("status", 0);
        }
        return "json";
    }

    // 注册
    public String register() {
        // 判断用户信息是否完整，JS验证太垃圾
        // 判断是否完整输入注册信息 以及判断注册信息是否重复
        if (user.getUser_name().length() == 0 || user.getUser_email().length() == 0) {
            // 状态码 2 注册信息不全
            getJson().put("status", 2);
        } else if (user.getUser_name() == null || user.getUser_email() == null || user.getUser_password() == null) {
            // 状态码 2 注册信息不全
            getJson().put("status", 2);
        } else if (userService.checkName(user.getUser_name()) || userService.checkEmail(user.getUser_email())) {
            // 状态码 3 注册信息重复
            getJson().put("status", 3);
        } else {
            user.setUser_is_admin(0);
            user.setUser_register_time(new Date());
            user.setUser_birthday(new Date());
            user.setUser_signature("暂无签名");
            user.setUser_integral(0.0);
            // 密码哈希
            user.setUser_password(PasswordHash.getHash(user.getUser_password(), "MD5"));
            try {
                userService.register(user);
                // 注册成功
                getJson().put("status", 0);
            } catch (Exception e) {
                // 注册失败 未知原因
                getJson().put("status", 1);
            }
        }
        return "json";
    }

    // 退出登录
    public String logout() {
        try {
            User user = loginUser();
            getSession().remove("user");
            getJson().put("status", 0);

            // 在列表中删除
            if (context.getAttribute("userOlList") != null) {
                List userOlList = (List) context.getAttribute("userOlList");
                int i;
                for (i = 0; i < userOlList.size(); i++) {
                    if (user.getUser_id() == userOlList.get(i))
                        userOlList.remove(i);
                }
                context.setAttribute("userOlList", userOlList);
            }

        } catch (Exception e) {
            getJson().put("status", 1);
        }
        return "json";
    }

    // 激活码激活
    public String active() {
        User user = loginUser();
        if (user != null) {
            Code codes = codeService.query(code);
            if (codes != null) {
                if (codeService.active(codes, user) == 0) {
                    // 状态 0  默认状态 激活成功
                    getJson().put("status", 0);
                } else if (codeService.active(codes, user) == 1) {
                    // 状态 3 激活码已过期
                    getJson().put("status", 3);
                }
            } else {
                // 状态 2 激活码不存在
                getJson().put("status", 2);
            }
        } else {
            // 状态 1 未登录
            getJson().put("status", 1);
        }
        return "json";
    }

    // 抽奖
    public String gif() {
        int[] gifnum = codeService.gif();
        User user = loginUser();
        Long use = 15L;
        String desc = "null";
        // 未登录永远是空
        if (user != null) {
            user = userService.getUser(user.getUser_id());
            if (user.getUser_integral() - use >= 0L) {
                user.setUser_integral(user.getUser_integral() - use);
                switch (gifnum[0]) {
                    case 0:
                        getJson().put("info", "消耗 " + use + " 积分，剩余 " + user.getUser_integral() + " 积分。");
                        break;
                    case 1:
                        user.setUser_integral(user.getUser_integral() + use + use / 3L);
                        getJson().put("info", "获得 " + use / 3L + " 积分，剩余 " + user.getUser_integral() + " 积分。");
                        break;
                    case 2:
                        user.setUser_integral(user.getUser_integral() + use + use / 2L);
                        Code c2 = new Code();
                        c2.setName("会员码：7天");
                        c2.setEffect("获得7天的会员");
                        c2.setCode(codeService.code());
                        c2.setCreate_time(new Date());
                        c2.setStop_time(new Date());
                        c2.setUser(user);
                        GregorianCalendar gc2 = new GregorianCalendar();
                        gc2.setTime(c2.getCreate_time());
                        gc2.add(2, 1);
                        c2.setStop_time(gc2.getTime());
                        codeService.update(c2);
                        c2.setName("会员码：7天 + " + use / 2L + " 积分");
                        getJson().put("code", codeService.codeJson(c2));
                        desc = user.getUser_name() + " 获得了 " + c2.getName();
                        break;
                    case 3:
                        user.setUser_integral(user.getUser_integral() + use + use);
                        Code c3 = new Code();
                        c3.setName("会员码：30天");
                        c3.setEffect("获得30天的会员");
                        c3.setCode(codeService.code());
                        c3.setCreate_time(new Date());
                        c3.setStop_time(new Date());
                        c3.setUser(user);
                        GregorianCalendar gc3 = new GregorianCalendar();
                        gc3.setTime(c3.getCreate_time());
                        gc3.add(2, 1);
                        c3.setStop_time(gc3.getTime());
                        codeService.update(c3);
                        c3.setName("会员码：30天 + " + use + " 积分");
                        getJson().put("code", codeService.codeJson(c3));
                        desc = user.getUser_name() + " 获得了 " + c3.getName();
                        break;
                    case 4:
                        user.setUser_integral(user.getUser_integral() + use + use * use);
                        Code c4 = new Code();
                        c4.setName("欧皇称号");
                        c4.setEffect("获得欧皇称号");
                        c4.setCode(codeService.code());
                        c4.setCreate_time(new Date());
                        c4.setStop_time(new Date());
                        c4.setUser(user);
                        GregorianCalendar gc4 = new GregorianCalendar();
                        gc4.setTime(c4.getCreate_time());
                        gc4.add(2, 1);
                        c4.setStop_time(gc4.getTime());
                        codeService.update(c4);
                        c4.setName("欧皇 + " + use * use + " 积分");
                        getJson().put("code", codeService.codeJson(c4));
                        desc = user.getUser_name() + " 获得了 " + c4.getName();
                        break;
                    default:
                        break;
                }

                // 保存抽奖数据
                if (!desc.equals("null")) {
                    Data data = new Data();
                    data.setName("中奖记录");
                    data.setDescription(desc);
                    data.setUpdate_time(new Date());
                    data.setType(2);
                    data.setData(Long.parseLong(user.getUser_id() + ""));
                    dataService.saveOrUpdate(data);
                }

                userService.register(user);
                getJson().put("num1", gifnum[1]);
                getJson().put("num2", gifnum[2]);
                getJson().put("status", 0);

            } else {
                getJson().put("status", 1);
            }
        } else {
            getJson().put("status", 2);
        }
        return "json";
    }

    // 最近获得的激活码
    public String codes() {
        User user = loginUser();
        if (user != null) {
            List<Code> codes = (List<Code>) codeService.queryForPage(pageSize, pageNo, user.getUser_id()).getList();
            getJson().put("codes", codeService.codesJson(codes));
        }
        return "json";
    }

    // 消息确认
    public String know() {
        try {
            messageService.read(id);
            getJson().put("status", 0);
        } catch (Exception e) {
            getJson().put("status", 1);
        }
        return "json";
    }

    // 未读消息数
    public String unreadCount() {
        User user = loginUser();
        if (user == null) {
            getJson().put("status", 1);
        } else {
            try {
                int count = messageService.count(user.getUser_id());
                getJson().put("count", count);
                getJson().put("status", 0);
            } catch (Exception e) {
                getJson().put("status", 2);
            }
        }
        return "json";
    }

    public String i18N() {
        getJson().put("status", 0);
        return "json";
    }

    public Message getMessage() {
        return message;
    }

    public void setMessage(Message message) {
        this.message = message;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getCheck() {
        return check;
    }

    public void setCheck(String check) {
        this.check = check;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getBet() {
        return bet;
    }

    public void setBet(int bet) {
        this.bet = bet;
    }

    public String getVsNum() {
        return vsNum;
    }

    public void setVsNum(String vsNum) {
        this.vsNum = vsNum;
    }
}