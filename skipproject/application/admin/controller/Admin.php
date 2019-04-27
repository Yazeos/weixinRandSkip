<?php
namespace app\admin\controller;
use app\common\logic\AdminLogic;
use app\common\logic\ModuleLogic;
use think\Page;
use think\Verify;
use think\Loader;
use think\Db;
use think\Session;
class Admin extends Base
{

    public function index()
    {
        $list = array();
    	$keywords = input('keywords/s');
    	if(empty($keywords)){ // 开发者测试账号,测试用
    		$res = Db::name('admin')->where('admin_id','not in','2,3')->select();
    	}else{
			$res = Db::name('admin')->where('user_name','like','%'.$keywords.'%')->where('admin_id','not in','2,3')->order('admin_id')->select();
    	}
    	$role = Db::name('admin_role')->column('role_id,role_name');
    	if($res && $role){
    		foreach ($res as $val){
    			$val['role'] =  $role[$val['role_id']];
    			$val['add_time'] = date('Y-m-d H:i:s',$val['add_time']);
    			$list[] = $val;
    		}
    	}
        if (empty($page))
            $this->assign('page','');
    	$this->assign('list',$list);
        return $this->fetch();
    }

    public function admin_info()
    {
        $admin_id = input('admin_id/d',0);$info=null;
        if($admin_id){
            $info = Db::name('admin')->where("admin_id", $admin_id)->find();
            $info['password'] =  "";
        }
        $this->assign('info',$info);
        $act = empty($admin_id) ? 'add' : 'edit';
        $this->assign('act',$act);
        $role = Db::name('admin_role')->select();
        $this->assign('role',$role);
        return $this->fetch();
    }

    public function adminHandle(){
        $data = input('post.');
        $adminValidate = Loader::validate('Admin');
        $data_act = $data['act'];unset($data['act']);
        if(!$adminValidate->scene($data_act)->batch()->check($data)){
            return json(['status'=>-1,'msg'=>'操作失败','result'=>$adminValidate->getError()]);
        }
        if(empty($data['password'])){
            unset($data['password']);
        }else{
            $data['password'] =encrypt($data['password']);
        }
        if($data_act == 'add'){
            unset($data['admin_id']);           
            $data['add_time'] = time();
            $r = Db::name('admin')->insertGetId($data);
        }
        
        if($data_act == 'edit'){
            $r = Db::name('admin')->where('admin_id', $data['admin_id'])->update($data);
        }
        if($data_act == 'del' && $data['admin_id']>1){
            $r = Db::name('admin')->where('admin_id', $data['admin_id'])->delete();
        }
        
        if($r){
            return json(['status'=>1,'msg'=>'操作成功','url'=>url('Admin/index')]);

        }else{
            return json(['status'=>-1,'msg'=>'操作失败']);
        }
    }

    public function role()
    {
        $list = Db::name('admin_role')->order('role_id desc')->select();
        $this->assign('list',$list);
        return $this->fetch();
    }

}