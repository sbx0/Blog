package service;

import dao.impl.StatusDaoImpl;
import dao.impl.UserDaoImpl;
import entity.User;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import java.util.List;

public class UserService {

    private UserDaoImpl userDao;
    private StatusDaoImpl statusDao;

    public void setStatusDao(StatusDaoImpl statusDao) {
        this.statusDao = statusDao;
    }

    public StatusDaoImpl getStatusDao() {
        return statusDao;
    }

    public void setUserDao(UserDaoImpl userDao) {
        this.userDao = userDao;
    }

    public UserDaoImpl getUserDao() {
        return userDao;
    }

    // 获取五个不重复的随机数
    public int[] random() {
        int[] randomNum = new int[5];
        randomNum[0] = (int) (Math.random() * 9 + 1);
        int temp;
        for (int i = 1; i < randomNum.length; ) {
            temp = (int) (Math.random() * 9 + 1);
            int j = 0;
            for (; j < i; j++) {
                if (temp == randomNum[j]) break;
            }
            if (j == i) {
                randomNum[i] = temp;
                i++;
            }
        }
        return randomNum;
    }

    // 删除账号
    public int delete(int id) {
        try {
            userDao.delete(id);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }

    // 登陆
    public boolean login(User user) {
        Boolean isRight = false;
        User userDatabase = userDao.login(user);
        if (userDatabase != null) {
            if (userDatabase.getUser_password().equals(user.getUser_password())) isRight = true;
        }
        return isRight;
    }

    // 判断邮件地址是否存在
    public boolean checkEmail(String email) {
        Boolean isExist = false;
        User user = new User();
        user.setUser_email(email);
        user = userDao.login(user);
        if (user != null) isExist = true;
        return isExist;
    }

    // 判断用户名是否存在
    public boolean checkName(String name) {
        Boolean isExist = false;
        User user = new User();
        user.setUser_name(name);
        user = userDao.check(user);
        if (user != null) isExist = true;
        return isExist;
    }

    // 注册
    public void register(User user) {
        userDao.register(user);
    }

    // 判断是否为管理员
    public boolean isAdmin(String email) {
        User user = new User();
        user.setUser_email(email);
        user = userDao.login(user);
        if (user.getUser_is_admin() == 1) {
            return true;
        } else {
            return false;
        }
    }

    // 根据email获取user
    public User getUser(String email) {
        User user = new User();
        user.setUser_email(email);
        user = userDao.login(user);
        return user;
    }

    // 根据id获取user
    public User getUser(int id) {
        return userDao.userById(id);
    }

    // 分页查询
    public PageBean queryForPage(int pageSize, int page) {
        int count = userDao.getCount(); // 总记录数
        int totalPage = PageBean.countTotalPage(pageSize, count); // 总页数
        int offset = PageBean.countOffset(pageSize, page); // 当前页开始记录
        int length = pageSize; // 每页记录数
        int currentPage = PageBean.countCurrentPage(page);
        List<User> list = userDao.queryForPage("From User user ORDER BY user.user_id DESC", offset, length); // 该分页的记录
        // 把分页信息保存到Bean中
        PageBean pageBean = new PageBean();
        pageBean.setPageSize(pageSize);
        pageBean.setCurrentPage(currentPage);
        pageBean.setAllRow(count);
        pageBean.setTotalPage(totalPage);
        pageBean.setList(list);
        pageBean.init();
        return pageBean;
    }

    // 将List<Code>中有用的东西转换成json串
    public JSONArray toJsonArray(List<User> users) {
        JSONArray jsonArray = new JSONArray();
        int i = 0;
        for (User a : users) {
            jsonArray.add(i, toJson(a));
            i++;
        }
        return jsonArray;
    }

    // 将code变成jsonObject
    public JSONObject toJson(User a) {
        // json config 配置 去除无效数据
        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object arg0, String arg1, Object arg2) {
                if (arg1.equals("user_birthday") || arg1.equals("time") || arg1.equals("user_email")
                        || arg1.equals("user_id") || arg1.equals("user_integral") || arg1.equals("user_is_admin")
                        || arg1.equals("user_name") || arg1.equals("user_password") || arg1.equals("user_register_time")
                        || arg1.equals("user_signature")) {
                    return false;
                } else {
                    return true;
                }
            }
        });
        JSONObject jsonObject = JSONObject.fromObject(a, config);
        return jsonObject;
    }

}
