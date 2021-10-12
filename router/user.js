const express = require("express")
const router = express.Router();//创建路由对象
var pool = require('../pool');
// 验证中间件
const expressjoi=require("@escook/express-joi");
// 引入token
const jwt=require("../jwt");

// 引入验证规则对象
const{reg_login_schema}=require("../schema/user")


// 引入md5模块
const md5=require("../md5");
const { JsonWebTokenError } = require("jsonwebtoken");


// 登录                  数据验证中间件进行查找过滤不合法数据
router.post("/ulogin",expressjoi(reg_login_schema),(req, res) => {
   let user= req.user;  //保存上一次的用户对象
    var { user_name, user_pwd } = req.body;
    user_pwd=md5(user_pwd);
    var sql1 = "select * from user_table where user_name=? and user_pwd=?"
    pool.query(sql1,[user_name,user_pwd],(err,result)=>{
        if(err) throw err;
        
        if(result.length>0){
            let {user_name,user_sex,user_avatar}=result[0];
            res.send({
                ok:1,
                msg:"登录成功",
                data:{user_name,user_sex,user_avatar}, //返回给客户端的数据
                token:jwt.generateToken(result[0])    //返回token
            })
        }else{
            res.send({
                ok:0,
                msg:"用户名或者密码错误"
            })
        }
        res.end();
    })
    
})
// 登录状态获取
// router.get("/news",(req,res)=>{
//     if(req.session.user_lid){  //根据req.session.suer_lid的值进行状态切换
//         var sql1 = "select * from user_table where user_lid=?"

//         pool.query(sql1,req.session.user_lid,(err,result)=>{
//             if(err) throw err;
//             var {user_name,user_sex,user_present,user_avatar,user_email}=result[0];
//             res.send({
//                 ok:1,
//                 msg:`欢迎你${result[0].user_name}`,
//                 data:{
//                     user_name,user_sex,user_present,user_avatar,user_email
//                 }
//             })
//         })
//     }else{
//         res.send({
//             ok:0,
//             msg:"未登录"
            
//         });
//     }
// })
// 注销登录
router.get("/loginout",(req,res)=>{
    req.session.destroy((err)=>{
        if(err) throw err;
    })
    res.send({
        ok:0,
        msg:"注销成功"
    })
})
// 注册接口
router.post("/ureg",expressjoi(reg_login_schema),
    (req, res) => { //通过验证
        var { user_name, user_pwd } = req.body;
        var spl1 = "select * from user_table where user_name=?"//查询语句
        pool.query(spl1,user_name, (err, result) => {
            if (result.length > 0) {
                res.send({
                    ok: 0,
                    msg: "用户名已经存在"
                })
            } else {
                //插入用户
                // 将密码通过md5加密
                user_pwd=md5(user_pwd);
                var sql2 = "insert into user_table(user_name,user_pwd)values(?,?)";
                pool.query(sql2, [user_name, user_pwd], (err, result) => {
                    if (err) {
                        console.log(err);
                        res.send({
                            ok: 0,
                            msg: "注册失败"
                        })
                    } else {
                        // 保存注册的用户主键id
                        var ulid = result.insertId;
                        // 创建用户对应的购物车表
                        var sql3 = "insert into shop_car_table(car_user_lid)values(?)"
                        pool.query(sql3, ulid, (err, result) => {
                            if (err) {
                                console.log(err);
                                res.send({
                                    ok: 0,
                                    msg: "注册失败,默认购物车添加失败"
                                })
                            } else {
                                console.log(`Id为${ulid}的用户添加成功`)
                                res.send({
                                    ok: 1,
                                    msg: "注册成功"
                                })
                            }
                        })

                    }
                })



            }
        })

    })

module.exports = router;//导出路由