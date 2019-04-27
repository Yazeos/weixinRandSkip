<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/4/16
 * Time: 15:46
 */

namespace app\util;

use think\Log;
use app\util\Curl;

class Wechat{

    private $token=WECHATTOKEN;

    public function check($request){

        $Log=new Log;
        $signature=$request->param("signature");
        $timestamp=$request->param("timestamp");
        $nonce=$request->param("nonce");
//        $echostr=request()->param("echostr");

//        Log::write(Request::param());
//        Log::write('timestamp =====> '.$timestamp);
//        Log::write('nonce =====> '.$nonce);

        $tmpArr = array($timestamp, $nonce,$this->token);
        sort($tmpArr);
        $tmpStr = implode( $tmpArr );
        $tmpStr = sha1( $tmpStr );

        if( $signature==$tmpStr ) {
            return true;
        }
        return false;
    }

    //获取AcdcessToken访问路径
    public function getAccessUrl($appid,$appsecret) {
        return "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$appid}&secret={$appsecret}";
    }

    //生成微信长连接转短连接的api访问路径
    public function getShortUrl($access_token) {
       return sprintf('https://api.weixin.qq.com/cgi-bin/shorturl?access_token=%s', $access_token);
    }


}