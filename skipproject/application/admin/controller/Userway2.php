<?php
namespace app\admin\controller;
header("Content-Type: text/html; charset=utf-8");

use think\Request;
use think\Log;
use think\Cache;
use app\service\WechatService;
use app\service\EmailService;
use app\service\FileService;

class Userway extends Base
{
    //微信验证码
    private $access_token;
    private $wechatService;
    private $emailService;
    private $fileService;

    //自定义声明的初始化函数
    public function init(){
        $this->wechatService=new WechatService();
        $this->emailService=new EmailService();
        $this->fileService=new FileService();
        $this->access_token=$this->wechatService->getAccessToken();
    }

    //主页入口
    //return string
    //send url
    public function index(Request $request)
    {
        return $this->filebindurl();
//        return json($this->fileService->getJumpUrls(1, 2));
    }

    //发送邮件
    public function sendemail(){
        $param=request()->param();
        $title='封号检测1232';
        $message='网址被封321321';
        $postuser='1042451513@qq.com';
        return $this->emailService->sendMessage($title,$message,$postuser);
    }

    //根据返回的域名生成静态的无限跳转页面并更新数据库
    public function filebindurl() {
        //拿到前台url
//        $saveUrl=request()->param();
        //保存到数据库的域名
        $saveUrl='www.wengdada.com';
        $projectid='2';

        //生成的文件目录名
        $num=6;
        $path='/j';
        //是否随机字符串
        $random_type=$this->fileService->getRandomType($projectid);
        //从数据库读取域名对应场景的域名集 --------  urls
//        $urls=["http://www.zk10.cn", "http://www.baidu.com", "http://www.pdlgcable.com"];

        $urls=$this->fileService->getJumpUrls($random_type,$projectid);
        //替换字符串
        $pattern=[
            '/\{\{\$random\}\}/iU'
        ];
        $replace=[
            $this->fileService->sikpsort($random_type, $urls),
        ];
        //静态文件路径
        $filepath=$this->fileService->staticFile($pattern, $replace, $num, $path);
        //更新数据库update  bangdinyuming
        $domain=$saveUrl.$filepath;

        $data=[
            'pid' => $projectid,
            'url' => $domain,
            'localpath' => $filepath,
            'createtime' => time(),
            'mark' => '',
        ];

        $this->fileService->addJumpUrl($data);

        //返回路径名称
        echo $domain;
    }

    //手动批量检测urls，需要ajax或者其他方式传递消息
    //检测有失败网址发送一次邮件
    public function handcheck() {
        //获取urls集进行检测
        $urls=request()->param();

        $checkurls=$this->wechatService->handcheck($urls, $this->access_token);

        return json($checkurls);
    }

    public function autocheck() {
        //获取urls集进行检测
        //$urls=request()->param();

        $checkurls=$this->wechatService->autocheck();

        return json($checkurls);
    }

    //通过workerman定时请求
    public function timercheck() {
        $this->wechatService->autoCheck();
    }

}
