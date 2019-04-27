<?php

namespace app\service;

use think\Log;
use app\util\IpInfo;
use app\util\Curl;

/**
 * ip处理类
 * Class File
 * @package app\service
 */
class IpInfoService
{
    private $ipinfo;

    public function __construct()
    {
        $this->ipinfo=new IpInfo();
    }

    //ip地址检测
    public function ipcheck(){

    }

    //ip地址返回
    public function ipLocal($ip){
        $curl=new Curl();
        $url='http://sp0.baidu.com/8aQDcjqpAAV3otqbppnN2DJv/api.php?query='.$ip.'&resource_id=6006';
        $data=json($curl->curlRequest($url)['data'])->getData();
//        return $data;
        return json_decode($data,true)['data'][0]['location'];
//        return $this->ipinfo->iplocal($ip);
    }
}