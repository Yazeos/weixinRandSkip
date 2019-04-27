<?php
namespace app\admin\controller;
use think\Controller;
use think\Db;
use think\Session;
class Login extends Controller
{
    function index()
    {
        if(!empty(Session::get('admin'))){
            $this->redirect('Index/index');
        }
        if (input()) {//check
            if(!captcha_check(input('post.vertify'))) {
                return json(['status' => 0, 'msg' => '验证码错误']);// 校验失败
            }
            $result = $this->adminLogin(input('post.username'), input('post.password'));
            return json($result);
        }
        return $this->fetch();
    }

    public function adminLogin($username, $password)
    {
        if (empty($username) || empty($password)) {
            return ['status' => 0, 'msg' => '请填写账号密码'];
        }
        $find = Db::name('admin')->where('user_name', $username)->find();
        $login_arr = ['admin_id'=>$find['admin_id'], 'log_info'=>'后台登录', 'log_ip'=>request()->ip(), 'log_url'=>$_SERVER['REQUEST_URI'], 'log_time'=>time()];

        if(empty($find)|| $find['password']!=encrypt($password)){
            $login_arr['status'] = 2;
            $this->setAdminLog($login_arr);
            return ['status' => 0, 'msg' => '账号密码错误'];
        }

        $this->setAdminLog($login_arr);
        $this->loginSession($find);
        return ['status' => 1, 'url' => url('Index/index')];
    }

    public function setAdminLog($arr)
    {
        if (!is_array($arr)) {
            return false;
        }
        Db::name('admin_log')->insert($arr);
    }

    public function loginSession($admin, $actList='')
    {
        Db::name('admin')->where('admin_id', $admin['admin_id'])->update([
            'last_login' => time(),
            'last_ip' => request()->ip()
        ]);
        cookie("admin_username",$admin['user_name'],3600*24*30);
        Session::set('admin',$admin['user_name']);
        Session::set('adminUid',$admin['admin_id']);
        Session::set('role_id',$admin['role_id']);
        Session::set('email',$admin['email']);
    }

    public function logout()
    {
        Session::delete('admin'); 
        $this->redirect('Index/index');
    }
}