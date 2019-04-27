<?php
namespace app\admin\controller;
use think\AjaxPage;
use think\Page;
use think\Db,think\Log;
use think\Loader;
use app\service\WechatService;

class Domain extends Base
{
    private $access_token;
    private $wechatService;

    public function init(){
        $this->wechatService=new WechatService();
        $this->access_token=$this->wechatService->getAccessToken();
    }

    public function dlist(){
        return $this->fetch();
    }
    
    public function index_ajax(){
        $count = Db::name('own_url')->where(array('adminid'=>$this->adminId))->count();
        $Page  = new AjaxPage($count,10);
        $urlList=Db::name('own_url')->where(array('adminid'=>$this->adminId))->limit($Page->firstRow.','.$Page->listRows)->select();
        $show = $Page->show();
        $this->assign('urlList',$urlList);
        $this->assign('page',$show);
        $this->assign('pager',$Page);
        return $this->fetch();
    }

    //添加域名
    public function add(){
        if (IS_POST) {
            // $data = input('post.');
            // $url= Db::name('own_url')->where(array('url'=>trim($data['url'])))->find();
            // if($url){
            //     echo -1;exit();
            // }else{
            //     $data['url']=trim($data['url']);
            //     $res=Db::name('own_url')->insert($data);
            //     if($res){
            //         echo 1;exit();
            //     }else{
            //         echo 0;exit();
            //     }; 
            // }
            $data = input('post.');
            $text = nl2br(trim($data['url']));//将分行符"\r\n"转义成HTML的换行符"<br />"
            $textArr = explode("<br />",$text);//"<br />"作为分隔切成数组
            $urlArr=array();//存放域名的数组
            //除去数组中的空格
            foreach($textArr as $val)
            {
                if(!empty($val)&&$val){
                    array_push($urlArr,$val);
                }
            }
            foreach($urlArr as $val){
                $url= Db::name('own_url')->where(array('url'=>trim($val),'adminid'=>$this->adminId))->find();
                if($url){
                    continue;
                }else{
                    $data['url']=trim($val);
                    $data['adminid']=$this->adminId;
                    $res=Db::name('own_url')->insert($data);
                }
            }
            echo 1;exit();
        }
        return $this->fetch();
    }

    //删除域名
    public function del(){
        $id = input('post.id/d');
        if($id>0){
            $row = Db::name('own_url')->where(array('id'=>$id,'adminid'=>$this->adminId))->delete();
            if($row){
                $this->ajaxReturn(array('status'=>1));
            }else{
                $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));

            }
        }else{
            $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
        }
    }

    //域名检测
    public function check(){
        
        return $this->fetch();
    }

    public function check_ajax(){
        if(IS_POST){
            $data = input('post.');
            $text = nl2br($data['checkurl']);//将分行符"\r\n"转义成HTML的换行符"<br />"
            $textArr = explode("<br />",$text);//"<br />"作为分隔切成数组




            $urlArr=array();//存放域名的数组
            //除去数组中的空格
            foreach($textArr as $val)
            {
                if(!empty($val)&&$val){
                    array_push($urlArr,$val);
                }
            }


            $log=new Log();
            $log->write($urlArr);



            $checkurls=$this->wechatService->handcheck($urlArr, $this->access_token);

            $log->write($checkurls);

            //这里进行检测，返回数据格式为网址+状态
//            $urlList=array();
            $this->assign('checklist',$checkurls);
            return $this->fetch();
        }
    }
  
}