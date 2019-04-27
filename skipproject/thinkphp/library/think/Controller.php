<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

namespace think;

use think\exception\ValidateException;
use traits\controller\Jump;

Loader::import('controller/Jump', TRAIT_PATH, EXT);

class Controller
{
    use Jump;

    /**
     * @var \think\View 视图类实例
     */
    protected $view;

    /**
     * @var \think\Request Request 实例
     */
    protected $request;

    /**
     * @var bool 验证失败是否抛出异常
     */
    protected $failException = false;

    /**
     * @var bool 是否批量验证
     */
    protected $batchValidate = false;

    /**
     * @var array 前置操作方法列表
     */
    protected $beforeActionList = [];

    /**
     * 构造方法
     * @access public
     * @param Request $request Request 对象
     */
    
    // public function __construct(Request $request = null)
    // {
    //     $this->view    = View::instance(Config::get('template'), Config::get('view_replace_str'));
    //     $this->request = is_null($request) ? Request::instance() : $request;

    //     define('ACTION_NAME',$this->request->action()); // 当前操作名称是
    //     ($this->request->method() == 'POST') ? define('IS_POST',true) : define('IS_POST',false);
    //     ($this->request->method() == 'GET') ? define('IS_GET',true) : define('IS_GET',false);
    //     $this->request->isAjax() ? define('IS_AJAX',true) : define('IS_AJAX',false);  //

    //     // 控制器初始化
    //     $this->_initialize();

    //     // 前置操作方法
    //     if ($this->beforeActionList) {
    //         foreach ($this->beforeActionList as $method => $options) {
    //             is_numeric($method) ?
    //             $this->beforeAction($options) :
    //             $this->beforeAction($method, $options);
    //         }
    //     }
    // }

        public function __construct(Request $request = null)
        {
            $this->view = View::instance(Config::get('template'), Config::get('view_replace_str'));
            $this->request = is_null($request) ? Request::instance() : $request;

            $this->request->isAjax() ? define('IS_AJAX',true) : define('IS_AJAX',false);  //
            ($this->request->method() == 'GET') ? define('IS_GET',true) : define('IS_GET',false);  // 
            ($this->request->method() == 'POST') ? define('IS_POST',true) : define('IS_POST',false);  // 
            
            define('MODULE_NAME',$this->request->module());  // 当前模块名称是
            define('CONTROLLER_NAME',$this->request->controller()); // 当前控制器名称
            define('ACTION_NAME',$this->request->action()); // 当前操作名称是
            define('PREFIX',C('database.prefix')); // 数据库表前缀               
            $this->assign('action',ACTION_NAME);
            $this->assign('template_now_time', time());//模板现在时间
            if(isMobile() && strtolower(MODULE_NAME) == 'home'  && strtolower(CONTROLLER_NAME) == 'index' && strtolower(ACTION_NAME) == 'index')
            {
                //define("BIND_MODULE",'mobile'); 
                //$this->redirect('Mobile/Index/index');
                header("Location: ".url('Mobile/Index/index'));
                //header("Location: ".U('B/Index/index'));
                exit();
             }
            //read_html_cache(); // 尝试从缓存中读取      
            // 控制器初始化
            $this->_initialize();

            // 前置操作方法
            if ($this->beforeActionList) {
                foreach ($this->beforeActionList as $method => $options) {
                    is_numeric($method) ?
                    $this->beforeAction($options) :
                    $this->beforeAction($method, $options);
                }
            }
        }

    /**
     * 初始化操作
     * @access protected
     */
    protected function _initialize()
    {
    }

    /**
     * 前置操作
     * @access protected
     * @param  string $method  前置操作方法名
     * @param  array  $options 调用参数 ['only'=>[...]] 或者 ['except'=>[...]]
     * @return void
     */
    protected function beforeAction($method, $options = [])
    {
        if (isset($options['only'])) {
            if (is_string($options['only'])) {
                $options['only'] = explode(',', $options['only']);
            }

            if (!in_array($this->request->action(), $options['only'])) {
                return;
            }
        } elseif (isset($options['except'])) {
            if (is_string($options['except'])) {
                $options['except'] = explode(',', $options['except']);
            }

            if (in_array($this->request->action(), $options['except'])) {
                return;
            }
        }

        call_user_func([$this, $method]);
    }

    /**
     * 加载模板输出
     * @access protected
     * @param  string $template 模板文件名
     * @param  array  $vars     模板输出变量
     * @param  array  $replace  模板替换
     * @param  array  $config   模板参数
     * @return mixed
     */
    protected function fetch($template = '', $vars = [], $replace = [], $config = [])
    {
        return $this->view->fetch($template, $vars, $replace, $config);
    }

    /**
     * 渲染内容输出
     * @access protected
     * @param  string $content 模板内容
     * @param  array  $vars    模板输出变量
     * @param  array  $replace 替换内容
     * @param  array  $config  模板参数
     * @return mixed
     */
    protected function display($content = '', $vars = [], $replace = [], $config = [])
    {
        return $this->view->display($content, $vars, $replace, $config);
    }

    /**
     * 模板变量赋值
     * @access protected
     * @param  mixed $name  要显示的模板变量
     * @param  mixed $value 变量的值
     * @return $this
     */
    protected function assign($name, $value = '')
    {
        $this->view->assign($name, $value);

        return $this;
    }

    /**
     * 初始化模板引擎
     * @access protected
     * @param array|string $engine 引擎参数
     * @return $this
     */
    protected function engine($engine)
    {
        $this->view->engine($engine);

        return $this;
    }

    /**
     * 设置验证失败后是否抛出异常
     * @access protected
     * @param bool $fail 是否抛出异常
     * @return $this
     */
    protected function validateFailException($fail = true)
    {
        $this->failException = $fail;

        return $this;
    }

    /**
     * 验证数据
     * @access protected
     * @param  array        $data     数据
     * @param  string|array $validate 验证器名或者验证规则数组
     * @param  array        $message  提示信息
     * @param  bool         $batch    是否批量验证
     * @param  mixed        $callback 回调方法（闭包）
     * @return array|string|true
     * @throws ValidateException
     */
    protected function validate($data, $validate, $message = [], $batch = false, $callback = null)
    {
        if (is_array($validate)) {
            $v = Loader::validate();
            $v->rule($validate);
        } else {
            // 支持场景
            if (strpos($validate, '.')) {
                list($validate, $scene) = explode('.', $validate);
            }

            $v = Loader::validate($validate);

            !empty($scene) && $v->scene($scene);
        }

        // 批量验证
        if ($batch || $this->batchValidate) {
            $v->batch(true);
        }

        // 设置错误信息
        if (is_array($message)) {
            $v->message($message);
        }

        // 使用回调验证
        if ($callback && is_callable($callback)) {
            call_user_func_array($callback, [$v, &$data]);
        }

        if (!$v->check($data)) {
            if ($this->failException) {
                throw new ValidateException($v->getError());
            }

            return $v->getError();
        }

        return true;
    }
}
