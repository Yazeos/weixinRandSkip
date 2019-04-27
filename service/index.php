<?php
phpinfo();

use Workerman\Worker;
use Workerman\Lib\Timer;
require_once './Workerman/Autoloader.php';
require_once './util/Curl.php';
require_once './util/Checkapi.php';
require_once './util/Email.php';

$checkapi = new Checkapi();
$email = new Email();
$mysqli = new mysqli('112.124.34.189','root','powu7788','weixinAdv');
$worker = new Worker('http://127.0.0.1:8585');
$worker->count = 1;
$tablename = [
    'jump_url',
    'own_url',
    'portal_url'
];
$tablenum = 0;
$selectnum = 0;
$worker->onWorkerStart=function($workers) use ($checkapi,$mysqli,$email,&$tablenum,&$selectnum,$tablename){
    if($workers->id === 0){
        Timer::add(4,function() use ($checkapi,$mysqli,$email,&$tablenum,&$selectnum,$tablename){
            $prefix = "pw_";
            $table = $prefix.$tablename[$tablenum];
            //取出网址每次一条
            $sql = "select id,url from ".$table." where status = 1 limit {$selectnum},1";
            $result=$mysqli->query($sql);
            if($result && $result->num_rows) {
                while($row = $result->fetch_assoc()){

                    //检测网址是否正常
                    if($checkapi->checkurl( $row['url'])){
                        $selectnum++ ;
                        echo $row['url'];
                        echo "网页正常";
                    }else{
                        $updateSql="update ".$table." set status = 2 where id=".$row['id'];
                        $update = $mysqli->query($updateSql);
                        echo $mysqli->affected_rows;
                        //发送消息到邮箱并更新日志;
                        if($update){
                            $emailsql="select admin.email as email,admin.admin_id as id
                                 from {$table} as url
                                 join {$prefix}admin as admin
                                 on admin.admin_id = url.adminid
                                 where url.id = {$row['id']} ";
                            $emailresult = $mysqli->query($emailsql);
                            $emails = $emailresult->fetch_assoc();
                            $postuser = $emails['email'];
                            $adminid = $emails['id'];

                            //发送邮箱
                            $title = " 跳转网址被封 ";
                            $content = "<p>尊敬的管理员:</p><p>&nbsp;&nbsp;&nbsp;&nbsp;您好，您的跳转域名：<span style='color:red'>{$row['url']}</span>已被微信检测违法，请替换跳转域名，以免影响您的正常使用</p>";
                            $email->sendMessage($title,$content,$postuser,$adminid);
                            $insertLog = "insert into pw_email_log(title,content,email,sendtime,adminid) values('".$title."','".htmlentities(htmlspecialchars(strip_tags($content)))."','".$postuser."','".time()."','".$adminid."')";
                            $result=$mysqli->query($insertLog);
                            if($result) echo '发送邮件成功';

                            echo "更新状态成功";
                        }

                        echo '网页被封';
                    }
                }
            }else{
                $tablenum++ ;
                $tablenum %= count($tablename);
                $selectnum = 0;
                echo '暂无数据<br>';
            }
//           $checkapi->checkurl();
        });
    }
};

Worker::runAll();