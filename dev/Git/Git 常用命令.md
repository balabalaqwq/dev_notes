# Git 常用命令

Git doc https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%85%B3%E4%BA%8E%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6

## config

git config -global

> `git config --global user.name "wntn"` 设置name
> `git config --global user.email wntn@xx.com`  设置email

> `git config --global https.proxy http://127.0.0.1:1080`  设置代理
> `git config --global https.proxy https://127.0.0.1:1080`  设置代理
> `git config --global --unset http.proxy`  取消代理
> `git config --global --unset https.proxy`  取消代理

> `git config --global http.sslVerify "false"` 解除ssl验证


> `git config --list`  查看配置列表

## init

> `git init` 初始化 生成.git目录文件

## clone

> ` git clone <url> `  克隆目标仓库url项目 默认建立pull、push关系
>
> ` git clone <url> <name> `  重命名name

## add

> `  git add <file> `  添加文件
>
> ` git add . `  添加所有文件（该目录）

## commit

> ` git commit -m "msg" `  提交信息msg
>
> ` git commit -m '` 
>
>  `msg1 ` 
>
>  `msg2`
>
>  `msg3`
>
>  ` ' ` 提交较长信息
>
> ` git commit -a -m "msg" `  提交信息msg 加的-a参数可以将所有已跟踪文件中的执行修改或删除操作的文件都提交到本地仓库，即使它们没有经过git add添加到暂存区，注意，新加的文件（即没有被git系统管理的文件）是不能被提交到本地仓库的。建议一般不要使用-a参数，正常的提交还是使用git add先将要改动的文件添加到暂存区，再用git commit 提交到本地版本库。
>
> ` git commit -am "msg" `   提交信息msg  加-am参数也叫追加提交，它可以在不增加一个新的commit-id的情况下将新修改的代码追加到前一次的commit-id中，

## branch

分支

> ` git branch <branchname> ` 创建分支
>
> ` git checkout <branchname> `  切换分支
>
> ` git checkout -b <branchname> ` 创建并切换分支
>
> ` git branch -r -a -l `  查看分支
>
> ` git branch -d <branchname> `  删除本地分支
>
> ` git branch --delete <branchname> `  删除远程分支

## 远程操作

配置远程仓库

> ` git remote add origin <url> `    

pull

> ` git pull origin master `  拉取

push

> ` git push origin master `  推送

## 其它

gitignore 忽略配置