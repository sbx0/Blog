package service;

import dao.impl.ArticleDaoImpl;
import entity.Article;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ArticleService {
    private ArticleDaoImpl articleDao;

    public void setArticleDao(ArticleDaoImpl articleDao) {
        this.articleDao = articleDao;
    }

    // 搜索返回 json
    public JSONArray searchReturnJson(List<Article> articles) {
        JSONObject jsonObject = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < articles.size(); i++) {
            jsonObject.put("article_title", articles.get(i).getArticle_title());
            jsonObject.put("article_id", articles.get(i).getArticle_id());
            jsonObject.put("author_name", articles.get(i).getArticle_author().getUser_name());
            jsonObject.put("author_id", articles.get(i).getArticle_author().getUser_id());
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    // 删除用户发布的文章
    public int deleteByUser(int id) {
        try {
            articleDao.deleteByUser(id);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }

    // 查询全部
    public List<Article> getAll() {
        return this.articleDao.getAll();
    }

    // 关键词查询全部
    public List getAll(String keywords, String type, int pageNo, int pageSize) {
        if (keywords == null) keywords = "";
        keywords = keywords.trim();
        int offset = PageBean.countOffset(pageSize, pageNo);
        List articles = articleDao.getAll(keywords, type, offset, pageSize);
        return articles;
    }

    // 查询一条
    public Article getOneById(int id) {
        return this.articleDao.getOneById(id);
    }

    // 总条数，为了分页
    public int getCount() {
        return this.articleDao.getCount();
    }

    // 删除
    public void delete(int id) {
        this.articleDao.delete(id);
    }

    // 单用户文章总条数
    public int getCountById(int id) {
        return this.articleDao.getAllCountById(id);
    }

    // 发表文章
    public void saveOrUpdate(Article article) {
        this.articleDao.saveOrUpdate(article);
    }

    // 分页查询
    public PageBean queryForPage(int pageSize, int page) {
        int count = articleDao.getCount(); // 总记录数
        int totalPage = PageBean.countTotalPage(pageSize, count); // 总页数
        int offset = PageBean.countOffset(pageSize, page); // 当前页开始记录
        int length = pageSize; // 每页记录数
        int currentPage = PageBean.countCurrentPage(page);
        List<Article> list = articleDao.queryForPage("From Article article LEFT OUTER JOIN FETCH article.article_author ORDER BY article.article_id DESC", offset, length); // 该分页的记录
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

    // 用户文章列表的分页查询
    public PageBean queryForPageById(int pageSize, int page, int id) {
        int count = articleDao.getAllCountById(id); // 总记录数
        int totalPage = PageBean.countTotalPage(pageSize, count); // 总页数
        int offset = PageBean.countOffset(pageSize, page); // 当前页开始记录
        int length = pageSize; // 每页记录数
        int currentPage = PageBean.countCurrentPage(page);
        List<Article> list = articleDao.queryForPage("From Article article LEFT OUTER JOIN FETCH article.article_author WHERE article.article_author.user_id =" + id + " ORDER BY article.article_id DESC", offset, length); // 该分页的记录
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

    // 热度排行榜
    public List<Article> hotRankingList() {
        // 创建Date对象
        Date endDate = new Date();

        // 创建基于当前时间的日历对象
        Calendar cl = Calendar.getInstance();
        cl.setTime(endDate);

        // 距离今天，一个月内数据
        cl.add(Calendar.MONTH, -1);

        // 一个月之前
        Date startDate = cl.getTime();

        // 明天
        cl.setTime(endDate);
        cl.add(Calendar.DATE, +1);
        endDate = cl.getTime();

        SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");

        // 格式化开始日期和结束日期
        String startDateString = dd.format(startDate);
        String endDateString = dd.format(endDate);
        java.sql.Date begin = java.sql.Date.valueOf(startDateString);
        java.sql.Date end = java.sql.Date.valueOf(endDateString);

        // 获取查询结果
        return articleDao.hotRankingList(begin, end);
    }

    // 热度排行榜
    public List<Article> hotRanking(List<Article> articles) {
        Integer hotRank[][] = new Integer[articles.size()][2];
        int weiboNum = 0;
        int index = 0;
        // 计算热度
        for (int i = 0; i < articles.size(); i++) {
            if (articles.get(i).getArticle_title().equals("#weibo#")) {
                weiboNum++;
                continue;
            }
            hotRank[index][0] = i;
            hotRank[index][1] = Math.toIntExact(articles.get(i).getArticle_views() / 10 + articles.get(i).getArticle_comment() * 5);
            index++;
        }
        int max = -99999999;
        int tempIndex;
        int tempHot;
        int length = 10;
        if (articles.size() < length) {
            length = articles.size();
        }
        length -= weiboNum;
        // 热度排序
        for (int i = 0; i < length; i++) {
            for (int j = i; j < length; j++) {
                if (hotRank[j][1] > max) {
                    index = j;
                    max = hotRank[j][1];
                }
            }
            tempIndex = hotRank[index][0];
            tempHot = hotRank[index][1];
            hotRank[index][0] = hotRank[i][0];
            hotRank[index][1] = hotRank[i][1];
            hotRank[i][0] = tempIndex;
            hotRank[i][1] = tempHot;
            max = -999;
        }
        // 保存排序后的文章列表
        List<Article> hotRankingList = new ArrayList<>();
        for (int i = 0; i < length; i++) {
            hotRankingList.add(articles.get(hotRank[i][0]));
        }
        return hotRankingList;
    }

    // 精简博文
    public List<Article> simpleBlog(List<Article> list) {
        String killHtml; // 中间变量 去除html化的博文详情
        for (int i = 0; i < list.size(); i++) {
            Article article = list.get(i);
            killHtml = ArticleService.killHTML(article.getArticle_content());
            // 只有当博文长度大于250时才精简博文
            if (killHtml.length() > 250) {
                killHtml = killHtml.substring(0, 250);
                article.setArticle_content(killHtml);
            }
            list.set(i, article);
        }
        return list;
    }

    // 去html标签
    public static String killHTML(String content) {
        String regEx_script = "<script[^>]*?>[\\s\\S]*?<\\/script>"; // script
        String regEx_style = "<style[^>]*?>[\\s\\S]*?<\\/style>"; // style
        String regEx_html = "<[^>]+>"; // HTML tag

        Pattern p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
        Matcher m_script = p_script.matcher(content);
        content = m_script.replaceAll(""); // 过滤script标签

        Pattern p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
        Matcher m_style = p_style.matcher(content);
        content = m_style.replaceAll(""); // 过滤style标签

        Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
        Matcher m_html = p_html.matcher(content);
        content = m_html.replaceAll(""); // 过滤html标签

        return content;
    }

    // 废弃 用js即可 给所有自定义标签加上 class="自定义样式"
    public static String imgResponsive(String label, String classname, String content) {
        int labelLength = label.length();
        int index = content.indexOf("<" + label);
        int classnameLength = classname.length();
        // 如果内容里有img标签则处理
        if (index != -1) {
            int newIndex; // 记录新找到的标签位置
            int j = 0; // 记录共有几个标签
            String before; // 字符前半部分
            String after; // 字符后半部分
            // 创建一个数组存放找到的img标签的位置，为了节省空间，创建一个登陆字符串长度一半的数组长度
            int numbers[] = new int[content.length() / 2];

            // 判断是否已经添加了自定义class
            String temp = content.substring(index + 12, index + 12 + classnameLength);
            if (!temp.equals(classname)) {
                numbers[j++] = index; // 将第一个img标签的位置存入数组
            } else {
                j--;
            }

            // 循环查找img标签
            for (int i = index; i < content.length(); ) {
                newIndex = content.indexOf("<" + label, i + labelLength + 2);
                if (newIndex == -1) {
                    break; // 没有其他img标签时
                } else {
                    // 判断是否已经添加了自定义class
                    temp = content.substring(newIndex + 12, newIndex + 12 + classnameLength);
                    if (!temp.equals(classname)) {
                        numbers[j++] = newIndex; // 存入查到的img标签位置，用j记录一共有几个img标签
                    }
                }
                i = newIndex; // 下一个寻找img标签的起点
            }

            // 已经做过了 或者 没有img标签
            if (j > 0) {
                before = content.substring(0, numbers[0] + (labelLength + 1));
                if (j > 1) { // 当标签个数大于1个的时候，循环操作
                    after = content.substring(numbers[0] + (labelLength + 1)); // 取出img标签之后的内容
                    content = before + " class=\"" + classname + "\"" + after; // 合体
                    for (int i = 1; i < j; i++) {
                        before = content.substring(0, numbers[i] + (labelLength + 1) + (classnameLength + 9) * i); // 23是添加的 class="img-responsive" 的长度22加一个空格1
                        after = content.substring(numbers[i] + (labelLength + 1) + (classnameLength + 9) * i); // 乘i是因为之前已经加了i个 class="img-responsive" 了
                        content = before + " class=\"" + classname + "\"" + after; // 合体
                    }
                } else { // 只有一个img标签
                    after = content.substring(numbers[0] + (labelLength + 1)); // 取出img标签之后的内容
                    content = before + " class=\"" + classname + "\"" + after; // 取出img标签之后的内容
                }
            }

        }
        return content;
    }

    // 将List<Code>中有用的东西转换成json串
    public JSONArray articlesJson(List<Article> articles) {
        JSONArray jsonArray = new JSONArray();
        int i = 0;
        for (Article a : articles) {
            jsonArray.add(i, articleJson(a));
            i++;
        }
        return jsonArray;
    }

    // 将code变成jsonObject
    public JSONObject articleJson(Article a) {
        // json config 配置 去除无效数据
        JsonConfig config = new JsonConfig();
        config.setJsonPropertyFilter(new PropertyFilter() {
            public boolean apply(Object arg0, String arg1, Object arg2) {
                if (arg1.equals("article_author") || arg1.equals("time") || arg1.equals("user_id")
                        || arg1.equals("user_name") || arg1.equals("article_comment") || arg1.equals("article_comment")
                        || arg1.equals("article_id") || arg1.equals("article_time") || arg1.equals("article_title")
                        || arg1.equals("article_views")) {
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
