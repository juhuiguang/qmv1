<%--
  Created by IntelliJ IDEA.
  User: Master QB
  Date: 2017/7/25
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>

<head>
    <%@ include file="/commonjsp/meta.jsp"%>
    <script src="script/common/echarts/echarts.js"></script>
    <!--这里引用其他样式-->
    <title>校内教学质量监控运行平台</title>
    <style>
        .ui.form .field>.selection.dropdown {
            width: 80%;
        }
    </style>
</head>

<body>
<%@ include file="/commonjsp/header.jsp"%>
<div id="container">
    <h3 class="ui header">
        <i class="list layout icon"></i>
        <div class="content">教师授课质量分析 </div>
    </h3>
    <div class="ui raised">
        <div class="ui form">
            <div class="fields">
                <div class="field">

                    <select class="ui three dropdown" id="menu_term">
                    </select>

                </div>
                <div class="  five wide field">

                    <select class="ui three dropdown" id="menu_college">
                    </select>
                </div>
                <div class="  field" style="margin-left: -50px;">
                    <select class="ui two dropdown" id="menu_condition">
                        <option value="0">学生评教</option>
                        <option value="1" selected="selected"> 督学听课</option>
                    </select>

                </div>

                <div class="field">
                    <button class="ui basic button" id="btnsubmit"><i class="search icon"></i><b>查&nbsp;询</b></button>

                </div>
                <button class="ui basic button" style="position:absolute;left:87%;"  id="export_dc" data-content="点击导出" data-variation="small"><i class="upload icon"></i> 导 出 </button>
            </div>
        </div>

    </div>
    <div class="ui raised segment" id="form_table">
        <div id="pjmain" style="height:400px"></div>
        <div id="pjmain_dep" style="height:400px"></div>
        <div id="pjmain_per" style="height:400px"></div>
    </div>
    <div class="ui raised segment" id="main_">
        <div id="main" style="height:400px"></div>
        <div id="main_dep" style="height:400px"></div>
        <div id="main_per" style="height:400px"></div>
    </div>


</div>
</body>
<script>
    $(function() {
        var SYSOBJCET = <%= SYSOBJCET %> ;
        var USEROBJECT = <%= USEROBJECT %> ;
        console.log(SYSOBJCET);
        console.log(USEROBJECT);
        var userpurview = USEROBJECT.userpurview;//取到这个的全限
        var college_no;
        var dep_name;
        var termno = SYSOBJCET.term_no;
        var departments=[];
        for (var i = 0; i < (SYSOBJCET.departments).length; i++) {
            if (SYSOBJCET.departments[i].dep_type!="行政") {
                departments.push(SYSOBJCET.departments[i].dep_name);
            }
        }
        loadterm();
        $('#form_table').hide();
        $("#menu_condition").dropdown();
        $("#btnsubmit").click(function() {
            if ($(this).hasClass("loading")) return;
            $("#btnsubmit").addClass("loading");
            run();
        });

        function run() {
            if($("#menu_condition > option:selected").val()==0)
            {
                if (college_no == 0) {
                    load_school_stuchecking();
                } else {
                    load_dep_stuchecking(dep_name);
                }
            }
            else{
                if (college_no == 0) {
                    load_school_masterchecking();
                } else {
                    load_dep_masterchecking(dep_name);
                }
            }
        }

        //加载学期
        function loadterm() {
            $.ajax({
                url: "do?invoke=student_checking_inquire@get_checking_term",
                type: 'POST',
                dataType: 'json',
                success: function(rep) {
                    if (rep.result == 0) {
                        $.alert("学期获取错误");
                    } else {
                        var term_table = rep.data;
                        for (var i = term_table.length - 1; i >= 0; i--) {
                            if (i == term_table.length - 1) {
                                var dom_term = '<option  selected="selected" value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
                                $('#menu_term').append($(dom_term));
                            } else {
                                var dom_term = '<option value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
                                $('#menu_term').append($(dom_term));
                            }
                        }
                        $("#menu_term").dropdown({
                            onChange: function(value, text) {
                                termno = value;
                            }
                        });
                        loadcollege();
                    }
                }
            });
        }

        //加载院系
        function loadcollege() {
            if(userpurview == 'ALL'){
                var dom='<option value="0" selected="selected">所有的院系</option>';
                $('#menu_college').append($(dom));
                for (var i = 0; i < (SYSOBJCET.departments).length; i++) {
                    if (SYSOBJCET.departments[i].dep_type!="行政") {
                        var dom_college = '<option value="' + SYSOBJCET.departments[i].dep_no + '">' + SYSOBJCET.departments[i].dep_name + '</option>';
                        $('#menu_college').append($(dom_college));
                    }
                }
                college_no = $("#menu_college > option:selected").val();
                $("#menu_college").dropdown({
                    onChange: function(value, text) {
                        dep_name = text;
                        college_no=value;
                    }
                });
                load_school_masterchecking();
            }else{
                console.log("123")
                var dom='<option value="'+USEROBJECT.userinfo.dep_no+'" selected="selected">'+USEROBJECT.userinfo.dep_name+'</option>';
                $('#menu_college').append($(dom));
                $("#menu_college").dropdown();
                dep_name = $("#menu_college > option:selected").text();
                college_no = $("#menu_college > option:selected").val();
               /* load_college_checking_photo();*/
            }
        }

        //导出功能
        $("#export_dc").unbind('click').click(function(){
            var type = "excel";
            if($("#menu_condition > option:selected").val()==1)
            {
                if (college_no == 0) {
                    var params = [];
                    params.push(termno);
                    console.log("督学：" +params);
                    open(BASE_PATH+"/qm/base/export.jsp?export_id=25&params="+params+"&type="+type+"&more=1");
                } else {
                    var params = [];
                    params.push(termno);
                    params.push(","+termno);
                    params.push(college_no);
                    console.log("督学部门：" +params);
                    open(BASE_PATH+"/qm/base/export.jsp?export_id=25&params="+params+"&type="+type+"&more=2");
                }
            }
            else{
                if (college_no == 0) {
                    var params = [];
                    params.push(termno);
                    console.log("学生：" +params);
                    open(BASE_PATH+"/qm/base/export.jsp?export_id=26&params="+params+"&type="+type+"&more=1");
                } else {
                    var params = [];
                    params.push(termno);
                    params.push(","+termno);
                    params.push(college_no);
                    console.log("学生部门：" +params);
                    open(BASE_PATH+"/qm/base/export.jsp?export_id=26&params="+params+"&type="+type+"&more=2");
                }
            }
        });




        //获得全校的学生评教数据
        function load_school_stuchecking() {
            $.ajax({
                url: "do?invoke=checkteacherlisten@getDepartmentteassru_pj",
                type: 'POST',
                dataType: 'json',
                data: {
                    term_no: termno,
                },
                success: function(rep) {
                    if (rep.result == 0) {
                        $.alert("暂无任何记录")
                        $('#main_').hide();
                        $('#form_table').show();
                    } else {
                        $('#form_table').show();
                        $("#btnsubmit").removeClass("loading");
                        $('#form_table tr:gt(0)').remove();
                        $('#main_').hide();
                        var avg=[];
                        var department_name=[];
                        var temp = rep.data;
                        for (var i=temp.length-1;i>=0;i--) {
                            avg.push(temp[i].avgmark1);
                            department_name.push(temp[i].dep_name);
                        }
                        var myChart = echarts.init(document.getElementById('pjmain'));
                        myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
                        var option = {
                            title: {
                                text: '学生评教数据分析图',
                            },
                            tooltip : {
                                trigger: 'axis',
                                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            legend: {
                                data: ['评教平均分']
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis:  {
                                type: 'value'
                            },
                            yAxis: {
                                type: 'category',
                                data: department_name
                            },
                            series: [
                                {
                                    name: '评教平均分',
                                    type: 'bar',
                                    label: {
                                        normal: {
                                            show: true,
                                            position: 'insideRight'
                                        }
                                    },
                                    data: avg
                                }
                            ]
                        };
                        myChart.setOption(option);
                        myChart.on('click',function(item){
                            dep_name = item.name;
                            for (var i=0;i<SYSOBJCET.departments.length;i++){
                                if (SYSOBJCET.departments[i].dep_name==dep_name){
                                    college_no=SYSOBJCET.departments[i].dep_no;
                                }
                            }
                            console.log(item.name);
                            load_dep_stuchecking(item.name);
                        });


                    }
                }
            });
        }

        //获得学生评教部门详细数据
        function load_dep_stuchecking(depname) {
            $.ajax({
                url: "do?invoke=checkteacherlisten@getDepartmentstudent_pj",
                type: 'POST',
                dataType: 'json',
                data: {
                    term_no: termno,
                    dep_name:depname
                },
                success: function(rep) {
                    console.log(rep.data)
                    if (rep.result == 0) {
                        $("#btnsubmit").removeClass("loading");
                        $.alert("抱歉！暂无记录")
                        $('#form_table').hide();
                        $('#main_').hide();
                    } else {
                        $('#form_table').show();
                        $('#main_').hide();
                        $("#btnsubmit").removeClass("loading");
                        $('#pjmain').hide();
                        $('#pjmain_per').hide();
                        $('#pjmain_dep').show();
                        var data=[];
                        var teacher_name=[];
                        var temp = rep.data;
                        for (var i=temp.length-1;i>=0;i--) {
                            teacher_name.push(temp[i].teacher_name);
                            var avevalue=[];
                            avevalue.push("0");
                            avevalue.push(temp[i].total);
                            data.push(avevalue);
                        }
                        var myChart = echarts.init(document.getElementById('pjmain_dep'));
                        myChart.setTheme("macarons");     // 设置echart的主题(改变颜色
                        var barHeight = 50;
                        var  option = {
                            title: {
                                text: '学生评教部门详细数据分析图',
                            },
                            legend: {
                                show: true,
                                data: ['价格范围', '均值']
                            },
                            grid: {
                                top: 100
                            },
                            angleAxis: {
                                type: 'category',
                                data: teacher_name
                            },
                            tooltip: {
                                show: true,
                                formatter: function (params) {
                                    var id = params.dataIndex;
                                    return teacher_name[id] + '<br>平均：' + data[id][1];
                                }
                            },
                            radiusAxis: {
                            },
                            polar: {
                            },
                            series: [{
                                type: 'bar',
                                itemStyle: {
                                    normal: {
                                        color: 'transparent'
                                    }
                                },
                                data: data.map(function (d) {
                                    return d[0];
                                }),
                                coordinateSystem: 'polar',
                                stack: '最大最小值',
                                silent: true
                            }, {
                                type: 'bar',
                                data: data.map(function (d) {
                                    return d[1] - d[0];
                                }),
                                coordinateSystem: 'polar',
                                name: '价格范围',
                                stack: '最大最小值'
                            }, {
                                type: 'bar',
                                itemStyle: {
                                    normal: {
                                        color: 'transparent'
                                    }
                                },
                                data: data.map(function (d) {
                                    return d[2] - barHeight;
                                }),
                                coordinateSystem: 'polar',
                                stack: '均值',
                                silent: true,
                                z: 10
                            }],
                            legend: {
                                show: true,
                                data: ['A', 'B', 'C']
                            }
                        };
                        myChart.setOption(option);
                        myChart.on('click',function(item){
                            console.log(item.name);
                            load_dep_teacherperson_student_checking(item.name);

                        });
                    }
                }
            });
        }

        //获得学生评教  部门教师个人详细数据
        function load_dep_teacherperson_student_checking(teacher_name) {
            $.ajax({
                url: "do?invoke=checkteacherlisten@getTeacherStudentListenmark",
                type: 'POST',
                dataType: 'json',
                data: {
                    term_no: termno,
                    dep_name:dep_name,
                    teacher_name:teacher_name
                },
                success: function(rep) {
                    console.log(rep.data);
                    if (rep.result == 0) {
                        $.alert("暂无任何记录")
                        $('#form_table').hide();
                        $('#main_').show();
                    } else {
                        $('#form_table').show();
                        $('#main_').hide();
                        $("#btnsubmit").removeClass("loading");
                        $('#pjmain').hide();
                        $('#pjmain_dep').hide();
                        $('#pjmain_per').show();
                        var data=[];
                        var course_name=[];
                        var temp = rep.data;
                        for (var i=0;i<=temp.length-1;i++) {
                            data.push(temp[i].total);
                            course_name.push(temp[i].course_name)
                        }
                        var myChart = echarts.init(document.getElementById('pjmain_per'));
                        myChart.setTheme("macarons");     // 设置echart的主题(改变颜色
                        var option = {
                            title: {
                                text: '学生评教个人详情：'+teacher_name
                            },
                            tooltip: {
                                trigger: 'axis'
                            },
                            toolbox: {
                                show: true,
                                feature: {
                                    dataZoom: {
                                        yAxisIndex: 'none'
                                    },
                                    dataView: {readOnly: false},
                                    magicType: {type: ['line', 'bar']},
                                    restore: {},
                                    saveAsImage: {}
                                }
                            },
                            xAxis:  {
                                type: 'category',
                                boundaryGap: false,
                                data: course_name
                            },
                            yAxis: {
                                type: 'value',
                                axisLabel: {
                                    formatter: '{value} 分'
                                }
                            },
                            series: [
                                {
                                    name:'督学评教平均值',
                                    type:'line',
                                    data:data,
                                    markPoint: {
                                        data: [
                                            {type: 'max', name: '最大值'},
                                            {type: 'min', name: '最小值'}
                                        ]
                                    }
                                },
                            ]
                        };

                        myChart.setOption(option);
                    }
                }
            });
        }

        //获得全校督学评教数据
        function load_school_masterchecking() {
            $.ajax({
                url: "do?invoke=checkteacherlisten@getDepartmentListenmark",
                type: 'POST',
                dataType: 'json',
                data: {
                    term_no: termno
                },
                success: function(rep) {
                    if (rep.result == 0) {
                        $.alert("暂无任何记录")
                        $('#form_table').hide();
                    } else {
                        $('#form_table').hide();
                        $("#btnsubmit").removeClass("loading");
                        $('#form_table tr:gt(0)').remove();
                        $('#main_').show();
                        var avg=[];
                        var department_name=[];
                        var temp = rep.data;
                        for (var i=temp.length-1;i>=0;i--) {
                            avg.push(temp[i].avgmark1);
                            department_name.push(temp[i].dep_name);
                        }
                        console.log("avg"+avg);
                        console.log("department_name"+department_name);
                        $("#btnsubmit").removeClass("loading");
                        var myChart = echarts.init(document.getElementById('main'));
                        myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
                       var option = {
                            title: {
                                text: '督学评教数据分析图',
                            },
                            tooltip : {
                                trigger: 'axis',
                                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                                }
                            },
                            legend: {
                                data: ['评教平均分']
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            xAxis:  {
                                type: 'value'
                            },
                            yAxis: {
                                type: 'category',
                                data: department_name
                            },
                            series: [
                                {
                                    name: '评教平均分',
                                    type: 'bar',
                                    label: {
                                        normal: {
                                            show: true,
                                            position: 'insideRight'
                                        }
                                    },
                                    data: avg
                                }
                            ]
                        };
                        myChart.setOption(option);
                        myChart.on('click',function(item){
                            dep_name=item.name;
                            console.log(item.name);
                            for (var i=0;i<SYSOBJCET.departments.length;i++){
                                if (SYSOBJCET.departments[i].dep_name==dep_name){
                                    college_no=SYSOBJCET.departments[i].dep_no;
                                }
                            }
                            load_dep_masterchecking(item.name)
                        });
                    }
                }
            });
        }


        //获取督学评教院系详细数据
        function load_dep_masterchecking(dep_name) {
            $.ajax({
                url: "do?invoke=checkteacherlisten@getDepartmentmaster_pj",
                type: 'POST',
                dataType: 'json',
                data: {
                    term_no: termno,
                    dep_name:dep_name
                },
                success: function(rep) {
                    if (rep.result == 0) {
                        $.alert("暂无任何记录")
                        $('#main_').hide();
                        $('#form_table').show();
                    } else {
                        $('#form_table').hide();
                        $("#btnsubmit").removeClass("loading");
                        $('#form_table tr:gt(0)').remove();
                        $('#main_').show();
                        $('#main').hide();
                        $('#main_per').hide();
                        $('#main_dep').show();
                        var data=[];
                        var teacher_name=[];
                        var temp = rep.data;
                        for (var i=temp.length-1;i>=0;i--) {
                            teacher_name.push(temp[i].teacher_name);
                            var avevalue=[];
                            avevalue.push("0");
                            avevalue.push(temp[i].total);
                            data.push(avevalue);
                        }
                        var myChart = echarts.init(document.getElementById('main_dep'));
                        myChart.setTheme("macarons");     // 设置echart的主题(改变颜色
                        var barHeight = 50;
                        var option = {
                            title: {
                                text: '督学评教部门详细数据分析图',
                            },
                            legend: {
                                show: true,
                                data: ['价格范围', '均值']
                            },
                            grid: {
                                top: 100
                            },
                            angleAxis: {
                                type: 'category',
                                data: teacher_name
                            },
                            tooltip: {
                                show: true,
                                formatter: function (params) {
                                    var id = params.dataIndex;
                                    return teacher_name[id] +  '<br>平均：' + data[id][1];
                                }
                            },
                            radiusAxis: {
                            },
                            polar: {
                            },
                            series: [{
                                type: 'bar',
                                itemStyle: {
                                    normal: {
                                        color: 'transparent'
                                    }
                                },
                                data: data.map(function (d) {
                                    return d[0];
                                }),
                                coordinateSystem: 'polar',
                                stack: '最大最小值',
                                silent: true
                            }, {
                                type: 'bar',
                                data: data.map(function (d) {
                                    return d[1] - d[0];
                                }),
                                coordinateSystem: 'polar',
                                name: '价格范围',
                                stack: '最大最小值'
                            }, {
                                type: 'bar',
                                itemStyle: {
                                    normal: {
                                        color: 'transparent'
                                    }
                                },
                                data: data.map(function (d) {
                                    return d[2] - barHeight;
                                }),
                                coordinateSystem: 'polar',
                                stack: '均值',
                                silent: true,
                                z: 10
                            }],
                            legend: {
                                show: true,
                                data: ['A', 'B', 'C']
                            }
                        };
                        myChart.setOption(option);
                        myChart.on('click',function(item){
                            console.log(item.name);
                            load_dep_teacherperson_master_checking(item.name);

                        });
                    }
                }
            });
        }

        //获得督学评教  部门教师个人详细数据
       function load_dep_teacherperson_master_checking(teacher_name) {
           $.ajax({
               url: "do?invoke=checkteacherlisten@getTeacherMasterListenmark",
               type: 'POST',
               dataType: 'json',
               data: {
                   term_no: termno,
                   dep_name:dep_name,
                   teacher_name:teacher_name
               },
               success: function(rep) {
                   console.log(rep.data);
                   if (rep.result == 0) {
                       $.alert("暂无任何记录")
                       $('#main_').hide();
                       $('#form_table').show();
                   } else {
                       $('#form_table').hide();
                       $("#btnsubmit").removeClass("loading");
                       $('#form_table tr:gt(0)').remove();
                       $('#main_').show();
                       $('#main_dep').hide();
                       $('#main').hide();
                       $('#main_per').show();
                       var data=[];
                       var course_name=[];
                       var temp = rep.data;
                       for (var i=0;i<=temp.length-1;i++) {
                           data.push(temp[i].total);
                           course_name.push(temp[i].course_name)
                       }
                       var myChart = echarts.init(document.getElementById('main_per'));
                       myChart.setTheme("macarons");     // 设置echart的主题(改变颜色
                      var option = {
                           title: {
                               text: '督学评教个人详情：'+teacher_name
                           },
                           tooltip: {
                               trigger: 'axis'
                           },
                           toolbox: {
                               show: true,
                               feature: {
                                   dataZoom: {
                                       yAxisIndex: 'none'
                                   },
                                   dataView: {readOnly: false},
                                   magicType: {type: ['line', 'bar']},
                                   restore: {},
                                   saveAsImage: {}
                               }
                           },
                           xAxis:  {
                               type: 'category',
                               boundaryGap: false,
                               data: course_name
                           },
                           yAxis: {
                               type: 'value',
                               axisLabel: {
                                   formatter: '{value} 分'
                               }
                           },
                           series: [
                               {
                                   name:'督学评教平均值',
                                   type:'line',
                                   data:data,
                                   markPoint: {
                                       data: [
                                           {type: 'max', name: '最大值'},
                                           {type: 'min', name: '最小值'}
                                       ]
                                   }
                               },
                           ]
                       };

                       myChart.setOption(option);
                   }
               }
           });
       }
    });
</script>
<!--这里引用其他JS-->

</html>