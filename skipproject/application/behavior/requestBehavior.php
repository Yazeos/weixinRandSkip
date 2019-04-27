<?php

namespace app\behavior;

use think\Session;

class requestBehavior
{
    /**
     * 邮箱的超时请求，防止重复发送
     */
    public function run(){
        $session=new Session;
        if($session->get('LOGIN_TIME')&&$session->get('LOGIN_TIME')>time()) {
            exit;
        } else {
            $session->set('LOGIN_TIME', time());
        }
    }
}
