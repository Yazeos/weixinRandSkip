<?php
// 应用公共文件
define('WECHATTOKEN','wengdada');
function getMenuArr(){
	$menuArr = include APP_PATH.'admin/conf/menu.php';
	$act_list = session('act_list');
	if($act_list != 'all' && !empty($act_list)){
		$right = M('system_menu')->where("id in ($act_list)")->cache(true)->getField('right',true);
        $role_right = '';
		foreach ($right as $val){
			$role_right .= $val.',';
		}
		foreach($menuArr as $k=>$val){
			foreach ($val['child'] as $j=>$v){
				foreach ($v['child'] as $s=>$son){
					if(strpos($role_right,$son['op'].'@'.$son['act']) === false){
						unset($menuArr[$k]['child'][$j]['child'][$s]);//过滤菜单
					}
				}
			}
		}
		foreach ($menuArr as $mk=>$mr){
			foreach ($mr['child'] as $nk=>$nrr){
				if(empty($nrr['child'])){
					unset($menuArr[$mk]['child'][$nk]);
				}
			}
		}
	}
	return $menuArr;
}

/**
 * 导出excel
 * @param $strTable	表格内容
 * @param $filename 文件名
 */
function downloadExcel($strTable,$filename)
{
	header("Content-type: application/vnd.ms-excel");
	header("Content-Type: application/force-download");
	header("Content-Disposition: attachment; filename=".$filename."_".date('Y-m-d').".xls");
	header('Expires:0');
	header('Pragma:public');
	echo '<html><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'.$strTable.'</html>';
}

 //生成随机字符串
function create_random_string($url) {
	//return $url;
	$url=$url;
    $random_length=mt_rand(5,10);
    $chars = "23456789abcdefghijkmnpqrstuvwxyz";
    $randomStr = '';
    for ($i = 0; $i < $random_length; $i++) {
        $randomStr .= $chars[mt_rand(0, strlen($chars) - 1)];
    }
    $newurl='http://'.$url.'/'.$randomStr.'.html';
    $count = M('own_url')->where(array('url' =>$newurl))->count();
    if($count){
        create_random_string($url);
    }else{
        return  $newurl;
    }
}   
