// 购物车路由
const express=require("express")
const router=express.Router();//创建路由对象
var pool = require('../pool');




router.get("/shopcar",(req,res)=>{
    var sql="select * from shop_car_table where car_user_lid=?"
    var sql2="select * from shop_table wehre shop_lid=?"
    if(req.session.user_lid){
        pool.query(sql,[req.session.user_lid],(err,result)=>{
            if(err) throw err;
        var {lid,count}=result[0];
        pool.query(sql2,lid,(err,result)=>{
            if(err) throw err;
            res.send({
                ok:1,
                msg:"成功2",
                data:{
                    
                }
                
            })
        })   
        })
    }else{
        res.send({
            ok:0,
            msg:"请先登录"
        })
    }
})





module.exports=router;//导出路由