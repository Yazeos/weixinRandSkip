<?php

namespace app\model;

use think\Model;

class Provincial extends Model
{
    //关联城市
    public function city()
    {
        return $this->hasMany('City','pid','pid');
    }
}
