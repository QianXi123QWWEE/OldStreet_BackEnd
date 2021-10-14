const express = require("express");
const app = express();
const joi = require("joi");
// toke模块引入
const jwt = require("./jwt");




// cors跨域
var cors = require("cors"); //先引入cors中间件
app.use(cors({ //添加允许跨域的客户端地址
  origin: ["http://localhost:8080", "http://127.0.0.1:5500"],
  credentials: true  //允许客户端发送cookie到服务器
}))

// 拦截特定请求进行token验证
app.use((req, res, next) => {
  // 测试期间 白名单为登录  实际为注册
  if (req.url != '/user/ulogin' &&
    (req.url.startsWith("/user") ||
      req.url.startsWith("/orders"))) {
    let token = req.headers.token;
    let result = jwt.verifyToken(token);
    // 如果考验通过就next，否则就返回登陆信息不正确
    if (result === undefined) {
      res.send({ status: 403, msg: "未提供证书" })
    } else if (result.name == 'TokenExpiredError') {
      res.send({ status: 403, msg: '登录超时，请重新登录' });
    } else if (result.name == "JsonWebTokenError") {
      res.send({ status: 403, msg: '证书出错' })
    } else {
      req.user = result;
      next();
    }
  } else {
    next();
  }
});


//引入路由地址
const userRouter = require("./router/user.js");
const adminRouter = require("./router/admin.js");
const shopcarRouter = require("./router/shopcar.js");
const Joi = require("joi");


//解析post中间件
app.use(express.urlencoded({
  extended: false
}));
//引入路由到app对象中
// 为所有用户路由前缀v1
app.use("/user", userRouter)

app.use("/sp", shopcarRouter)



//对错误格式进行错误处理
app.use((err, req, res, next) => {

  if (err instanceof joi.ValidationError) {
    return res.send({
      error: err,
      msg: "错误的提交格式"
    })
  }
  if (err) throw err
})





app.listen("4231", () => {
  console.log(`启动成功 端口号:4231`);
})