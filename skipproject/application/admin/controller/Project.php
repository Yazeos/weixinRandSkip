<?php
namespace app\admin\controller;
use think\AjaxPage;
use think\Page;
use think\Db,think\Log;
use think\Loader;
use think\Request;
use app\service\FileService;
use app\service\CheckapiService;
use app\model\Provincial;
use app\model\Restrict;
use think\Exception;

class Project extends Base
{
    private $fileService;
    private $checkapiService;

    //初始化函数
    public function init()
    {
        $this->fileService=new FileService();
        $this->checkapiService=new CheckapiService();
    }

    public function plist(){
        return $this->fetch();
    }
    
    public function index_ajax(){
        $count = Db::name('project')->where(array('adminid'=>$this->adminId))->count();
        $Page  = new AjaxPage($count,10);
        $advertisement=Db::name('project')->where(array('adminid'=>$this->adminId))->limit($Page->firstRow.','.$Page->listRows)->select();
        $defaulturl=Db::name('jump_url')->where(array('isdefault'=>1,'adminid'=>$this->adminId))->column('pid,url');
        $show = $Page->show();
        $this->assign('advertisement',$advertisement);
        $this->assign('defaulturl',$defaulturl);
        $this->assign('page',$show);
        $this->assign('pager',$Page);
        return $this->fetch();
    }

    //项目详情
    public function detail(){
        $id=input("id/d");
        $urlList=Db::name('own_url')->where(array('status'=>1,'adminid'=>$this->adminId))->select();
        $project=Db::name('project')->where(array('id'=>$id,'adminid'=>$this->adminId))->find();
        $province=Provincial::select();
        $this->assign('id',$id);
        $this->assign('urlList',$urlList);
        $this->assign('project',$project);
        $this->assign('province',$province);
        return $this->fetch();
    }
    //添加项目
    public function add_project(){
        if (IS_POST) {
            $data = input('post.');
            $project= Db::name('project')->where(array('title'=>trim($data['title']),'adminid'=>$this->adminId))->find();
            if($project){
                echo -1;exit();
            }else{
                //添加
                $data['createtime']=time();
                $data['title']=trim($data['title']);
                $data['adminid']=$this->adminId;
                $res=Db::name('project')->insert($data);
                if($res){
                    echo 1;exit();//成功;
                }else{
                    echo 0;exit();//sql执行失败
                }; 
            }
        }
        return $this->fetch();
    }

    //修改项目跳转类型
    public function edit_project(){
        if (IS_POST) {
            $data = input('post.');
            $project= Db::name('project')->where(array('title'=>trim($data['title']),'adminid'=>$this->adminId))->find();
            if($project&&$project['id']!=$data['id']){
                echo -1;exit();
            }
            else{
                $res=Db::name('project')->where(array('id'=>$data['id']))->update(array('title'=>trim($data['title']),'jumptype'=>$data['jumptype']));
                if($res){
//                    $info=\app\model\Project::where('id',2)->with([
//                        'portalurl' => function($portalurl){
//                            $portalurl->field('pid,localpath');
//                        }
//                    ])->field('id')->select()[0];

//                    $urls=$info['portalurl'];

//                    foreach($urls as $v){
//                        if($v['localpath']) {
//                            $this->fileService->uploadFile($data['id'], $v['localpath']);
//                        }
//                    }
//                    return json($urls);

                    echo 1;exit();//成功;
                }else{
                    echo 0;exit();//sql执行失败
                };
            }

        }
        $id=input('id/d');
        $project=Db::name('project')->where(array('id'=>$id))->find();
        $this->assign("project",$project);
        return $this->fetch();
    }

    //删除项目名称
    public function del(){
        $id = input('post.id/d');
        if($id>0){
            $row = Db::name('project')->where(array('id'=>$id,'adminid'=>$this->adminId))->delete();
            //同时要删除该项目下的所有相关网址
            $portal = Db::name('portal_url')->where(array('pid'=>$id,'adminid'=>$this->adminId))->delete();
            $jump  = Db::name('jump_url')->where(array('pid'=>$id,'adminid'=>$this->adminId))->delete();
            if($row){
                $this->ajaxReturn(array('status'=>1));
            }else{
                $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));

            }
        }else{
            $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
        }
    }

    //入口网址列表
    public function index_ajax2(){
       $id=input('id/d');
       $count = Db::name('portal_url')->where(array('pid'=>$id,'adminid'=>$this->adminId))->count();
       $Page  = new AjaxPage($count,10);
       $portalUrl=Db::name('portal_url')->where(array('pid'=>$id,'adminid'=>$this->adminId))->limit($Page->firstRow.','.$Page->listRows)->select();
       $project=Db::name('project')->where(array('adminid'=>$this->adminId))->column('id,title');
       $show = $Page->show();
       $this->assign('portalUrl',$portalUrl);
       $this->assign('project',$project);
       $this->assign('page',$show);
       $this->assign('pager',$Page);
       return $this->fetch();
    }

    //添加入口地址
    public function add_portal(Request $request){
        // if(input('id')>0){
        //     //进入修改态
        //     $id=input('id/d');
        //     $portal=Db::name('portal_url')->where(array('id'=>$id,'adminid'=>$this->adminId))->find();
        //     $this->assign('portal',$portal);
        // }

        if (IS_POST) {

            //生成随机串
            //添加到数据库
            $saveUrl = $request->param('url');
            $projectid = $request->param('pid');
            $mark = $request->param('mark');

            //生成的文件目录名
            $num=6;

//            $path='/j';
            //是否随机字符串
//            $random_type=$this->fileService->getRandomType($projectid);
            //从数据库读取域名对应场景的域名集 --------  urls
//        $urls=["http://www.zk10.cn", "http://www.baidu.com", "http://www.pdlgcable.com"];

//            $urls=$this->fileService->getJumpUrls($random_type,$projectid);
            //替换字符串
//            $pattern=[
//                '/\{\{\$random\}\}/iU'
//            ];
//            $replace=[
//                $this->fileService->sikpsort($random_type, $urls),
//            ];
//            //静态文件路径
//            $filepath=$this->fileService->staticFile($pattern, $replace, $num, $path);
            //更新数据库update  bangdinyuming
            $filename=$this->fileService->randomStr($num);
            $domain=$saveUrl.'/admin/a/j/'.$filename;

            $data=[
                'status' => $this->checkapiService->checkurl($domain) == 1 ?1 :2 ,
                'pid' => $projectid,
                'url' => $domain,
                'localpath' => $filename,
                'createtime' => time(),
                'mark' => $mark,
                'adminid'=>$this->adminId
            ];
            if($this->fileService->addJumpUrl($data)) {
                $this->ajaxReturn(array('msg' => '添加成功'));
            }

            //返回路径名称
//            echo $domain;




//            $data = input('post.');
//             if($data['id']>0){
//                $res=Db::name('portal_url')->update($data);
//                if($res){
//                    $this->ajaxReturn(array('msg'=>'更新成功'));
//                }else{
//                    $this->ajaxReturn(array('msg'=>'服务器繁忙1'));
//                }
//            }else{
//                //再次判断网址是否被封
//                $url=Db::name('own_url')->where(array('url'=>$data['url']))->find();
//                if($url['status']==2){
//                    $this->ajaxReturn(array('msg'=>'该域名已被封，无法使用'));
//                }
//                else{
//                    //生成随机网址
//                    $data['url']=create_random_string($data['url']);
//                    $data['createtime']=time();
//                    //此处绑定站点，流光添加
//                    //绑定站点
//                    $res=Db::name('portal_url')->insert($data);
//                    if($res){
//                        $this->ajaxReturn(array('msg'=>'添加成功'));
//                    }else{
//                        $this->ajaxReturn(array('msg'=>'服务器繁忙'));
//                    }
//                }
//            }
        }
        //取出项目名称
        $project=Db::name('project')->where(array('adminid'=>$this->adminId))->field('id,title')->select();
        //域名选择,只取出正常态的，入口网址由这个生成
        $urlList=Db::name('own_url')->where(array('status'=>1,'adminid'=>$this->adminId))->column('id,url');
        $this->assign('project',$project);
        $this->assign('urlList',$urlList);
        return $this->fetch();
    }

    //修改入口网址启用状态
    public function editstatus(){
        $id=input("post.id");
        //echo $id;exit();
        $row = Db::name('portal_url')->where(array('id'=>$id))->find();
        if($row['isuse']==1){
            $data['isuse']=2;
        }else{
            $data['isuse']=1;
        }
        $res=Db::name('portal_url')->where(array('id'=>$id))->update($data);
        if($res){
            $this->ajaxReturn(array('status'=>1,'isuse'=>$data['isuse']));
        }else{
            $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
        }
    }

    //删除入口网址
    public function del_portal_url(){
        $id = input('post.id/d');
        if($id>0){
            $row = Db::name('portal_url')->where(array('id'=>$id,'adminid'=>$this->adminId))->delete();
            if($row){
                $this->ajaxReturn(array('status'=>1));
            }else{
                $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));

            }
        }else{
            $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
        }
       
    }

    //跳出网址列表
    public function index_ajax3(){
        $id=input('id/d');
        $count = Db::name('jump_url')->where(array('pid'=>$id,'adminid'=>$this->adminId))->count();
        $Page  = new AjaxPage($count,10);
        $jumpUrl=Db::name('jump_url')->where(array('pid'=>$id,'adminid'=>$this->adminId))->limit($Page->firstRow.','.$Page->listRows)->select();
        $project=Db::name('project')->where(array('adminid'=>$this->adminId))->column('id,title');
        $show = $Page->show();
        $this->assign('jumpUrl',$jumpUrl);
        $this->assign('project',$project);
        $this->assign('page',$show);
        $this->assign('pager',$Page);
        return $this->fetch();
    }

    //ip限制列表
    public function index_ajax4(){
        $id=input('id/d');
        $count = Restrict::where('pid',$id)->field('id')->count();
        $Page  = new AjaxPage($count,10);
        $restrict=Db::name('restrict')->where(array('pid'=>$id))->limit($Page->firstRow.','.$Page->listRows)->select();
//        $project=Db::name('project')->column('id,title');
        $show = $Page->show();
        $this->assign('restrict',$restrict);
//        $this->assign('project',$project);
        $this->assign('page',$show);
        $this->assign('pager',$Page);
        return $this->fetch();
    }

    //添加跳出网址
    public function add_jump(){
        if (IS_POST) {
            $data = input('post.');
            //判断是否已存在
            $url=Db::name('jump_url')->where(array('url'=>trim($data['url']),'pid'=>$data['pid']))->find();
            if($url){
                $this->ajaxReturn(array('msg'=>'域名已存在'));
            }
            else{
                $data['status'] = $this->checkapiService->checkurl(trim($data['url']))==1 ?1 :2 ;
                $data['createtime'] = time();
                $data['url'] = trim($data['url']);
                $data['adminid'] = $this->adminId;
                $res=Db::name('jump_url')->insert($data);
                if($res){
                    $this->ajaxReturn(array('msg'=>'添加成功'));
                }else{
                    $this->ajaxReturn(array('msg'=>'服务器繁忙'));
                }
            }   
           
        }
        //取出项目名称
        $project=Db::name('project')->where(array('adminid'=>$this->adminId))->field('id,title')->select();
        $this->assign('project',$project);
        return $this->fetch();
    }

    //添加地区ip限制
    public function add_iprestrict(Request $request)
    {
        $param=$request->param();

        $data=[
            'province_name' => $param['province_name'],
            'city_name' => $param['city'],
            'pid' => $param['pid']
        ];

        try {
            if (Restrict::insert($data)) {
                $this->ajaxReturn(array('msg' => '添加成功'));
            } else {
                $this->ajaxReturn(array('msg' => '服务器繁忙'));
            }
        }catch(\Exception $e){
            $this->ajaxReturn(array('msg' => '字段已存在'));
        }

    }

    //删除ip地区限制
    public function del_restrict()
    {
        $id = input('post.id/d');
        if($id>0){
            $row = Db::name('restrict')->where(array('id'=>$id))->delete();
            if($row){
                $this->ajaxReturn(array('status'=>1));
            }else{
                $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
            }
        }else{
            $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
        }
    }

    //单测
    public function test(){
//        echo '123432';
        $info=\app\model\Project::where('id',3)->with([
            'portalurl' => function($portalurl){
                $portalurl->field('pid,localpath');
            }
        ])->field('id')->select()[0];

        $urls=$info['portalurl'];

        foreach($urls as $v){
            echo $v['localpath'];
//
        }

                return json($urls[0]);

//        $server_name='www.powu.com/tk7i28.html';
//        $data = \app\model\PortalUrl::where('url',$server_name)->with([
//            'project' => function($project){
//                $project->field('*')->with('restrict');
//            }
//        ])->select()[0]['project'][0]['restrict'];
//
//        $city='湖州';
//
//        foreach($data as $v){
//            if(strstr($v['city_name'],$city)){
//                exit('ip被限制');
//            }
//        }
    }

    //获取城市
    public function getCity(Request $request)
    {
        $provinceId=$request->param('pid');
        $data=Provincial::where('pid',$provinceId)->with('city')->select()[0]['city'];
        return json($data);
    }

    //删除入口网址
    public function del_jump_url(){
        $id = input('post.id/d');
        if($id>0){
            $row = Db::name('jump_url')->where(array('id'=>$id,'adminid'=>$this->adminId))->delete();
            if($row){
                $this->ajaxReturn(array('status'=>1));
            }else{
                $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
            }
        }else{
            $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
        }
    }

    //修改跳转网址启用状态
    public function edit_jump_isuse(){
        $id=input("post.id");
        $row = Db::name('jump_url')->where(array('id'=>$id))->find();
        if($row['isuse']==1){
            $data['isuse']=2;
        }else{
            $data['isuse']=1;
        }
        $res=Db::name('jump_url')->where(array('id'=>$id))->update($data);
        if($res){
            $this->ajaxReturn(array('status'=>1,'isuse'=>$data['isuse']));
        }else{
            $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
        }
    }

    //修改跳转网址默认状态
    public function edit_jump_isdefault(){
        $id=input("post.id");
        $row = Db::name('jump_url')->where(array('id'=>$id))->find();
        //同一项目下只能设置一个默认的
        $count = Db::name('jump_url')->where(array('pid'=>$row['pid'],'isdefault'=>1))->where('id','<>',$id)->count();
        if($count>0){
            $this->ajaxReturn(array('status'=>-1,'msg'=>'同一项目只能设置一个默认'));
        }
        if($row['isdefault']==1){
            $data['isdefault']=2;
        }else{
            $data['isdefault']=1;
        }
        $res=Db::name('jump_url')->where(array('id'=>$id))->update($data);
        if($res){
            $this->ajaxReturn(array('status'=>1,'isdefault'=>$data['isdefault']));
        }else{
            $this->ajaxReturn(array('status'=>-1,'msg'=>'服务器繁忙'));
        }
    }

  
}