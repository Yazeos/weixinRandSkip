<?php

namespace app\service;

use think\Log;
use app\model\Project;
use app\model\PortalUrl;


/**
 * 文件处理类
 * Class File
 * @package app\service
 */
class FileService
{
    //模版文件路径
    protected $modelFile;
    protected $path='/a';
    protected $ext='html';

    public function __construct(){
        $this->modelFile = ROOT_PATH.'/public/model/model.html';
    }

    //返回一个html文件名称
    public function randomFile($num, $path) {

        $filename=$this->randomStr($num).'.'.$this->ext;
        $filepath=$this->path.$path.'/'.$filename;
        if(file_exists($filepath)){
            $filepath=$this->randomFile($num, $path);
        }

        return $this->path.$path.'/'.$filename;
    }

    //返回一个随机名称
    public function randomStr($num){
        $str="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
        return substr(str_shuffle($str),mt_rand(0,strlen($str)-11),10);
    }


    /**
     * 文件跳转规则字符串生成
     * @param boolean $isRandom 是否随机
     * @param array $urls     跳转的urls字符集
     * @return string $urlstr 替换的字符串规则
     */
    public function sikpsort($random_type=1,$urls=[]){
        $urlstr='';
        foreach($urls as $url){
            $urlstr.='"'.$url.'",';
        }

        $urlstr='var arr = ['.rtrim($urlstr,',').'];';

        if($random_type == 2 || $random_type == 1) {

$str= "
        history.pushState({},
        '', '');
        var sign = sessionStorage.getItem('sign7n21tbxk') || 0;
        sign = parseInt(sign);
";
            $urlstr=$str.$urlstr;


        }else if($random_type == 3 || $random_type == 4 ) {
            $urlstr.='window.location.href=arr[0]; ';
        }

$urlstr .= 'sign %= arr.length;
        var target = arr[sign];
        sessionStorage.setItem(\'sign7n21tbxk\', parseInt(sign) + 1);
        document.title = \'　\';

        var a = document.createElement(\'a\');
        a.href = ubb(target);
        a.rel = \'noreferrer\';
        a.click();';

        if($random_type == 2){
            $urlstr.='sign += Math.ceil(Math.random()*3);
                sessionStorage.setItem(\'sign7n21tbxk\', parseInt(sign) + 1);
                document.title = \'　\';
            ';
        }

        return $urlstr;
    }

    /**
     * ajax请求点击量
     * @param $porUrlId  int  入口网址id
     * @return string   ajax点击字符串
     */
    public function addhitstr($porUrlId)
    {
        $addhit='
            var xmlhttp;

	 if(window.XMLHttpRequest){
	 	xmlhttp=new XMLHttpRequest();
	 }else{
	 	xmlhttp = new ActiveXObject(\'Microsoft.XMLHTTP\');
	 }

	 xmlhttp.onreadystatechange=function(){
	 	if(xmlhttp.readState == 4 && xmlhttp.status == 200 ){
	 		alert(xmlhttp.responseText);
	 	}else if(xmlhttp.status == 404){
	 		alert(\'error\');
	 	}
	 }


	 xmlhttp.open(\'POST\',\'http://testss.mudaxi.com/hit\',true);
	 xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	 xmlhttp.send(\'id='.$porUrlId.'\');
            ';

        return $addhit;
    }

    /**
     * 获取文件跳转类型
     * @param $projectId    项目id
     * @return mixed        项目跳转类型
     */
    public function getRandomType($projectId)
    {
        $randomid = Project::where('id',$projectId)->field('id,jumptype')->select()[0];
        return $randomid['jumptype'];
    }

    /**
     * 根据跳转类型返回urls
     * @param $random_type
     * @param $projectid
     * @return array
     */
    public function getJumpUrls($random_type,$projectid)
    {
        $where=[
            ['isuse','=',1],
            ['status','=',1]
        ];
        $projectInfo = Project::where('id',$projectid)->field('*')->with([
            'jumpUrl'=>function($jumpurl) use ($where){
                $jumpurl->where('isuse',1)->field('pid,url,isdefault');
            }
        ])->select();

        if (!empty($projectInfo[0])) {
            $jump_urls = $projectInfo[0]['jump_url'];



            //直接跳转和随机直接跳转
            foreach ($jump_urls as $k => $jump_url) {
                if ($jump_url['isdefault'] == 1) {
                    $defaultkey=$k;
                    $defaultUrl = $jump_url['url'];
                }
                $urls[] = $jump_url['url'];
            }

            //跳转方式  1 顺序跳转 2 随机跳转 3 直接跳转 4 随机直接跳转
            if ( $random_type == 3 && isset($defaultkey) ) {
                $returnUrls[] = $defaultUrl;//$urls[$defaultkey];

            } else if ($random_type == 4 || ($random_type == 3 && empty($defaultkey) ) ) {
                $returnUrls[] = $urls[mt_rand(0, count($urls)-1 )];
            } else {
                if( !empty($defaultkey) ){
                    $returnUrls = $this->pointSort($defaultkey ,$urls);
                }else{
                    $returnUrls = $this->pointSort(mt_rand(0, count($urls)-1 ) ,$urls);
                }

//                $returnUrls = $urls;
            }

            return $returnUrls;
        } else {
            return [];
        }
    }

    //新增数据库跳转url
    public function addJumpUrl($data)
    {
        return PortalUrl::insert($data);
    }

    //指定位置排序
    public function pointSort($key,$data){
        $returns=[];
        for($i = 0;$i < count($data);$i++){
            $returns[]=$data[$key++];
            $key %= count($data);
        }

        return $returns;
    }
}
