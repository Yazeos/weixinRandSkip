<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/4/18
 * Time: 15:50
 */

$url='http://weixin.mudaxi.com';
$ch=curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_HEADER, 1);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

//执行命令
$data = curl_exec($ch);
$info = curl_getinfo($ch);
//关闭URL请求
curl_close($ch);
//var_dump($info);
echo $data;