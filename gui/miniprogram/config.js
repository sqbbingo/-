(function (module){
        var exports = module.exports = {};
        //产品ID
        var productid = 194413;
        //产品密钥
        var secret = "Vt2rLag7l9LtcqUn7dT87psfxEY=";
//room1
        //设备ID
        var deviceid = 517500623;
        //鉴权信息
        var authinfo = "homewater";
//room2
        //设备ID
        var deviceid2 = 510461991;
        //鉴权信息
        var authinfo2 = "nodemcu02";


        //根域名
        var url = "https://api.heclouds.com/";

// room1
        //根域名+设备
        var url_devic = url + 'devices/' + deviceid;
        //上传数据点url
        var url_send_data = url_devic + '/datapoints';
        //发布消息
        var url_send_mqttdata = url + 'mqtt?topic=';
// room2
        //根域名+设备
        var url_devic2 = url + 'devices/' + deviceid2;
        //上传数据点url
        var url_send_data2 = url_devic2 + '/datapoints';
        //发布消息
        var url_send_mqttdata2 = url + 'mqtt?topic=';
// 公共
        //请求的头部
        var header = {
                        'Content-Type': 'application/json',
                        "api-key": "Vt2rLag7l9LtcqUn7dT87psfxEY=",
        }

        //向onenet发送publish数据
        var PublishTheme = function(theme,state){
                wx.request({
                                method:'POST',
                                url:'https://api.heclouds.com/mqtt?topic=' + theme,         //publish主题
                                data: {
                                        "message":state
                                },
                                header:header,
                                success: function(res) {        //调用成功后的回调函数
                                }
                        })
        }

        module.exports = {
                config:{
                                // 公共
                                secret:secret,
                                productid:productid,
                                url:url,
                                header:header,
                                PublishTheme:PublishTheme,
                                // room1
                                deviceid:deviceid,
                                authinfo:authinfo,
                                url_devic:url_devic,
                                url_send_data:url_send_data,
                                url_send_mqttdata:url_send_mqttdata,
                                // room2
                                deviceid2:deviceid2,
                                authinfo2:authinfo2,
                                url_devic2:url_devic2,
                                url_send_data2:url_send_data2,
                                url_send_mqttdata2:url_send_mqttdata2                               
                }
        };
})(module);