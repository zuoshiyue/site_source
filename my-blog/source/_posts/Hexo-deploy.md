---
title: Hexo - deploy
date: 2024-04-17 19:16:10
tags:
- Hexo
---
    
1. 安装 `hexo-deployer-git`。  
```
$ npm install hexo-deployer-git --save
```

2. 修改配置。
```
deploy:
  type: git
  repo: <repository url> #https://bitbucket.org/JohnSmith/johnsmith.bitbucket.io
  branch: [branch]
  message: [message]
```

| 参数    | 描述                                                                 | 默认                                                              |
| ------- | -------------------------------------------------------------------- | ----------------------------------------------------------------- |
| repo    | 库（Repository）地址                                                 |                                                                   |
| branch  | 分支名称                                                             | gh-pages (GitHub)<br>coding-pages (Coding.net)<br>master (others) |
| message | 自定义提交信息                                                       | `Site updated: {{ now('YYYY-MM-DD HH:mm:ss') }})`                   |
| token   | 可选的令牌值，用于认证 repo。用 `$` 作为前缀从而从环境变量中读取令牌 |                                                                   |
		

3. 生成站点文件并推送至远程库。执行 `hexo clean && hexo deploy`。
- 除非你使用令牌或 SSH 密钥认证，否则你会被提示提供目标仓库的用户名和密码。
- hexo-deployer-git 并不会存储你的用户名和密码. 请使用 `git-credential-cache` 来临时存储它们。
4. 登入 Github/BitBucket/Gitlab，请在库设置（Repository Settings）中将默认分支设置为`_config.yml`配置中的分支名称。稍等片刻，您的站点就会显示在您的Github Pages中。
