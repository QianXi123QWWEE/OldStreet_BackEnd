const crypto=require('crypto')

//获取crypto 支持的散列算法



module.exports= str=>{
    return  crypto.createHash('md5')
    .update('wncf' +str)
    .digest('hex');
}
