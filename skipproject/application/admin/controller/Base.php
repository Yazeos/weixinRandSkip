<?php
namespace app\admin\controller;
use think\Controller;
use think\Session;
use app\util\Wechat;
class Base extends Controller
{


    /**
     * 显示资源列表
     *
     * @return \think\Response
     */
    public function __construct()
    {
        parent::__construct();

        $this->init();
    }

    function _initialize()
    {
        $wechat=new Wechat();
        if($wechat->check(request())){
            if(request()->param('echostr')){
                echo request()->param('echostr');
//                exit;
            }
        }else{
//            exit;
        }

    	$this->checkLogin();
        $this->assign('menu', getMenuArr());
    }

    function checkLogin()
    {
        if(empty(Session::get('admin'))){
            $httpHeader = request()->domain();
            header('Location:'.$httpHeader.'/admin.php/Login/index');die;
        }
        $this->assign('username', Session::get('admin'));
        $this->assign('adminUid', Session::get('adminUid'));
        $this->assign('role_id', Session::get('role_id'));
        $this->adminId=Session::get('adminUid');
        $this->email=Session::get('email');
    }

    function ajaxReturn($data,$type = 'json'){                        
        exit(json_encode($data));
    }

    //首页
    public function init(){}
}