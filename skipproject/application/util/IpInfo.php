<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/4/18
 * Time: 17:33
 */
namespace app\util;

class IpInfo
{
    public function iplocal($ip){
        $url='http://sp0.baidu.com/8aQDcjqpAAV3otqbppnN2DJv/api.php?query='.$ip.'&resource_id=6006';
        $ch=curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

        //执行命令
        $data = curl_exec($ch);
        $cContent = curl_getinfo($ch);
        //关闭URL请求

        curl_close($ch);
    }
}