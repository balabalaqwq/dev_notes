# Git 异常

## 1.fatal: unable to access 'https://github.com/balabalaqwq/fengwuxp_dart_basic.git/': Unknown SSL protocol error in connection to github.com:443

参考https://stackoverflow.com/a/20492254/14238534

git命令：

set GIT_CURL_VERBOSE=1

set GIT_TRACE_PACKET=2



## 2.Git error. Command: `git fetch`
stdout: 
stderr: fatal: unable to access 'https://github.com/RichsJeson/fengwuxp_dart_feign.git/': OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to github.com:443 
exit code: 128