ModSecurity v3 规则开发环境, 适合用来测试和研究单条规则

# 运行容器

```
~ # docker run -ti -p 80:80 -e ERRORLOG=/tmp/nginx_error.log -e MODSEC_DEBUG_LOG=/tmp/debug.log -e MODSEC_DEBUG_LOGLEVEL=9 -e MODSEC_AUDIT_LOG=/tmp/audit.log -e BACKEND=http://10.56.58.13:8888 crs-dev
```

注意修改 -e BACKEND 指向你的后端服务, 修改 -p 80:80 暴露端口

访问 127.0.0.1:80 就可以访问后端服务
访问 127.0.0.1:80/block-test ，返回403，说明WAF正常工作

# 查看lua日志

debug.lua打印的日志在容器的/tmp/lua_debug.txt路径下

```
~ # cat /tmp/lua_debug.txt 
========debug start=======
{}
{}
{}
{ {
    name = "PATH_INFO",
    value = "/block-test"
  } }
========debug end=======
```

# 怎么用这个环境测试单条规则？

1. 进入到容器中 `docker exec -ti crs-dev bash`
2. 使用 `vim /etc/modsecurity.d/setup.conf` 编辑文件，在文件尾部添加你的规则
3. 执行 `nginx -s reload` 重新加载你的规则
4. 使用curl 或 BurpSuite 测试你的规则

# 快捷指令
容器bash环境下，你可以用如下快捷指令

```
alias 1="nginx -s reload"
alias 2="vim /tmp/debug.lua"
alias 3="vim /etc/modsecurity.d/setup.conf"
alias 4="cat /tmp/lua_debug.txt"

8e278f842624:/usr/share/nginx/html# 1
2024/02/06 06:42:42 [notice] 195#195: ModSecurity-nginx v1.0.3 (rules loaded inline/local/remote: 0/12/0)
2024/02/06 06:42:42 [notice] 195#195: signal process started
8e278f842624:/usr/share/nginx/html# 4
========debug start=======
{}
{}
{}
{ {
    name = "PATH_INFO",
    value = "/healthz"
  } }
========debug end=======
```