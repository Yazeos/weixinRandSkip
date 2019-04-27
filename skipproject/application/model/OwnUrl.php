<?php

namespace app\model;

use think\Model;

class OwnUrl extends Model
{
    protected $pk="id";

    //管理员用户
    public function admin()
    {
        return $this->hasMany('Admin','admin_id','adminid');
    }
}
