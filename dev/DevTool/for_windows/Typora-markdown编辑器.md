# Typora编辑器



## 1使用



### 安装

地址https://www.typora.io/ 



### 个性设置



#### 主题使用

将下载好主题放到Typora主题文件夹（可在`` 文件/偏好设置/外观 `` 设置中查看目录位置）下，重启Typora即可在`` 主题 ``下看到下载的主题。



## 2扩展



### 1.图床设置 ` Gitee ` ` PicGo `



#### 步骤1.Gitee设置

https://gitee.com/ 新建仓库

在账号下 `设置/安全设置/私人令牌` 中添加私人令牌，一定要选择 `projects` ，这样此 token 才有操作仓库的权限

` token ` 保存好，需在PicGo中使用

#### 步骤2.PicGo设置

PicGo 下载地址 : https://molunerfinn.com/PicGo/

 `PicGo` 默认不支持 `gitee`，需下载 `gitee-uploader`插件。

在插件设置中搜索 `gitee-uploader`  （需安装node.js）

安装好插件后重启后在gitee页面下进行配置` repo ` （仓库名 例：username/reponame）及` token `

配置好后测试下是否成功

#### 步骤3.Typora添加配置

在`文件/偏好设置/图像` 中可以进行 `PicGo` 的配置

<img src="https://gitee.com/balabalaqwq/pics/raw/master/image-20210401164623333.png" alt="image-20210401164623333"  />

配置完成后在编写文件是插入图片右键后会显示` 上传图片 ` ，该选项可上传并自动替换插入图片地址



### Git配置远程仓库

在 本地个人Markdown文件目录下右键Git Bash Here

初始化仓库

git init 

添加文件

git add .

按需配置.gitignore文件

提交、配置及推送远程仓库见 [Git 常用命令](https://github.com/balabalaqwq/dev_notes/blob/master/dev/Git/Git%20%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4.md)

