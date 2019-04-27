<?php
namespace app\admin\controller;
use think\AjaxPage;
use think\Page;
use think\Db,think\Log;
use app\util\Curl;
use app\service\WechatService;
use app\service\CheckapiService;

class Domain extends Base
{
    private $access_token;
    private $wechatService;
    private $curl;

    public function init(){
        $this->wechatService=new WechatService();
        $this->checkapiService=new CheckapiService();
        $this->curl=new Curl;
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
                    $status = $this->checkapiService->checkurl($val);
                    $data['status'] = $status ?1 :2;
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

            $checkurls = $this->checkapiService->checkUrls($urlArr);
            $this->assign('checklist',$checkurls);
            return $this->fetch();
        }
    }

    public function check_auto(){
        $log=new Log();
        //$log->write($urlArr);
        $checkurls=$this->wechatService->autoCheck();
        $log->write($checkurls);
    }
  
}