<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/4/26
 * Time: 16:31
 */

Class Mysql{

    //初始化函数
    protected $mysqli;
    public function __construct()
    {
        $this->mysqli = new mysqli('112.124.34.189','root','powu7788','weixinAdv');
        return $this->fetch();
    }

    //查询
    public function query(){

    }
}