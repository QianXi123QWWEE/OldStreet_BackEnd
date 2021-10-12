--开发版， 上线请修改数据库清空规则


-- 这个设置的意思是mysql中的自增长列可以从0开始。默认情况下自增长列是从1开始的，如果你插入值为0的数据会报错，设置这个之后就可以正常插入为0的数据了。
set SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
set names utf8;

-- 删除数据库 如果有
drop database if exists wncf;
-- 创建数据库
create database wncf;

-- 判断是否存在数据库，不存在则创建
-- create database if not exists 'wncf' default character set utf8 collate utf8_general_ci;

-- 进入数据库
use wncf;

-- -------------------商品表--------------------

create table shop_table(
    -- 商品编号 非空 唯一
    shop_lid int(11) primary key auto_increment  not null,
    -- 商品图片地址
    shop_img_pic varchar(128) default null,
    -- 商品标题
    shop_title varchar(25) default null,
    -- 商品价格
    shop_price decimal(10,2) default null,
    -- 商品剩余数量
    shop_quantity int(20) not null
);
-- 插入商品测试数据
insert into shop_table(shop_lid,shop_img_pic,shop_title,shop_price,shop_quantity)
values(1,'img/index/imgxxxxx01.png','测试标题',4550,1000),
(null,'img/index/imgxxxxx01.png','测试标题',4550,1000),
(null,'img/index/imgxxxxx01.png','测试标题',4550,1000),
(null,'img/index/imgxxxxx01.png','测试标题',4550,1000);





-- -------------------用户表--------------------
create table user_table(
    -- 用户编号
    user_lid int(11) primary key auto_increment  not null,
    -- 用户名
    user_name varchar(25) not null,
    -- 用户性别
    user_sex varchar(2) default '未知',
    -- 用户密码
    user_pwd varchar(128) not null,
    -- 用户简介
    user_present varchar(128) default null,
    -- 用户头像
    user_avatar varchar(128) default './img/user_img_avatar',
    -- 用户邮箱
    user_email varchar(64) default null
);
-- 插入测试用户数据
insert into user_table(user_lid,user_name,user_sex,user_pwd,user_present,user_avatar,user_email)values(1,'2630473215',"男","db5b6c04c891018867f2ae6eda51a2b1","这是我的第一条数据，今天是周一，这是简介",default,null);
-- 接口示例 一次只插入一条数据，不然id会错





-- -------------------购物车表--------------------
create table shop_car_table(
    -- 购物车主键列 无用
    car_lid int(11) primary key auto_increment  not null,
    -- 用户id外键列
    car_user_lid int(11) not null,foreign key(car_user_lid) references user_table(user_lid),
    -- 关联商品id对应的商品id数组,加入一件商品，就写入一条
    car_shop_lid varchar(255) default null,
    -- 关联商品id对应商品数量数组，加入一件商品，就写入一条 不能为零 要一一对应
    car_shop_count varchar(1024) default null
    -- 每件商品计算后的价格数组,废弃，后端查计算吧。。
);
-- 插入购物车数据测试
insert into shop_car_table(car_lid,car_user_lid,car_shop_lid,car_shop_count)
values(
1,1,"[1,2,3,4]","[1,1,1,2]"
);


-- -------------------轮播表--------------------
create table carousel_table(
    -- 轮播表主键列
    crl_lid int(10),
    crl_src varchar(64)
)
