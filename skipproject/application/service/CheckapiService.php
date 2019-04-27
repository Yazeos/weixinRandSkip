<?php

namespace app\service;

use think\Request;

/**
 * 对接自定义微信api的方法
 * Class CheckapiService
 * @package app\service
 */
class CheckapiService extends \app\util\Curl
{
    private $url = "http://weixin.mudaxi.com/handcheck";

    public function __construct(){
        Parent::__construct();
    }

    /**  weixin.mudaxi.com status api  check a
     * 自定义接口api
     * @param $url string 域名数组
     * @return int 1=> 正常 0=> 检测非法
     */
    public function checkurl($url){
        $postData['urls'][]=$url;
        $request=$this->curlRequest($this->url, $postData, 'POST');
        $check = json_decode($request['data'],true)['urls'];

       return $check[0]['status'] == "网页正常" ?1 :0;
    }

    /**
     * 批量检测url
     * @param $urls  url数组
     * @return mixed 检测结果 [ [0]=>url  [1]=>msg ]
     */
    public function checkUrls($urls){
        $postData['urls']=$urls;
        $request=$this->curlRequest($this->url, $postData, 'POST');
        return json_decode($request['data'],true)['urls'];
    }
}
