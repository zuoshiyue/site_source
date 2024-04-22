---
title: Hexo - 为文章添加目录
date: 2024-04-17 19:05:50
tags:
- Hexo
---

安装插件
```
npm install hexo-toc --save
```

配置博客根目录下的`_config.yml`文件
```
toc:
  maxdepth: 3
```
  
添加目录
在需要展示目录的地方添加：

<!-- toc -->
复制
注意：显示的目录只会包含代码段` < !-- toc -->`之后的内容