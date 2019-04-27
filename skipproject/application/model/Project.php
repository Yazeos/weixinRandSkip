<?php

namespace app\model;

use think\Model;
//use app\model\JumpUrl;
//use app\model\JumpType;

class Project extends Model
{
    protected $pk="id";

    //关联跳转规则表
    public function jumpType()
    {
        return $this->hasOne('JumpType','id','jumptype');
    }

    //关联落地页
    public function jumpUrl()
    {
        return $this->hasMany('JumpUrl','pid','id');
    }

    //地区限制
    public function restrict()
    {
        return $this->hasMany('Restrict','pid','id');
    }

    //用户落地页
    public function portalurl()
    {
        return $this->hasMany('PortalUrl','pid','id');
    }

    //管理员用户
    public function admin()
    {
        return $this->hasMany('Admin','admin_id','adminid');
    }
}
