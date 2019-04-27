<?php
namespace app\admin\controller;
use think\AjaxPage;
use think\Db;

class Emailog extends Base
{
    public function elist(){
        return $this->fetch();
    }
    
    public function index_ajax(){
        $count = Db::name('email_log')->where(array('adminid'=>$this->adminId))->count();
        $Page  = new AjaxPage($count,10);
        $logList=Db::name('email_log')->where(array('adminid'=>$this->adminId))->limit($Page->firstRow.','.$Page->listRows)->select();
        $show = $Page->show();
        $this->assign('logList',$logList);
        $this->assign('page',$show);
        $this->assign('pager',$Page);
        return $this->fetch();
    }


    //删除日志
    public function del(){
        $id = input('post.id/d');
        if($id>0){
            $row = Db::name('email_log')->where(array('id'=>$id))->delete();
            if($row){
                $this->ajaxReturn(array('status'=>1));
            }else{
                $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));

            }
        }else{
            $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
        }
    }
  
}