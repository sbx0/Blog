package action;

import entity.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.*;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

public class ArticleAction extends BaseAction {
    private ArticleService articleService;
    private CommentService commentService;
    private UserService userService;
    private StatusService statusService;
    private Article article;
    private Comment comment;
    private PageBean pageBean;
    private int id;
    private int a_id;
    private int pageNo;
    private int pageSize = 10;
    private String keywords;
    private String type;
    private List<Comment> comments;
    private MessageService messageService;

    // 评论修改
    public String updateComment() {
        Comment c = commentService.getOneComment(comment.getComment_id());
        if(comment.getComment_content().length() > 150)
            comment.setComment_content(comment.getComment_content().substring(0,150));
        c.setComment_content(comment.getComment_content().trim());
        int status = commentService.updateComment(c);
        getJson().put("status", status);
        return "json";
    }

    // 获得一个评论
    public String getOneComment() {
        Comment c = commentService.getOneComment(id);
        JSONObject cj = new JSONObject();
        cj.put("id", c.getComment_id());
        cj.put("content", c.getComment_content());
        getJson().put("comment", cj);
        return "json";
    }

    // 快速发布微博
    public String weibo() {
        int status = 0;
        User user = (User) getSession().get("user");
        if (user == null) {
            status = 1;
        } else if (article.getArticle_content().trim().length() == 0 || article.getArticle_content().trim() == null) {
            status = 2;
        } else {
            article.setArticle_content(article.getArticle_content().trim());
            // 允许
//            article.setArticle_content(articleService.killHTML(article.getArticle_content().trim()));
            // 限制长度最长140
            if (article.getArticle_content().length() > 140)
                article.setArticle_content(article.getArticle_content().substring(0, 140));
            article.setArticle_author(user);
            article.setArticle_time(new Date());
            // 分辨 长文字 与 微博
            article.setArticle_title("#weibo#");
            article.setArticle_comment(0);
            article.setArticle_views(0);
        }
        try {
            articleService.saveOrUpdate(article);
        } catch (Exception e) {
            status = 3;
        }
        getJson().put("status", status);
        return "json";
    }

    public String random() {
        List<Article> randomArticles = articleService.getAll();

        if (randomArticles.size() == 0) return "json";
        int size = 10;
        int length = randomArticles.size();
        if (length < size) size = length;
        JSONArray randomArticlesJson = new JSONArray();
        int randomIndex;
        int[] randomIndexArray = new int[length];

        for (int i = 0; i < size; ) {

            randomIndex = (int) (Math.random() * size + 0);

            if (i == 0) randomIndexArray[i] = randomIndex;
            int j;
            for (j = 0; j < i; j++) {
                if (randomIndex == randomIndexArray[j]) break;
            }
            if (j == i) {
                randomIndexArray[i] = randomIndex;
                JSONObject randomArticleJson = new JSONObject();
                randomArticleJson.element("id", randomArticles.get(randomIndex).getArticle_id());
                randomArticleJson.element("title", randomArticles.get(randomIndex).getArticle_title());
                randomArticleJson.element("user_id", randomArticles.get(randomIndex).getArticle_author().getUser_id());
                randomArticleJson.element("user_name", randomArticles.get(randomIndex).getArticle_author().getUser_name());
                randomArticleJson.element("date", randomArticles.get(randomIndex).getArticle_time());
                String content = articleService.killHTML(randomArticles.get(randomIndex).getArticle_content());
                if (content.length() < 250) {
                    content = randomArticles.get(randomIndex).getArticle_content();
                } else {
                    content = content.substring(0, 250);
                }
                randomArticleJson.element("content", content);
                randomArticlesJson.element(randomArticleJson);
                i++;
            }
        }

        getJson().put("articles", randomArticlesJson);
        return "json";
    }

    public String search() {
        try {
            keywords = URLDecoder.decode(keywords, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        JSONArray jsonArray = new JSONArray();
        if (type.equals("1")) {
            List<Article> articles = articleService.getAll(keywords, type, pageNo, pageSize);
            jsonArray = articleService.searchReturnJson(articles);
        } else if (type.equals("2")) {
            List<Article> articles = articleService.getAll(keywords, type, pageNo, pageSize);
            jsonArray = articleService.searchReturnJson(articles);
        } else if (type.equals("3")) {

        }
        getJson().put("result", jsonArray);
        return "json";
    }

    // 添加评论 + 15积分
    public String comment() {
        // 默认一次加载5条评论
        pageSize = 5;
        pageNo = 1;
        String status = "0";

        // 评论填充
        User user = (User) getSession().get("user");
        user = userService.getUser(user.getUser_id());
        if (comment.getComment_content().length() > 150)
            comment.setComment_content(comment.getComment_content().substring(0, 150));
        comment.setComment_user(user);
        Article article = articleService.getOneById(id);
        comment.setComment_floor(Integer.parseInt(article.getArticle_comment() + "") + 1);
        comment.setComment_article(article);
        comment.setComment_time(new Date());

        // 评论写入数据库
        try {
            commentService.postComment(comment);
            article.setArticle_comment(article.getArticle_comment() + 1);
            articleService.saveOrUpdate(article);
        } catch (Exception e) {
            status = "1";
        }

        // 获取当页评论
        comments = commentService.queryForPage(pageSize, pageNo, id).getList();

        // 获得我们要传递到页面的json数据
        JSONArray jsonArray = commentService.commentJson(comments);

        // 封装进JSONObject
        getJson().put("user_id", user.getUser_id());
        getJson().put("is_admin", user.getUser_is_admin());
        getJson().put("status", status);
        getJson().put("msg", "评论成功 +15 积分");
        getJson().element("comments", jsonArray);

        // 增加积分
        user.setUser_integral(user.getUser_integral() + 15L);
        userService.register(user);

        // 判断评论的用户是不是文章的发表人
        if (user.getUser_id() != article.getArticle_author().getUser_id()) {
            // 给博文的作者发条评论提醒
            Message message = new Message();
            String m = "您的文章<" + article.getArticle_title() + ">收到了评论:" + comment.getComment_content();
            message.setContent(m);
            message.setSendTime(new Date());
            message.setSendUser(article.getArticle_author());
            message.setReceiveUser(article.getArticle_author());
            message.setIsRead(0);
            message.setType(0);
            messageService.send(message);
        }

        return "json";
    }

    // 发表文章 +30积分
    public String post() {
        String saveOrUpDate = "save";
        String status = "0";
        User user = (User) getSession().get("user");
        if (article.getArticle_id() == null) {
            article.setArticle_author(user);
            article.setArticle_time(new Date());
            article.setArticle_views(0);
            article.setArticle_comment(0);
            user = userService.getUser(user.getUser_id());
            user.setUser_integral(user.getUser_integral() + 30L);
            userService.register(user);
        } else {
            saveOrUpDate = "update";
        }
        System.out.println(article.getArticle_content());
//        article.setArticle_content(ArticleService.imgResponsive("img", "img-responsive", article.getArticle_content()));
        try {
            articleService.saveOrUpdate(article);
        } catch (Exception e) {
            status = "1";
        }
        getJson().put("msg", "发布成功 +30 积分");
        getJson().put("status", status);
        getJson().put("saveOrUpdate", saveOrUpDate);
        return "json";
    }

    // 首页 文章显示
    public String list() {
        // 获取总页数
        int totalPage = PageBean.countTotalPage(pageSize, articleService.getCount());
        // 防止页数越界
        if (pageNo < 1) {
            pageNo = 1;
        }
        if (pageNo > totalPage) {
            pageNo = totalPage;
        }
        // 根据页数和一页显示条数获取数据
        pageBean = articleService.queryForPage(pageSize, pageNo);
        // 精简博文
        List<Article> list = pageBean.getList();
        pageBean.setList(articleService.simpleBlog(list));
        // 月热度排行榜
        List<Article> hotRankingList = articleService.hotRanking(articleService.hotRankingList());
        getRequest().put("page", pageNo);
        getRequest().put("pageBean", pageBean);
        getRequest().put("hotRankingList", hotRankingList);
        return "list";
    }

    // 单个用户的博文列表
    public String user() {
        User user = userService.getUser(id);
        int totalPage = PageBean.countTotalPage(pageSize, articleService.getCountById(id));
        if (pageNo < 1) {
            pageNo = 1;
        }
        if (pageNo > totalPage) {
            pageNo = totalPage;
        }
        pageBean = articleService.queryForPageById(pageSize, pageNo, id);
        List<Article> list = pageBean.getList();
        // 精简博文
        pageBean.setList(articleService.simpleBlog(list));
        // 用户的状态
        List<Status> statuses = statusService.queryByUser(user.getUser_id());
        if (statuses != null) {
            getRequest().put("statuses", statuses);
        }
        getRequest().put("page", pageNo);
        getRequest().put("pageBean", pageBean);
        getRequest().put("user", user);
        return "user";
    }

    // 后台 博文显示
    public String aList() {
        pageSize = 10;
        int totalPage = PageBean.countTotalPage(pageSize, articleService.getCount());
        if (pageNo < 1) {
            pageNo = 1;
        }
        if (pageNo > totalPage) {
            pageNo = totalPage;
        }
        pageBean = articleService.queryForPage(pageSize, pageNo);
        getRequest().put("page", pageNo);
        getRequest().put("pageBean", pageBean);
        return "admin-list";
    }

    // 博文详情
    public String one() {
        article = articleService.getOneById(id);
        if (article != null) {
            article.setArticle_views(article.getArticle_views() + 1);
            articleService.saveOrUpdate(article);
            getRequest().put("article", article);
            getRequest().put("saveOrUpdate", "update");
        }
        // 上一篇 下一篇
        Article preArticle = new Article();
        Article nextArticle = new Article();
        for (int i = id - 1; i > id - 6; i--) {
            if (i < 0) break;
            preArticle = articleService.getOneById(i);
            if (preArticle != null) {
                break;
            }
        }
        getRequest().put("preArticle", preArticle);
        for (int i = id + 1; i < id + 6; i++) {
            nextArticle = articleService.getOneById(i);
            if (nextArticle != null) {
                break;
            }
        }
        getRequest().put("nextArticle", nextArticle);
        return "one";
    }

    // 加载评论
    public String load() {
        // 是否登陆 js判断是否登陆而显示删除修改
        User user = (User) getSession().get("user");
        if (user == null) {
            getJson().put("user_id", -1);
        } else {
            getJson().put("user_id", user.getUser_id());
            getJson().put("is_admin", user.getUser_is_admin());
        }

        // 默认一次加载5条评论
        pageSize = 5;
        String status = "0";
        JSONArray jsonArray = new JSONArray();

        // 计算总页数
        int totalPage = PageBean.countTotalPage(pageSize, commentService.getCount(id));

        // 当评论加载超过范围 状态3：加载完毕/数据异常
        if (pageNo > totalPage || pageNo < 1) {
            status = "3";
        } else {
            // 正常加载评论
            try {
                // 获取当页评论
                comments = commentService.queryForPage(pageSize, pageNo, id).getList();
                if (comments != null) {
                    // 获得我们要传递到页面的json数据
                    jsonArray = commentService.commentJson(comments);
                } else {
                    status = "3";
                }
            } catch (Exception e) {
                // 状态2 出错
                status = "2";
                e.printStackTrace();
            }
        }
        getJson().put("status", status);
        getJson().element("comments", jsonArray);
        return "json";
    }

    // 修改
    public String update() {
        article = articleService.getOneById(id);
        getRequest().put("article", article);
        getRequest().put("saveOrUpdate", "update");
        return "update";
    }

    // 删除
    public String delete() {
        commentService.deleteArticleComment(id);
        articleService.delete(id);
        return "delete";
    }

    // ajax 删除
    public String deleteReturnJson() {
        String status = "0";
        try {
            commentService.deleteArticleComment(id);
            articleService.delete(id);
        } catch (Exception e) {
            status = "1";
        }
        getJson().put("status", status);
        return "json";
    }


    // 删除评论
    public String deleteC() {

        User user = (User) getSession().get("user");
        user = userService.getUser(user.getUser_id());

        // 不是管理员且积分少于20L 则无法删除评论
        if (user.getUser_integral() < 20L && user.getUser_is_admin() != 1) {
            getJson().put("status", 3);
        } else {
            if(user.getUser_is_admin() != 1){
                user.setUser_integral(user.getUser_integral() - 20L);
                if(user.getUser_integral() < 0L){
                    user.setUser_integral(0L);
                }
            }
            userService.register(user);
            try {
                commentService.delete(id);
                article = articleService.getOneById(a_id);
                long commentNum = article.getArticle_comment();
                commentNum--;
                if(commentNum < 0) commentNum = 0;
                article.setArticle_comment(commentNum);
                articleService.saveOrUpdate(article);
                getJson().put("status", 0);
            } catch (Exception e) {
                getJson().put("status", 1);
            }
        }
        return "json";
    }

    public void setMessageService(MessageService messageService) {
        this.messageService = messageService;
    }

    public MessageService getMessageService() {
        return messageService;
    }

    public void setStatusService(StatusService statusService) {
        this.statusService = statusService;
    }

    public StatusService getStatusService() {
        return statusService;
    }

    public void setArticle(Article article) {
        this.article = article;
    }

    public Article getArticle() {
        return article;
    }

    public void setArticleService(ArticleService articleService) {
        this.articleService = articleService;
    }

    public void setCommentService(CommentService commentService) {
        this.commentService = commentService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public int getPageSize() {
        return pageSize;
    }

    public PageBean getPageBean() {
        return pageBean;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageNo() {
        return pageNo;
    }

    public Comment getComment() {
        return comment;
    }

    public void setComment(Comment comment) {
        this.comment = comment;
    }

    public void setA_id(int a_id) {
        this.a_id = a_id;
    }

    public int getA_id() {
        return a_id;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public void setType(String type) {
        this.type = type;
    }
}
