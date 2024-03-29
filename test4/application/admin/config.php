<?php
return [
    'template' => [
        // 模板引擎类型 支持 php think 支持扩展
        'type' => 'Think',
        // 模板路径
        'view_path' => './application/admin/view/',
        // 模板后缀
        'view_suffix' => 'html',
        // 模板文件名分隔符
        'view_depr' => DS,
        // 模板引擎普通标签开始标记
        'tpl_begin' => '{',
        // 模板引擎普通标签结束标记
        'tpl_end' => '}',
        // 标签库标签开始标记
        'taglib_begin' => '<',
        // 标签库标签结束标记
        'taglib_end' => '>',
    ],
    'view_replace_str' => [
        '__PUBLIC__' => '/public',
        '__ROOT__' => ''
        // '__STATIC__' => '/template/pc/default/Static',
    ],

    'session'                => [
        'prefix'         => 'powu',
        'type'           => '',
        'auto_start'     => true,
    ],

    // 密码加密串
    'AUTH_CODE' => "TPSHOP", //安装完毕之后不要改变，否则所有密码都会出错

    // URL伪静态后缀
    'url_html_suffix'        => '',   
    //默认错误跳转对应的模板文件
    'dispatch_error_tmpl' => 'public:dispatch_jump',
    //默认成功跳转对应的模板文件
    'dispatch_success_tmpl' => 'public:dispatch_jump',      
]
?>