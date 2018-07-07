package service;

import dao.impl.CodeDaoImpl;
import dao.impl.StatusDaoImpl;
import entity.Code;
import entity.Status;
import entity.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

public class CodeService {
    private CodeDaoImpl codeDao;
    private StatusDaoImpl statusDao;

    public void setStatusDao(StatusDaoImpl statusDao) {
        this.statusDao = statusDao;
    }

    public StatusDaoImpl getStatusDao() {
        return statusDao;
    }

    public void setCodeDao(CodeDaoImpl codeDao) {
        this.codeDao = codeDao;
    }

    public CodeDaoImpl getCodeDao() {
        return codeDao;
    }

    // 删除用户激活码
    public int deleteByUser(int id) {
        try {
            codeDao.deleteByUser(id);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }

    // 新增/修改激活码
    public void update(Code code) {
        codeDao.update(code);
    }

    // 删除激活码
    public void delete(int id) {
        codeDao.delete(id);
    }

    // 查询激活码
    public Code query(int id) {
        return codeDao.query(id);
    }

    public Code query(String code) {
        return codeDao.query(code);
    }

    public List<Code> query(User user) {
        return codeDao.query(user);
    }

    // 分页查询
    public PageBean queryForPage(int pageSize, int page, int id) {
        int count = codeDao.getCount(id); // 总记录数
        int totalPage = PageBean.countTotalPage(pageSize, count); // 总页数
        int offset = PageBean.countOffset(pageSize, page); // 当前页开始记录
        int length = pageSize; // 每页记录数
        int currentPage = PageBean.countCurrentPage(page);
        // 该分页的记录
        List<Code> list = codeDao.queryForPage("From Code c Where c.user.user_id = " + id + " ORDER BY c.id DESC", offset, length);
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

    // 抽奖
    public int[] gif() {
        int[] gifnum = new int[3];
        int num1 = (int) (Math.random() * 89999 + 10000);
        int num2 = (int) (Math.random() * 89999 + 10000);
        gifnum[1] = num1;
        gifnum[2] = num2;
        for (int i = 0; i < 5; i++) {
            if ((num1 % 10 == num2 % 10)) {
                gifnum[0]++;
            }
            num1 = num1 / 10;
            num2 = num2 / 10;
        }
        return gifnum;
    }

    // 激活码生成
    public String code() {
        int codeNum;
        char codeChat;
        String code = "";
        for (int i = 0; i < 15; i++) {
            if ((int) (Math.random() * 2 + 1) == 1) {
                codeNum = (int) (Math.random() * 25 + 65);
            } else {
                codeNum = (int) (Math.random() * 9 + 48);
            }
            codeChat = (char) codeNum;
            code += codeChat;
            if (i == 4 || i == 9) {
                code += "-";
            }
        }
        if (query(code) != null) {
            return code();
        } else {
            return code;
        }
    }

    // 激活码激活
    public int active(Code code, User user) {
        if (code.getStop_time().getTime() < new Date().getTime()) {
            codeDao.delete(code.getId());
            return 1;
        }
        Status status = new Status();
        GregorianCalendar gc = new GregorianCalendar();
        switch (code.getName()) {
            case "会员码：7天":
                if (statusDao.queryByNameAndUser("VIP", user.getUser_id()) != null) {
                    status = statusDao.queryByNameAndUser("VIP", user.getUser_id());
                    gc.setTime(status.getStop_time());
                    gc.add(3, 1);
                    status.setStop_time(gc.getTime());
                } else {
                    status.setUser(user);
                    status.setName("VIP");
                    status.setStart_time(new Date());
                    gc.setTime(status.getStart_time());
                    gc.add(3, 1);
                    status.setStop_time(gc.getTime());
                }
                break;
            case "会员码：30天":
                if (statusDao.queryByNameAndUser("VIP", user.getUser_id()) != null) {
                    status = statusDao.queryByNameAndUser("VIP", user.getUser_id());
                    gc.setTime(status.getStop_time());
                    gc.add(2, 1);
                    status.setStop_time(gc.getTime());
                } else {
                    status.setUser(user);
                    status.setName("VIP");
                    status.setStart_time(new Date());
                    gc.setTime(status.getStart_time());
                    gc.add(2, 1);
                    status.setStop_time(gc.getTime());
                }
                break;
            case "欧皇":
                if (statusDao.queryByNameAndUser("欧皇", user.getUser_id()) != null) {
                    status = statusDao.queryByNameAndUser("欧皇", user.getUser_id());
                    gc.setTime(status.getStop_time());
                    gc.add(1, 1);
                    status.setStop_time(gc.getTime());
                } else {
                    status.setUser(user);
                    status.setName("欧皇");
                    status.setStart_time(new Date());
                    gc.setTime(status.getStart_time());
                    gc.add(1, 50);
                    status.setStop_time(gc.getTime());
                }
                break;
            default:
                break;
        }
        statusDao.saveOrUpdate(status);
        codeDao.delete(code.getId());
        return 0;
    }

    // 将List<Code>中有用的东西转换成json串
    public JSONArray codesJson(List<Code> codes) {
        JSONArray jsonArray = new JSONArray();
        int i = 0;
        for (Code c : codes) {
            jsonArray.add(i, codeJson(c));
            i++;
        }
        return jsonArray;
    }

    // 将code变成jsonObject
    public JSONObject codeJson(Code c) {
        // json config 配置 去除无效数据
        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object arg0, String arg1, Object arg2) {
                if (arg1.equals("codes") || arg1.equals("code") || arg1.equals("create_time")
                        || arg1.equals("time") || arg1.equals("effect") || arg1.equals("id")
                        || arg1.equals("name") || arg1.equals("state") || arg1.equals("stop_time")
                        || arg1.equals("user") || arg1.equals("user_id")) {
                    return false;
                } else {
                    return true;
                }
            }
        });
        JSONObject jsonObject = JSONObject.fromObject(c, config);
        return jsonObject;
    }
}
