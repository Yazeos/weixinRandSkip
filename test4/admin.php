﻿<?php
// 定义应用目录
define('APP_PATH', __DIR__ . '/application/');
# 绑定后台模块
define("BIND_MODULE",'admin'); 
// 定义应用缓存目录
define('RUNTIME_PATH', __DIR__ . '/runtime/');
// 开启调试模式
define('APP_DEBUG', true);
// 加载框架引导文件
require __DIR__ . '/thinkphp/start.php';

