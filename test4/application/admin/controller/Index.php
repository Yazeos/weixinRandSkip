<?php
namespace app\admin\controller;
use think\Request;
use think\Log;
use think\Controller;
use app\service\WechatService;

class Index extends Controller
{
	private $access_token;
	private $wechatService;

	public function _initialize() 
	{
		$this->wechatService=new WechatService();
		$this->access_token=$this->wechatService->getAccessToken();
    }

	public function index(){

	}

	/**
	 * 接收urls里数据
	 * @return \think\response\Json
	 */
    public function handcheck()
    {
//		if(Request::isPost()) {
			$info=json_decode(request()->param()['data'],true);
			$urls = $info['urls'];
			$status=isset($info['status'])?:false;
			Log::write(json_decode(request()->param()['data'],true)['urls']);
//			$urls = ['op1955.com', 'www.baidu.com', 'www.xinlang.com','www.google.com'];
			if($urls) {
				$checkurls = $this->wechatService->handcheck($urls, $this->access_token,$status);
				Log::write($checkurls);
				return json($checkurls);
			}
//		}
    }

	//自动测试，返回值
	public function autocheck()
	{

	}

}