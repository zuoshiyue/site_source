---
title: ApacheBench压测
date: 2024-04-22 19:31:41
tags:
- 测试
- ApacheBench
---
<!-- toc -->

安装

- 安装
```
yum -y install httpd-tools


1
```

- 查看版本
```shell
ab -V
```

dome
```json
ab -n 1000000 -c 200 -r  "http://localhost:8080/helloworld?name=小明" 
```
```json
#压测命令
ab -n 1000000 -c 1000 -r -p data.json -T 'application/json' "http://localhost:8080/public/regist"
1
2
#编辑请求数据
# vi data.json
{
"account":"128983321",
"nickname":"小明",
"sex":"男",
"age":22,
"password":"DFKJDFJDLSDKSKL&%DFSD"
}
```
参数
```json
-n 测试会话中所执行的请求个数,默认仅执行一个请求,如果不指定-t参数，默认执行完所有请求后自动结束压测

-c 一次产生的请求个数,即同一时间发出多少个请求,默认为一次一个,此参数可以控制对服务器的单位时间内的并发量

-t 测试所进行的最大秒数,默认为无时间限制....其内部隐含值是[-n 50000],它可以使对服务器的测试限制在一个固定的总时间以内,如果时间到了，请求个数还未执行完，也会被停止。

-p 包含了需要POST的数据的文件,数据格式以接口请求参数定义的格式为准,eg. xxx.json
  #json 内容示例： {"name":"小明","sex":"男"}

-T POST 数据所使用的Content-type头信息,指定请求参数格式，eg. application/json

-r 在接口返回失败后，默认会终止压测，添加此参数后压测会继续进行

-v 设置显示信息的详细程度

-w 以HTML表格的形式输出结果,默认是白色背景的两列宽度的一张表

-i 以HTML表格的形式输出结果,默认是白色背景的两列宽度的一张表

-x 设置属性的字符串,此属性被填入[/table]

-y 设置属性的字符串

-z 设置[table]属性的字符串

-C 对请求附加一个Cookie行，其典型形式是name=value的参数对,此参数可以重复

-H 对请求附加额外的头信息,此参数的典型形式是一个有效的头信息行,其中包含了以冒号分隔的字段和值的对(如"Accept-Encoding:zip/zop;8bit")

-A HTTP验证,用冒号:分隔传递用户名及密码

-P 无论服务器是否需要(即是否发送了401认证需求代码),此字符串都会被发送

-X 对请求使用代理服务器

-V 显示版本号并退出

-k 启用HTTP KeepAlive(长连接)功能,即在一个HTTP会话中执行多个请求,默认为不启用KeepAlive功能

-d 不显示"percentage served within XX [ms] table"的消息(为以前的版本提供支持)

-S 不显示中值和标准背离值,且均值和中值为标准背离值的1到2倍时,也不显示警告或出错信息,默认会显示最小值/均值/最大值等(为以前的版本提供支持)

-g 把所有测试结果写入一个'gnuplot'或者TSV(以Tab分隔的)文件

-e 产生一个以逗号分隔的(CSV)文件,其中包含了处理每个相应百分比的请求所需要(从1%到100%)的相应百分比的(以微秒为单位)时间

-h 显示使用方法

-k 发送keep-alive指令到服务器端
```

压测结果分析
```json
This is ApacheBench, Version 2.3 <$Revision: 1430300 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 172.25.0.248 (be patient)
Completed 1000 requests
Completed 2000 requests
Completed 3000 requests
Completed 4000 requests
Completed 5000 requests
Completed 6000 requests
Completed 7000 requests
Completed 8000 requests
Completed 9000 requests
Completed 10000 requests
Finished 10000 requests


Server Software:        
Server Hostname:        127.0.0.1  #请求的URL主机名
Server Port:            8080  #请求端口

Document Path:          /helloworld?name=小明  #请求路径
Document Length:        29 bytes  #HTTP响应数据的正文长度

Concurrency Level:      1000 #并发用户数，这是我们设置的参数之一（-c）
Time taken for tests:   129.957 seconds  #所有这些请求被处理完成所花费的总时间 单位秒
Complete requests:      10000  #总请求数量，这是我们设置的参数之一（-n）
Failed requests:        0      #表示失败的请求数量
Write errors:           0      #所有请求的响应数据长度总和。包括每个HTTP响应数据的头信息和正文数据的长度
Total transferred:      1500000 bytes   #所有请求的响应数据中正文数据的总和，也就是减去了Total transferred中HTTP响应数据中的头信息的长度

HTML transferred:       290000 bytes    #吞吐量，计算公式：Complete requests/Time taken for tests  总请求数/处理完成这些请求数所花费的时间

Requests per second:    76.95 [#/sec] (mean)  #用户平均请求等待时间，计算公式：Time token for tests/（Complete requests/Concurrency Level）。处理完成所有请求数所花费的时间/（总请求数/并发用户数）

Time per request:       12995.680 [ms] (mean) #用户平均请求等待时间，计算公式：Time token for tests/（Complete requests/Concurrency Level）。处理完成所有请求数所花费的时间/（总请求数/并发用户数）

Time per request:       12.996 [ms] (mean, across all concurrent requests)  #服务器平均请求等待时间，计算公式：Time taken for tests/Complete requests，正好是吞吐率的倒数。也可以这么统计：Time per request/Concurrency Level

Transfer rate:          11.27 [Kbytes/sec] received  #表示这些请求在单位时间内从服务器获取的数据长度，计算公式：Total trnasferred/ Time taken for tests，这个统计很好的说明服务器的处理能力达到极限时，其出口宽带的需求量。

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0   24 150.7      0    1003
Processing:    73 12348 2207.1  12966   13916
Waiting:       53 12348 2207.1  12966   13916
Total:         73 12373 2199.0  12968   14023

Percentage of the requests served within a certain time (ms)
  50%  12968 #50%的请求在13秒内返回
  66%  13005 
  75%  13031
  80%  13049
  90%  13109
  95%  13173
  98%  13260
  99%  13350 #99%的请求在13.4秒内返回
 100%  14023 (longest request)
```
