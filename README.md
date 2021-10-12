# demo-project

#### 介绍
nodejs后端与
myseql设计导图与接口规范

#### 安装教程
1.  请先使用 npm i 安装补齐mode_modules内模块文件再进行协作

#### 项目架构
项目架构说明
> 基于nodejs的后端接口项目

#### 项目目录
1. mysql  --项目sql脚本文件
2. router --路由目录 内含各接口文件
3. app.js --nodejs主文件
4. md5.js --md5加密模块
5. pool.js --连接池文件
6. schema --验证规则文件夹

接口主地址 127.0.0.1:4231

#### 项目进度
1. 用户接口 /user
    - 用户注册/ureg   md5混淆加密上传数据库  
    - 用户登录/ulogin   md5混淆加密后查表进行验证
    - 用户登录状态验证/new     自动过期
    - 注销登录 /loginout
