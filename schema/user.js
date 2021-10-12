// 导入定义验证的包
const joi=require("joi");
/*
    string() 值必须是字符串
    alphanum() 值必须包含a-z A-Z,0-9的字符串
    min(n) 最小长度
    max(n) 最大长度
    required() 必须值，不能为undefined
    pattern(正则)       值必须复合正则表达式的规则


*/
const uname=joi.string().alphanum().min(4).max(10).required();
const upwd=joi.string().pattern(/^[\S]{6,12}$/).required();
const uemail=joi.string().email();
// 定义验证注册和登陆表单数据的规则对象

exports.reg_login_schema={
    // 验证body类型的数据
    body:{
        uname,
        upwd,
        uemail
    }
}
