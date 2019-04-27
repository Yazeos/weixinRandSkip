<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019/4/18
 * Time: 17:47
 */

namespace app\behavior;

use think\Session,think\Exception;
use app\service\IpInfoService;
use app\model\PortalUrl;

class ipcheckBehavior
{
    //限制ip地址访问
    public function run()
    {
//        echo $_SERVER['PATH_INFO'];
        if(strstr($_SERVER['PATH_INFO'],'/a/')) {

            $ip = $_SERVER['REMOTE_ADDR'];
            if (!$ip) {
                exit('ip地区限制1');
            }

            if (!$server_name = ($_SERVER['HTTP_HOST'] . $_SERVER['PATH_INFO'])) {
                exit('ip地区限制2');
            }

            $ipinfoService = new IpInfoService();
            $iplocal = $ipinfoService->ipLocal($ip);
            $vince = explode('省', $iplocal);
            $province = $vince[0];
            $city = explode('市', $vince[1])[0];
//            echo $city;

            //        $server_name='www.powu.com/tk7i28.html';
            try {
                $data = PortalUrl::where("url like '%".$server_name."'")->with([
                    'project' => function ($project) {
                        $project->field('*')->with('restrict');
                    }
                ])->select()[0]['project'][0]['restrict'];
                if (!$data) exit('ip地区限制3');


                foreach ($data as $v) {
                    if (strstr($v['city_name'], $city)) {
                        exit('ip被限制4');
                    }
                }
            } catch (\Exception $e) {
                exit('ip地区限制5');
            }
        }
    }
}