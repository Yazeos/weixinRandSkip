<?php

namespace app\util;

use think\Log,think\Config;
use phpmail\PHPMailer;
use phpmail\SMTP;
use app\model\EmailLog;

class Email
{
    private $config;
    //access_token = nnorffbvkfysbcda
    public function __construct() {
        $config=new Config();
        $this->config=$config->get('phpmail');
    }

    /**
     * 发送邮件的方法
     * @param $title        邮件的标题
     * @param $message      邮件的主体消息
     * @param $postuser     邮件的收件人
     * @return bool         发送邮件返回的状态
     */
    public function sendMessage($title,$message,$postuser,$adminid=1){
        // 实例化PHPMailer核心类
        $mail = new PHPMailer();
        // 是否启用smtp的debug进行调试 开发环境建议开启 生产环境注释掉即可 默认关闭debug调试模式
        $mail->SMTPDebug = 0;
        // 使用smtp鉴权方式发送邮件
        $mail->isSMTP();
        // smtp需要鉴权 这个必须是true
        $mail->SMTPAuth = true;
        // 链接qq域名邮箱的服务器地址
        $mail->Host = $this->config['host'] ;
        // 设置使用ssl加密方式登录鉴权
        $mail->SMTPSecure = 'ssl';
        // 设置ssl连接smtp服务器的远程服务器端口号
        $mail->Port = $this->config['port'];
        // 设置发送的邮件的编码
        $mail->CharSet = 'UTF-8';
        // 设置发件人昵称 显示在收件人邮件的发件人邮箱地址前的发件人姓名
        $mail->FromName = $this->config['nickname'];
        // smtp登录的账号 QQ邮箱即可
        $mail->Username = $this->config['username'];
        // smtp登录的密码 使用生成的授权码
        $mail->Password = $this->config['password'];
        // 设置发件人邮箱地址 同登录账号
        $mail->From = $this->config['username'];
        // 邮件正文是否为html编码 注意此处是一个方法
        $mail->isHTML(true);
        // 设置收件人邮箱地址
//        if(is_array($postuser)) {
//            foreach($postuser as $k => $user){
//                $mail->addAddress($user);
//            }
//        } else {
            $mail->addAddress($postuser);
//        }
        // 添加多个收件人 则多次调用方法即可
       // $mail->addAddress('87654321@163.com');
        // 添加该邮件的主题
        $mail->Subject = $title;
        // 添加邮件正文
        $mail->Body = $message;
        // 为该邮件添加附件
        // $mail->addAttachment('./example.pdf');
        // 发送邮件 返回状态
        $status = $mail->send();
        $this->recordLog($title,$message,$postuser,$adminid);
        // return
//        return $status;
    }

    //记录发送日志
    public function recordLog($title='',$content='',$postuser,$adminid){
        $emailLog=new EmailLog();
        $data=[
            'title' => $title,
            'content' => $content,
            'email' => $postuser,
            'sendtime' => time(),
            'adminid' => $adminid,
        ];
        $emailLog->insert($data);
    }

}
