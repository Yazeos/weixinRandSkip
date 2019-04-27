<?php
return	array(
			
			'project'=>array(
				array('name' =>'项目列表', 'act'=>'plist', 'op'=>'Project'),
				// array('name'=>'入口地址','act'=>'ilist','op'=>'Project'),
				// array('name'=>'跳出网址','act'=>'jlist','op'=>'Project'),
			),
			'domain'=>array(
				array('name' =>'域名列表', 'act'=>'dlist', 'op'=>'Domain'),
				// array('name'=>'接入域名','act'=>'add','op'=>'Domain'),
				array('name'=>'域名检测','act'=>'check','op'=>'Domain'),
			),
			'adminMenber'=>array(
				array('name' => '管理员列表', 'act'=>'index', 'op'=>'Admin'),
			),
		);