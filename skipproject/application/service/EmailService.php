<?php

namespace app\service;

use think\Log;
use app\util\Email;

class EmailService
{
    private $email;
    public function __construct(){
        $this->email=new Email;
    }

    /**
     * 发送邮件的方法
     * @param $title        邮件的标题
     * @param $message      邮件的主体消息
     * @param $postuser     邮件的收件人
     * @return bool         发送邮件返回的状态
     */
    public function sendMessage($title,$message,$postuser){
        return $this->email->sendMessage($title,$message,$postuser);
    }
}
