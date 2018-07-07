# Blog
Java Web 项目

更新日志（不完整）：
**----- 2018-06-08 -----**
common-fileupload.jar 升级为最新的1.3.3

**----- 2018-06-08 -----**
优化 反馈列表显示

系统消息：自己给自己发的消息，显示成系统消息

**----- 2018-06-18 -----**
修复 含有图片的博文修改时出错
修复 点击图片异常显示
修复 未登录查看消息页异常

**----- 2018-06-03 -----**
新增 信息中心

**----- 2018-05-30 -----**
优化 部分界面输入框回车不会输入回车
优化 消息提醒样式
禁止 文本框改变大小

**----- 2018-05-09 -----**
新增 小游戏
优化 去除链接鼠标悬停时的下划线

**----- 2018-05-09 -----**
新增 评论后台管理
新增 后台管理的查看
优化 管理列表修改将会跳转到新窗口
修复 用户博文列表没有去博文发布人的问题
修复 用户积分可以到负数的问题
修复 删除评论时必须重新登陆才能获得正确的积分

**----- 2018-05-07 -----**
优化 评论修改后不刷新页面
优化 用户博文列表去掉发布人
优化 管理员可以修改文章的东西变多了
优化 微博修改界面
优化 搬瓦工查询界面取消文字居中
修复 评论楼层错误
修复 管理员无法修改用户评论的问题
修复 评论过长的问题
修复 评论数可以到负数的问题

**----- 2018-05-04 -----**
新增 评论修改
优化 随机推荐算法去除了一些不必要的操作
增加 页面底部添加真首页的链接
修复 登陆统计无法正常显示的问题
备注 ajax中return返回值，需要在 async:false 变成同步
修复 修改包含图片博文出错的问题
优化 微博显示
优化 博文列表显示

**----- 2018-04-24 -----**
修复 没有删除账户入口的问题
备注 普通用户账户可以删除，管理员账户无法删除

**----- 2018-04-22 -----**
增加 繁体中文
增加 微博
修改 无需登录即可提交反馈
修改 改变工具页排序


**----- 2018-04-19 -----**
增加 用户可以删除账号了
备注 删除账号操作无法恢复
增加 用户可以编辑个人资料了
增加 页面后台管理验证
增加 博文的后台管理
增加 用户的后台管理

**----- 2018-02-10 -----**
修复 按钮错位
修复 错误的在线人数统计
增加 首页最高在线人数

**----- 2018-02-04 -----**
增加 后台管理 纯js实现 上一页 下一页
增加 js实现的自动跳转https

**----- 2018-01-08 -----**
修改 部分界面布局
修改 大部分都整合到“工具”中

**----- 2018-01-04 -----**
增加 新首页显示随机选取的文章
增加 统一的错误界面
修复 博文数为0时未正常分页的错误
修复 JSTL标签使用不规范而导致异常抛出的错误
修复 火狐浏览器下切换中英文失效的错误
关于 火狐浏览器下json以及其他中文文本乱码，暂时的解决方法:进入设置-更多-文字编码-选择 Unicode

**----- 2018-01-03 -----**
改动 博文纯文本超过500字才会被折叠
修复 去html标签算法重复添加class的错误
修复 火狐浏览器下登陆后页面并未重载的错误
备注 history.go(0) 改成 location.replace(location.href)
发现 IDEA中shift+↑↓ ctrl+↑↓ alt+↑↓有奇效
发现 Consolas是世界上最好的编程字体

**----- 2017-12-18 -----**
模态框登陆

**----- 2017-12-14 -----**
删除评论会扣除20积分（评论加15积分）
积分不够删除操作会取消
Bug反馈后界面会刷新
背包显示异常已修复

**----- 2017-12-12 -----**
文章内容搜索
搜索结果分页加载
搜索结果新标签打开
Bug点击新标签打开

**----- 2017-12-11 -----**
长用户名显示优化
登陆界面优化逻辑
评论提醒 增加用户判断
文章搜索 完成文章标题搜索以及显示
