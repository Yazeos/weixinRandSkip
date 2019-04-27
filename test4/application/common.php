<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件
use think\Log;
use think\Db;

/**
 * 获取缓存或者更新缓存
 * @param string $config_key 缓存文件名称
 * @param array $data 缓存数据  array('k1'=>'v1','k2'=>'v3')
 * @return array or string or bool
 */
function tpCache($config_key,$data = array()){
    $param = explode('.', $config_key);
    if(empty($data)){
        //如$config_key=shop_info则获取网站信息数组
        //如$config_key=shop_info.logo则获取网站logo字符串
        $config = cache($param[0],'',TEMP_PATH);//直接获取缓存文件
        if(empty($config)){
            //缓存文件不存在就读取数据库
            $res = Db::name('config')->where("inc_type",$param[0])->select();
            if($res){
                foreach($res as $k=>$val){
                    $config[$val['name']] = $val['value'];
                }
                cache($param[0],$config,TEMP_PATH);
            }
        }
        if(count($param)>1){
            return $config[$param[1]];
        }else{
            return $config;
        }
    }else{
        //更新缓存
        $result =  Db::name('config')->where("inc_type", $param[0])->select();
        if($result){
            foreach($result as $val){
                $temp[$val['name']] = $val['value'];
            }
            foreach ($data as $k=>$v){
                $newArr = array('name'=>$k,'value'=>trim($v),'inc_type'=>$param[0]);
                if(!isset($temp[$k])){
                    Db::name('config')->add($newArr);//新key数据插入数据库
                }else{
                    if($v!=$temp[$k])
                        Db::name('config')->where("name", $k)->insert($newArr);//缓存key存在且值有变更新此项
                }
            }
            //更新后的数据库记录
            $newRes = Db::name('config')->where("inc_type", $param[0])->select();
            foreach ($newRes as $rs){
                $newData[$rs['name']] = $rs['value'];
            }
        }else{
            foreach($data as $k=>$v){
                $newArr[] = array('name'=>$k,'value'=>trim($v),'inc_type'=>$param[0]);
            }
            Db::name('config')->insertAll($newArr);
            $newData = $data;
        }
        return cache($param[0],$newData,TEMP_PATH);
    }
}

/**
 * 记录帐户变动
 * @param   int     $user_id        用户id
 * @param   int    $user_money     可用余额变动
 * @param   int     $pay_points     消费积分变动
 * @param   string  $desc    变动说明
 * @param   int    distribut_money 分佣金额
 * @param int $order_id 订单id
 * @param string $order_sn 订单sn
 * @return  bool
 */
function accountLog($user_id, $user_money = 0,$pay_points = 0, $desc = '',$distribut_money = 0,$order_id = 0 ,$order_sn = ''){
    /* 插入帐户变动记录 */
    $account_log = array(
        'user_id'       => $user_id,
        'user_money'    => $user_money,
        'pay_points'    => $pay_points,
        'change_time'   => time(),
        'desc'   => $desc,
        'order_id' => $order_id,
        'order_sn' => $order_sn
    );
    /* 更新用户信息 */
    $update_data = array(
        'user_money'        => Db::raw('user_money+'.$user_money),
        'pay_points'        => Db::raw('pay_points+'.$pay_points),
        'distribut_money'   => Db::raw('distribut_money+'.$distribut_money),
    );
    if(($user_money+$pay_points+$distribut_money) == 0)return false;
    
    //echo $user_money.'--'.$pay_points.'--'.$distribut_money.'--'.$user_id;die;
    $update = Db::table('pw_users')->where('user_id', $user_id)->update($update_data);

    if($update){
        Db::name('account_log')->insert($account_log);
        return true;
    }else{
        return false;
    }
}

/**
 * 写入静态页面缓存
 */
function write_html_cache($html){
    $html_cache_arr = C('HTML_CACHE_ARR');
    $request = think\Request::instance();
    $m_c_a_str = $request->module().'_'.$request->controller().'_'.$request->action(); // 模块_控制器_方法
    $m_c_a_str = strtolower($m_c_a_str);
    //exit('write_html_cache写入缓存<br/>');
    foreach($html_cache_arr as $key=>$val)
    {
        $val['mca'] = strtolower($val['mca']);
        if($val['mca'] != $m_c_a_str) //不是当前 模块 控制器 方法 直接跳过
            continue;
        $filename =  $m_c_a_str;
        // 组合参数  
        if(isset($val['p']))
        {
            foreach($val['p'] as $k=>$v)
                $filename.='_'.$_GET[$v];
        }
        $filename.= '.html';
        \think\Cache::set($filename,$html);
    }
}

/**
 * 读取静态页面缓存
 */
function read_html_cache(){
    $html_cache_arr = C('HTML_CACHE_ARR');
    $request = think\Request::instance();
    $m_c_a_str = $request->module().'_'.$request->controller().'_'.$request->action(); // 模块_控制器_方法
    $m_c_a_str = strtolower($m_c_a_str);
    foreach($html_cache_arr as $key=>$val)
    {
        $val['mca'] = strtolower($val['mca']);
        if($val['mca'] != $m_c_a_str) //不是当前 模块 控制器 方法 直接跳过
            continue;
        $filename =  $m_c_a_str;
        // 组合参数        
        if(isset($val['p']))
        {
            foreach($val['p'] as $k=>$v)
                $filename.='_'.$_GET[$v];
        }
        $filename.= '.html';
        $html = \think\Cache::get($filename);
        if($html)
        {
            echo \think\Cache::get($filename);
            exit();
        }
    }
}

/**
 * 支付完成修改订单
 * @param $order_sn 订单号
 * @param array $ext 额外参数
 * @return bool|void
 */
function update_pay_status($order_sn,$ext=array())
{
    $time=time();
    if(stripos($order_sn,'recharge') !== false){
        //用户在线充值
        $order = Db::name('recharge')->where(['order_sn' => $order_sn, 'pay_status' => 0])->find();
        if (!$order) return false;
        Db::name('recharge')->where("order_sn",$order_sn)->update(array('pay_status'=>1,'pay_time'=>$time));
        //账户总额增加
        $user= Db::name('users')->where(['user_id' => $order['user_id']])->find();
        $user_money=$user['user_money'] + $order['account'];
        Db::name('users')->where("user_id",$order['user_id'])->update(array('user_money'=>$user_money));

        //$msg = '会员在线充值';
        //accountLog($order['user_id'],$order['account'],0, $msg, 0, 0, $order_sn);
    }
}

/**
 * 核验当前广告能否展示
 * @system 为是否系统发布
 * @return 正数为可以展示，负数不通过
 */
function checkWallIsShow($wallId, $showTime, $endTime, $system = false)
{
    $DbObj = $system?Db::name('default_advertise'):Db::name('user_wall');
    if ($showTime<time())return -5;
    if (!is_numeric($wallId)|| !is_numeric($showTime)|| !is_numeric($endTime)|| $showTime>$endTime)return -1;
    if ($DbObj->where('wall_id', $wallId)->where('show_time', $showTime)->find())return -2;
    $preLog = $DbObj->where('wall_id', $wallId)->where('show_time', '<', $showTime)->where('show_time','>',1)->order('show_time desc')->find();
    $nextLog = $DbObj->where('wall_id', $wallId)->where('show_time', '>', $showTime)->order('show_time asc')->find();
    if (empty($preLog)&& empty($nextLog))return 1;
    if (empty($nextLog)&& $preLog['end_time']) {
        return $preLog['end_time']<$showTime?2:-3;
    }else{
        return ($preLog['end_time']<$showTime&& $endTime<$nextLog['show_time'])?3:-4;
    } 
}



function getselectorradio($str){
    $listval = array(
        'nation'=>"壮族、藏族、裕固族、彝族、瑶族、锡伯族、乌孜别克族、维吾尔族、佤族、土家族、土族、塔塔尔族、塔吉克族、水族、畲族、撒拉族、羌族、普米族、怒族、纳西族、仫佬族、苗族、蒙古族、门巴族、毛南族、满族、珞巴族、僳僳族、黎族、拉祜族、柯尔克孜族、景颇族、京族、基诺族、回族、赫哲族、哈萨克族、哈尼族、仡佬族、高山族、鄂温克族、俄罗斯族、鄂伦春族、独龙族、东乡族、侗族、德昂族、傣族、达斡尔族、朝鲜族、布依族、保安族、布朗族、白族、阿昌族、汉族",
        'sex'=>"男、女",
        'homeplace'=>"北京、天津、上海、重庆、河北、河南、云南、辽宁、黑龙江、湖南、安徽、山东、新疆、江苏、浙江、江西、湖北、广西、甘肃、山西、内蒙古、陕西、吉林、福建、贵州、广东、青海、西藏、四川、宁夏回族、海南、台湾、香港、澳门"
    );
    $res=explode('、', $listval[$str]);
    return $res;
}
