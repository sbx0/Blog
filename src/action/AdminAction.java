package action;

import entity.Article;
import entity.Comment;
import entity.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.*;

import java.util.List;

public class AdminAction extends BaseAction {
    private int pageSize;
    private int page;
    private String veid;
    private String api_key;

    public String article() {
        if (pageSize > 10000000) pageSize = 10000000;
        List<Article> articles = articleService.queryForPage(pageSize, page).getList();
        JSONArray tableTitle = new JSONArray();
        tableTitle.add("#");
        tableTitle.add("标题");
        tableTitle.add("作者");
        tableTitle.add("发表时间");
        tableTitle.add("浏览数");
        tableTitle.add("评论数");
        tableTitle.add("操作");
        getJson().put("body", articleService.articlesJson(articles));
        getJson().put("title", tableTitle);
        return "json";
    }

    public String user() {
        if (pageSize > 10000000) pageSize = 10000000;
        List<User> users = userService.queryForPage(pageSize, page).getList();
        JSONArray tableTitle = new JSONArray();
        tableTitle.add("#");
        tableTitle.add("用户名");
        tableTitle.add("邮箱");
        tableTitle.add("密码");
        tableTitle.add("权限");
        tableTitle.add("注册时间");
        tableTitle.add("生日");
        tableTitle.add("签名");
        tableTitle.add("积分");
        tableTitle.add("操作");
        getJson().put("body", userService.toJsonArray(users));
        getJson().put("title", tableTitle);
        return "json";
    }

    public String comment() {
        if (pageSize > 10000000) pageSize = 10000000;
        List<Comment> comments = commentService.queryForPage(pageSize, page).getList();
        JSONArray tableTitle = new JSONArray();
        tableTitle.add("#");
        tableTitle.add("楼层");
        tableTitle.add("用户ID");
        tableTitle.add("文章ID");
        tableTitle.add("评论内容");
        tableTitle.add("评论时间");
        tableTitle.add("操作");
        getJson().put("body", commentService.toJsonArray(comments));
        getJson().put("title", tableTitle);
        return "json";
    }

    public String banwagon() {
        if (veid == null || veid == "" || api_key == null || api_key == "") {
            getJson().put("status", 1);
        } else {
            getLiveServiceInfo(0, veid, api_key);
        }
        return "json";
    }

    public String info() {
        veid = "672475";
        api_key = "private_Hr15ofiPwCzXinorXjAQOu4A";
        getLiveServiceInfo(1, veid, api_key);
        return "json";
    }

    public String getLiveServiceInfo(int type, String veid, String api_key) {
        String result = "";
        try {
            result = HttpRequest.sendPost("https://api.64clouds.com/v1/getLiveServiceInfo", "veid=" + veid + "&api_key=" + api_key);
            JSONObject liveServiceInfo = JSONObject.fromObject(result);

            getJson().put("status", 0);

            // 服务器信息
            if (type == 0) {
                getJson().put("node_ip", liveServiceInfo.getString("node_ip"));
                getJson().put("ve_mac1", liveServiceInfo.getString("ve_mac1"));
                getJson().put("ssh_port", liveServiceInfo.getString("ssh_port"));
                getJson().put("live_hostname", liveServiceInfo.getString("live_hostname"));
            } else if (type == 1) {
                getJson().put("node_ip", "已被管理员隐藏");
                getJson().put("ve_mac1", "已被管理员隐藏");
                getJson().put("ssh_port", "已被管理员隐藏");
                getJson().put("live_hostname", "已被管理员隐藏");
            }

            getJson().put("node_location", liveServiceInfo.getString("node_location"));
            getJson().put("plan", liveServiceInfo.getString("plan"));
            getJson().put("plan_monthly_data", liveServiceInfo.getString("plan_monthly_data"));
            getJson().put("plan_disk", liveServiceInfo.getString("plan_disk"));
            getJson().put("plan_ram", liveServiceInfo.getString("plan_ram"));
            getJson().put("plan_swap", liveServiceInfo.getString("plan_swap"));
            getJson().put("os", liveServiceInfo.getString("os"));
            getJson().put("data_counter", liveServiceInfo.getString("data_counter"));
            getJson().put("data_next_reset", liveServiceInfo.getString("data_next_reset"));
            getJson().put("error", liveServiceInfo.getString("error"));

            // 服务器实时信息 获取信息需要15秒左右
            // 服务器状态
            getJson().put("ve_status", liveServiceInfo.getString("ve_status"));
            // 占用（映射）磁盘空间（以字节为单位）
            getJson().put("ve_used_disk_space_b", liveServiceInfo.getString("ve_used_disk_space_b"));
            // 实际的磁盘映像大小（GB）
            getJson().put("ve_disk_quota_gb", liveServiceInfo.getString("ve_disk_quota_gb"));
            // 0 = CPU不节流，1 =由于使用率高，CPU被限制。限流自动每2小时重置一次。
            getJson().put("is_cpu_throttled", liveServiceInfo.getString("is_cpu_throttled"));
            // 原始负载平均字符串
            getJson().put("load_average", liveServiceInfo.getString("load_average"));
            // 可用RAM的数量（KB）
            getJson().put("mem_available_kb", liveServiceInfo.getString("mem_available_kb"));
            // 交换总量（KB）
            getJson().put("swap_total_kb", liveServiceInfo.getString("swap_total_kb"));
            // 可用的交换量（KB）
            getJson().put("swap_available_kb", liveServiceInfo.getString("swap_available_kb"));
        } catch (Exception e) {
            getJson().put("status", 2);
        }
        return result;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public String getVeid() {
        return veid;
    }

    public void setVeid(String veid) {
        this.veid = veid;
    }

    public String getApi_key() {
        return api_key;
    }

    public void setApi_key(String api_key) {
        this.api_key = api_key;
    }
}
