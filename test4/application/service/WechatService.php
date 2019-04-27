<?php

namespace app\service;

use think\Log,think\Cache,think\Config;
use app\util\Wechat;
use app\util\Curl;
use app\util\Email;

class WechatService
{
    //微信验证码
    private $appid;
    private $appsecret;
    private $config;
    private $curl;
    private $wechat;
    private $access;
    private $email;

    //初始化函数
    public function __construct() {
        $this->curl=new Curl;
        $this->wechat=new Wechat;
        $this->config=new Config;
        $this->email=new Email;
        $this->appid=$this->config->get('wechat.appid');
        $this->appsecret=$this->config->get('wechat.appsecret');
        $this->access="access_token";
    }

    /**
     * 微信域名检测的最终方法
     * @param $checkurl         需要检测的url名称
     * @param $access_token     用户获取的授权token
     * @return bool             返回状态 false网页被封|true正常
     */
    public function checkUrl($checkurl, $access_token){
        $data=[
            'action'=>"long2short",
            "long_url"=>$checkurl
        ];
        //生成短连接
        $short_url=$this->createShortUrl($access_token,$data);

        return $this->checkWechatCover($short_url);
    }

    /**
     * 手动批量检测网页，返回结果
     * @param $urls         需要检测的网页
     * @param $access_token 微信授权token
     * @param boolean $isSql        是否sql数组检测
     * @return mixed        返回检测后的结果urls,是sql返回id
     */
    public function handcheck($urls, $access_token, $isSql=false){
        foreach($urls as $k => $url) {
            if(empty(trim($url))) continue;

            if($isSql) {
                $checkurl = $url['url'];
                if (!$this->checkUrl($checkurl, $access_token)) {
                   //"----网页被封";
                    $return_urls['msg'][]= $urls[$k] ."----网页被封\n\r";
                    $return_urls['ids'][]=$url['id'];
                }
                    //"----网页正常";
            }else{
                $checkurl = $url;
                $return_urls['urls'][$k]['url'] =$urls[$k];
                $return_urls['ids'][]=$k;

                switch($this->checkUrl($checkurl, $access_token)){
                    case 0:
                        $return_urls['urls'][$k]['status'] = "网页被封";
                        break;
                    case -1:
                        $return_urls['urls'][$k]['status'] = "请求超时";
                        break;
                    case 1:
                        $return_urls['urls'][$k]['status'] = "网页正常";
                        break;
                }

//                if (!$this->checkUrl($checkurl, $access_token)) {
//                    $return_urls['urls'][$k]['status'] = "网页被封";
//                } else {
//                    $return_urls['urls'][$k]['status'] = "网页正常";
//                }
            }
        }
        return $return_urls;
    }

    //定时触发检测数据库中所有正常的网页
    public function autoCheck(){
        //数据库取出访问正常的url数据,场景区分
        //select xxx with ('fdf'=> where status =1 ) from xxx
        $data='';

        //分批检测
        foreach($data as $k => $info) {
            $checkurls=$this->handcheck($info['urls'], $this->access_token,true);

            //如果正常网页检测出风险，则发送邮件
            $title='封号检测1232';
            $message=$checkurls['msg'];
            $postuser='1042451513@qq.com';
            if($checkurls) {
                return $this->email->sendMessage($title,$message,$postuser);
            }
        }
    }

    /**
     * 生成微信授权token
     * @return access_token 授权token
     */
    public function getAccessToken() {
        $url=$this->wechat->getAccessUrl($this->appid,$this->appsecret);

        $cache=new Cache();
        if($cache->get($this->access)) {
            $token=$cache->get($this->access);
        } else {
            $token=$this->curl->curlRequest($url)['data'];
            $cache->set($this->access,$token,3000);
        }

        return json_decode($token,true)['access_token'];
    }

    /**
     * 通过微信的api创建短连接
     * @param $access_token 微信授权token码
     * @param $checkurl
     * @param $data
     * @return mixed
     */
    public function createShortUrl($access_token,$data){
        $short_url=$this->wechat->getShortUrl($access_token);
        $data=$this->curl->curlRequest($short_url, $data, 'POST')['data'];

        return json_decode($data,true)['short_url'];
    }

    /**
     * 验证短连接检测URL是否被微信检测
     * @param $short_url    需要测试的url
     * @return bool         是否被检测到，false被检测，true正常
     */
    public function checkWechatCover($short_url)
    {
        $return_url = $this->curl->curlRequest($short_url)['header']['redirect_url'];

        if(!$return_url) {
            return -1;
        }else if(strstr($return_url,$this->config->get('wechat.check_url'))){
            return 0;
        }else {
            return 1;
        }
    }
}
