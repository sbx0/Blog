package action;

import entity.Data;

import java.util.List;

public class DataAction extends BaseAction {

    public String index() {

        // 列表
        if (context.getAttribute("userOlList") != null) {
            List userOlList = (List) context.getAttribute("userOlList");
            getJson().put("userOlList", userOlList);
            long userCount = userOlList.size();
            getJson().put("userCount", userCount);
        } else {
            getJson().put("userCount", 0L);
        }

        // max login
        Data maxUserLoginData = dataService.queryMax(1);
        getJson().put("maxLogin", maxUserLoginData);

        return "json";
    }

}
