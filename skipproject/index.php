<?php

// 定义应用目录

define('APP_PATH', __DIR__ . '/application/');

//define("BIND_MODULE",'home'); 
$http = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] && $_SERVER['HTTPS'] != 'off') ? 'https' : 'http';
// 定义应用缓存目录
define('SITE_URL',$http.'://'.$_SERVER['HTTP_HOST']); // 网站域名

//define("BIND_MODULE",'admin');

define('RUNTIME_PATH', __DIR__ . '/runtime/');



// 开启调试模式



define('APP_DEBUG', true);

// 加载框架引导文件

require __DIR__ . '/thinkphp/start.php';

