<?php

namespace app\util;

use think\Log;

class Curl
{
    public function __construct(){

    }

    //curl请求
    public function curlRequest($url, $data=[], $method="GET") {
//        $url="https://w.url.cn/s/Az0zf4O";
        $ch=curl_init();
//        echo $url;
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
//        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
//        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        //判断是否post请求
        if(strtoupper($method) == "POST") {
            //设置post方式提交
            curl_setopt($ch, CURLOPT_POST, 1);
            //设置post数据
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data,true));
        }

        //执行命令
        $data = curl_exec($ch);
        $cContent = curl_getinfo($ch);
        //关闭URL请求
//        if($cContent['http_code']==200) {
//            return $data;
//        }

        curl_close($ch);
//        dump($cContent);
//        dump($data);
        $data=mb_convert_encoding($data,'UTF-8',['ASCII','UTF-8','GB2312','GBK']);
        $result=['header'=>$cContent,'data'=>substr($data,$cContent['header_size'])];

        return $result;
    }
}
