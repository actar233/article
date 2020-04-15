[@Title]:<>(我的第一个博客)
[@Date]:<>(2018-10-18 13:03:00)
[@Tags]:<>(日常)



# 这是一个自用的Blog系统

[项目位置](https://github.com/actar233/blog)

只需要编写Markdown文件就可自动生成目录页面,分类页面,文章页面

自动加载被修改的Markdown文档

创建markdown文件夹,将markdown文件放在里面

在markdown文件头部加入如下标记

```
[@Title]:<>(我的第一个博客)
[@Date]:<>(2018-10-18 13:03:00)
[@Tags]:<>(日常)
```

```
在下方括号内写标题
[@Title]:<>(我的第一个博客)
```

```
在下方括号内写时间,时间格式如下
[@Date]:<>(2018-10-18 13:03:00)
```

```
在下方括号内写标签,标签可用 , 分割,示例如下
[@Tags]:<>(编程,Java)
```

三个标签缺一不可,可放在任意位置

可拥有多个相同的标签,但只有第一个标签会生效

## 追加 2018-10-26

利用 Webhook 自动发布文章

首先你的服务器应该安装 git

然后在blog程序同级目录创建 blog.properties 文件

```
# 文件内容如下
# git 你的项目地址
git=https://github.com/youname/youproject
# token 用作校验的标记
token=123abc
```

然后设置 Webhook

地址应该为

http\[s]://{your-domain}/git/target/{your-token}

* your-domain: 这是你的域名
* your-token: 这是你在上方 blog.properties 文件中设置的 token
* 如果未设置token 地址为 /git/target

## 追加 2020-04-14

blog.properties 添加配置项 record (备案号)

```
record=XXXXXX
```

中文部分请使用 unicode 编码