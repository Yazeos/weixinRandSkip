<?php

namespace app\model;

use think\Model;

class PortalUrl extends Model
{
    protected $pk="id";

    //关联项目
    public function project()
    {
        return $this->hasMany('Project','id','pid');
    }
}
