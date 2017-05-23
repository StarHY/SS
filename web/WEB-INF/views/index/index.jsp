<%--
  Created by IntelliJ IDEA.
  User: iJangoGuo
  Date: 2017/5/15
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="author" content=""/>
    <!-- Facebook and Twitter integration -->
    <meta property="og:title" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:url" content=""/>
    <meta property="og:site_name" content=""/>
    <meta property="og:description" content=""/>
    <meta name="twitter:title" content=""/>
    <meta name="twitter:image" content=""/>
    <meta name="twitter:url" content=""/>
    <meta name="twitter:card" content=""/>

    <link rel="shortcut icon" href="<%=path %>/img/favicon.ico">

    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,700" rel="stylesheet">

    <!-- Animate.css -->
    <link rel="stylesheet" href="<%=path%>/css/animate.css">
    <!-- Icomoon Icon Fonts-->
    <link rel="stylesheet" href="<%=path%>/css/icomoon.css">
    <!-- Themify Icons-->
    <link rel="stylesheet" href="<%=path%>/css/themify-icons.css">
    <!-- Bootstrap  -->
    <link rel="stylesheet" href="<%=path%>/css/bootstrap.min.css">

    <!-- Magnific Popup -->
    <link rel="stylesheet" href="<%=path%>/css/magnific-popup.css">

    <!-- Owl Carousel  -->
    <link rel="stylesheet" href="<%=path%>/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=path%>/css/owl.theme.default.min.css">
    <link href="<%=path %>/css/sweet-alert.css" rel="stylesheet" type="text/css">

    <!-- Theme style  -->
    <link rel="stylesheet" href="<%=path%>/css/style.css">

    <!-- Modernizr JS -->
    <script src="<%=path%>/js/modernizr-2.6.2.min.js"></script>
    <!-- FOR IE9 below -->
    <!--[if lt IE 9]>
    <script src="<%=path%>/js/respond.min.js"></script>
    <![endif]-->

</head>
<body>

<div class="gtco-loader"></div>

<div id="page">


    <div class="page-inner">
        <nav class="gtco-nav" role="navigation">
            <div class="gtco-container">

                <div class="row">
                    <div class="col-sm-4 col-xs-12">
                        <div id="gtco-logo"><a href="<%=path%>/index">首页 <em>.</em></a></div>
                    </div>
                    <div class="col-xs-8 text-right menu-1">
                        <ul>
                            <li><a href="<%=path%>/customerClientWeb/tour">功能简介</a></li>
                            <li><a href="<%=path%>/customerClientWeb/features">平台特性</a></li>
                            <li><a href="<%=path%>/customerClientWeb/pricing">产品收费</a></li>
                            <li><a href="<%=path%>/customerClientWeb/customerCar">进度跟踪</a></li>
                            <%--<li class="has-dropdown">
                                <a href="#">使用说明</a>
                                <ul class="dropdown">
                                    <li><a href="<%=path%>/customerClientWeb/customerCar">进度跟踪</a></li>
                                    <li><a href="#">帮助文档</a></li>
                                    <li><a href="#">API</a></li>
                                </ul>
                            </li>--%>
                            <li class="btn-cta"><a href="<%=path%>/customerClientWeb/contact"><span>入驻 我们</span></a>
                            </li>
                        </ul>
                    </div>
                </div>

            </div>
        </nav>

        <header id="gtco-header" class="gtco-cover" role="banner"
                style="background-image: url(<%=path%>/images/img_4.jpg)">
            <div class="overlay"></div>
            <div class="gtco-container">
                <div class="row">
                    <div class="col-md-12 col-md-offset-0 text-left">


                        <div class="row row-mt-15em">
                            <div class="col-md-7 mt-text animate-box" data-animate-effect="fadeInUp">
                                <span class="intro-text-small">欢迎登陆 汽车维保平台</span>
                                <h1>更快捷 更方便 更便利 小拇指 为您服务.</h1>
                            </div>
                            <div class="col-md-4 col-md-push-1 animate-box" data-animate-effect="fadeInRight">
                                <div class="form-wrap">
                                    <div class="tab">
                                        <ul class="tab-menu">
                                            <li class="active gtco-first"><a href="#" data-tab="signup">注册</a></li>
                                            <li class="gtco-second"><a href="#" data-tab="login">登陆</a></li>
                                        </ul>
                                        <div class="tab-content">
                                            <div id="errMsg1" style="color: red"></div>
                                            <div id="successMsg" style="color: green"></div>
                                            <div class="tab-content-inner active" data-content="signup">
                                                <form role="form" id="register_form" method="post">
                                                    <div class="row form-group">
                                                        <div class="col-md-12">
                                                            <label for="username">用户名</label>
                                                            <input type="text" name="number" class="form-control"
                                                                   placeholder="请输入手机号或邮箱完成注册" id="username"
                                                                   onblur="variNumber(this.value)">
                                                        </div>
                                                    </div>
                                                    <div class="row form-group" id="codeDiv" style="display: none;">
                                                        <div class="col-md-12" style="padding: 0px;">
                                                            <div class="col-sm-12" style="margin: 0px;">

                                                                <label for="code">验证码</label>
                                                            </div>
                                                            <div class="col-sm-7" style="margin: 0px;">
                                                                <input type="text" id="code" name="code"
                                                                       class="form-control" placeholder="输入手机验证码"
                                                                       onblur="clearSuccess(this)">
                                                            </div>
                                                            <div class="col-sm-5" style="margin: 0px;">
                                                                <input type="button" id="detailButton"
                                                                       onclick="getCode(this)" class="btn btn-primary"
                                                                       value="获取验证码"
                                                                       style="padding-left: 10px; padding-right: 10px;">
                                                            </div>


                                                        </div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col-md-12">
                                                            <label for="password">密码</label>
                                                            <input type="password" name="pwd" class="form-control"
                                                                   placeholder="请输入密码" id="password">
                                                        </div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col-md-12">
                                                            <label for="password2">密码确认</label>
                                                            <input type="password" name="password" class="form-control"
                                                                   placeholder="请再次输入密码" id="password2">
                                                        </div>
                                                    </div>

                                                    <div class="row form-group">
                                                        <div class="col-md-12">
                                                            <input type="button" onclick="register()"
                                                                   class="btn btn-primary" value="注册">
                                                            <input type="reset" class="btn btn-primary" value="重置"/>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>

                                            <div class="tab-content-inner" data-content="login">
                                                <div id="errMsg" style="color: red"></div>
                                                <form id="login_form" method="post">
                                                    <div class="row form-group">
                                                        <div class="col-md-12">
                                                            <label for="username">用户名</label>
                                                            <input type="text" name="number" class="form-control"
                                                                   placeholder="请输入手机号或邮箱" id="username1">
                                                        </div>
                                                    </div>
                                                    <div class="row form-group">
                                                        <div class="col-md-12">
                                                            <label for="password">密码</label>
                                                            <input type="password" name="pwd" class="form-control"
                                                                   placeholder="请输入密码" id="password1">
                                                        </div>
                                                    </div>

                                                    <div class="row form-group">
                                                        <div class="col-md-12">
                                                            <input type="button" onclick="login()"
                                                                   class="btn btn-primary" value="登陆"/>
                                                            <input type="reset" class="btn btn-primary" value="重置"/>
                                                        </div>
                                                    </div>
                                                </form>
                                                <div>
                                                    <dutton onclick="showPwdWin()" style="cursor: pointer;">忘记密码</dutton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </header>

        <div class="gtco-section border-bottom">
            <div class="gtco-container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2 text-center gtco-heading">
                        <h2>入驻商家&nbsp;案例</h2>
                        <p>入驻平台使得车主维保更加方便快捷</p>
                    </div>
                </div>
                <%@ include file="../common/companyImages.jsp" %>
            </div>
        </div>

        <div id="gtco-features" class="border-bottom">
            <div class="gtco-container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2 text-center gtco-heading animate-box">
                        <h2>这是一场新的汽修革命</h2>
                        <p>顾客能够从预约到汽车维保，从状态查询到结算提车</p>
                        <p>每一个环节都能够时刻关注爱车的维保情况</p>
                        <p>商家能够顾客信息到维保项目添加,从派工领料到财务统计</p>
                        <p>并且每一个流程清晰准确无误。</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <div class="feature-center animate-box" data-animate-effect="fadeIn">
						<span class="icon">
							<i class="ti-vector"></i>
						</span>
                            <h3>流程控制</h3>
                            <p>完美的维保汽修流程，每个角色具有相对应功能权限，每个功能互不干扰，并且入驻商家具有动态的角色权限管理。</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="feature-center animate-box" data-animate-effect="fadeIn">
						<span class="icon">
							<i class="ti-tablet"></i>
						</span>
                            <h3>操作性能</h3>
                            <p>汽修维保平台适用于一切PC端，完美的客户体验让车主和入驻商家随时随地都能够查询到想要的信息。 </p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="feature-center animate-box" data-animate-effect="fadeIn">
						<span class="icon">
							<i class="ti-settings"></i>
						</span>
                            <h3>数据动态</h3>
                            <p>入驻商家能够动态更新所有数据，从汽车维保项目添加到客户结算提车，一切都能够让商家有更好的体验。</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="feature-center animate-box" data-animate-effect="fadeIn">
						<span class="icon">
							<i class="ti-email"></i>
						</span>
                            <h3>维修提醒</h3>
                            <p>车主在维修完后平台都能够在下次维修保养时间定时发送短信提醒保养，让车主不错过任何一次保养爱车</p>
                        </div>
                    </div>

                    <div class="col-md-3 col-sm-6">
                        <div class="feature-center animate-box" data-animate-effect="fadeIn">
						<span class="icon">
							<i class="ti-cloud-down"></i>
						</span>
                            <h3>安全云数据</h3>
                            <p>所有的信息都安全的存储在云数据中心，不用再担心任何数据丢失问题，让车主，商家更快捷更放心</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="feature-center animate-box" data-animate-effect="fadeIn">
						<span class="icon">
							<i class="ti-shopping-cart"></i>
						</span>
                            <h3>轻松结算</h3>
                            <p>车主能够通过手机端轻松查看爱车的维保进度，账单明细，消费统计全都一目了然并且在页面一键轻松结算</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="feature-center animate-box" data-animate-effect="fadeIn">
						<span class="icon">
							<i class="ti-stats-up"></i>
						</span>
                            <h3>报表统计</h3>
                            <p>平台提供人性化的报表统计，让商家精准了解一切数据报表，顾客也能够查看自己的消费统计 </p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="feature-center animate-box" data-animate-effect="fadeIn">
						<span class="icon">
							<i class="ti-printer"></i>
						</span>
                            <h3>导入导出</h3>
                            <p>入驻的商家能够准确的导出所有员工工资、车主的账单详情、报表统计并且打印存档 </p>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div id="gtco-counter" class="gtco-section">
            <div class="gtco-container">

                <div class="row">
                    <div class="col-md-8 col-md-offset-2 text-center gtco-heading animate-box">
                        <h2>关于 平台</h2>
                        <p>平台提供手机端和PC端的内容显示，让车主随时随地查看自己爱车维修保养情况，更准确的把握汽车维保时间.入驻商家完全脱离纸质化办公，便捷管理维保的一切流程与统计.</p>
                    </div>
                </div>

                <div class="row">

                    <div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInLeft">
                        <div class="feature-center">
						<span class="icon">
							<i class="ti-user"></i>
						</span>
                            <span class="counter js-counter" data-from="0" data-to="4938" data-speed="5000"
                                  data-refresh-interval="50">1</span>
                            <span class="counter-label">拥有用户</span>

                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInLeft">
                        <div class="feature-center">
						<span class="icon">
							<i class="ti-comments-smiley"></i>
						</span>
                            <span class="counter js-counter" data-from="0" data-to="1029" data-speed="5000"
                                  data-refresh-interval="50">1</span>
                            <span class="counter-label">获得好评</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInLeft">
                        <div class="feature-center">
						<span class="icon">
							<i class="ti-credit-card"></i>
						</span>
                            <span class="counter js-counter" data-from="0" data-to="10293" data-speed="5000"
                                  data-refresh-interval="50">1</span>
                            <span class="counter-label">完成支付</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInLeft">
                        <div class="feature-center">
						<span class="icon">
							<i class="ti-time"></i>
						</span>
                            <span class="counter js-counter" data-from="0" data-to="212023" data-speed="5000"
                                  data-refresh-interval="50">1</span>
                            <span class="counter-label">使用时间</span>

                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div id="gtco-products">
            <div class="gtco-container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2 text-center gtco-heading">
                        <h2>更多 内容</h2>
                        <p>平台不断更新设计，为入驻用户免费提供更新.</p>
                    </div>
                </div>
                <%@ include file="../common/company_img.jsp" %>
            </div>
        </div>

        <%@ include file="../common/subscribeMe.jsp" %>
        <%@ include file="../common/footer.jsp" %>
    </div>

</div>

<div class="gototop js-top">
    <a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
</div>
<%--
找回密码窗口
--%>
<div id="editPwd" class="modal fade" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-sm-12 b-r">
                        <span class="glyphicon glyphicon-remove closeModal" data-dismiss="modal"></span>
                        <h3 class="m-t-none m-b">找回密码</h3>
                        <form>
                            <div class="row form-group">
                                <div id="successMsg2" style="color: green;padding-left: 20px;"></div>
                                <div class="col-md-12">
                                    <label class="sr-only" for="phone">手机号</label>
                                    <input type="text" id="phone" name="phone" class="form-control"
                                           placeholder="请输入您的手机号或邮箱" onblur="variNumber1(this.value)">
                                </div>
                                <div id="error" style="color: red;padding-left: 20px;"></div>
                            </div>

                            <div class="row form-group">
                                <div class="col-sm-8" style="margin: 0px;">
                                    <input type="text" id="" name="code" class="form-control" onblur="variCode(this.value)" placeholder="输入手机验证码">
                                </div>
                                <div class="col-sm-4" style="margin: 0px;">
                                    <input type="button" id="getButton"
                                           onclick="getCode2(this)" class="btn btn-primary" maxlength="6"
                                           value="获取验证码" style="padding-left: 10px; padding-right: 10px;">
                                </div>
                            </div>
                            <div id="pwdDiv" style="display:none;">
                                <div class="form-group">
                                    <input type="password" class="form-control" autocomplete="off"  disabled id="pwd" placeholder="请输入新密码"/>
                                </div>
                                <div class="form-group">
                                    <input type="password" class="form-control" autocomplete="off"  disabled id="pwd1" placeholder="请确认密码"/>
                                </div>
                                <div id="error1" style="color: red;padding-left: 20px;"></div>
                            </div>
                            <div class="form-group">
                                <input type="button" onclick="editPwd()" value="确定" id="searchBtn" class="btn btn-primary">
                                <input type="reset" value="重置" class="btn btn-primary">
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<%--login js--%>
<script src="<%=path%>/js/index/login.js"></script>
<!-- jQuery -->
<script src="<%=path%>/js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="<%=path%>/js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="<%=path%>/js/bootstrap.min.js"></script>
<script src="<%=path %>/js/sweet-alert.min.js"></script>
<script src="<%=path %>/js/base64.js"></script>
<!-- Waypoints -->
<script src="<%=path%>/js/jquery.waypoints.min.js"></script>
<!-- Carousel -->
<script src="<%=path%>/js/owl.carousel.min.js"></script>
<!-- countTo -->
<script src="<%=path%>/js/jquery.countTo.js"></script>
<!-- Magnific Popup -->
<script src="<%=path%>/js/jquery.magnific-popup.min.js"></script>
<script src="<%=path%>/js/magnific-popup-options.js"></script>
<!-- Main -->
<script src="<%=path%>/js/webmain.js"></script>


</body>
</html>
