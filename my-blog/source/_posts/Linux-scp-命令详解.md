---
title: Linux scp 命令详解
date: 2024-04-17 19:42:08
tags:
- Linux
---
## 一、命令格式
  输入 scp help 查看命令格式。
```
$ scp help
usage: scp [-12346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file]
           [-l limit] [-o ssh_option] [-P port] [-S program]
           [[user@]host1:]file1 ... [[user@]host2:]file2

```

## 二、选项含义
  输入 man scp 查看具体选项的含义。
```
$ man scp
SCP(1)                                                              BSD General Commands Manual                                                             SCP(1)

NAME
     scp — secure copy (remote file copy program)

SYNOPSIS
     scp [-12346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file] [-l limit] [-o ssh_option] [-P port] [-S program] [[user@]host1:]file1 ...
         [[user@]host2:]file2

DESCRIPTION
     scp copies files between hosts on a network.  It uses ssh(1) for data transfer, and uses the same authentication and provides the same security as ssh(1).
     scp will ask for passwords or passphrases if they are needed for authentication.

     File names may contain a user and host specification to indicate that the file is to be copied to/from that host.  Local file names can be made explicit
     using absolute or relative pathnames to avoid scp treating file names containing ‘:’ as host specifiers.  Copies between two remote hosts are also permitted.

     The options are as follows:

     -1      Forces scp to use protocol 1.

     -2      Forces scp to use protocol 2.

     -3      Copies between two remote hosts are transferred through the local host.  Without this option the data is copied directly between the two remote
             hosts.  Note that this option disables the progress meter.

     -4      Forces scp to use IPv4 addresses only.

     -6      Forces scp to use IPv6 addresses only.

     -B      Selects batch mode (prevents asking for passwords or passphrases).

     -C      Compression enable.  Passes the -C flag to ssh(1) to enable compression.

     -c cipher
             Selects the cipher to use for encrypting the data transfer.  This option is directly passed to ssh(1).

     -F ssh_config
             Specifies an alternative per-user configuration file for ssh.  This option is directly passed to ssh(1).

     -i identity_file
             Selects the file from which the identity (private key) for public key authentication is read.  This option is directly passed to ssh(1).

     -l limit
             Limits the used bandwidth, specified in Kbit/s.

     -o ssh_option
             Can be used to pass options to ssh in the format used in ssh_config(5).  This is useful for specifying options for which there is no separate scp
             command-line flag.  For full details of the options listed below, and their possible values, see ssh_config(5).

                   AddressFamily
                   BatchMode
                   BindAddress
                   CanonicalDomains
                   CanonicalizeFallbackLocal
                   CanonicalizeHostname
                   CanonicalizeMaxDots
                   CanonicalizePermittedCNAMEs
                   CertificateFile
                   ChallengeResponseAuthentication
                   CheckHostIP
                   Cipher
                   Ciphers
                   Compression
                   CompressionLevel
                   ConnectionAttempts
                   ConnectTimeout
                   ControlMaster
                   ControlPath
                   ControlPersist
                   GlobalKnownHostsFile
                   GSSAPIAuthentication
                   GSSAPIDelegateCredentials
                   HashKnownHosts
                   Host
                   HostbasedAuthentication
                   HostbasedKeyTypes
                   HostKeyAlgorithms
                   HostKeyAlias
                   HostName
                   IdentitiesOnly
                   IdentityAgent
                   IdentityFile
                   IPQoS
                   KbdInteractiveAuthentication
                   KbdInteractiveDevices
                   KexAlgorithms
                   LogLevel
                   MACs
                   NoHostAuthenticationForLocalhost
                   NumberOfPasswordPrompts
                   PasswordAuthentication
                   PKCS11Provider
                   Port
                   PreferredAuthentications
                   Protocol
                   ProxyCommand
                   ProxyJump
                   PubkeyAcceptedKeyTypes
                   PubkeyAuthentication
                   RekeyLimit
                   RhostsRSAAuthentication
                   RSAAuthentication
                   SendEnv
                   ServerAliveInterval
                   ServerAliveCountMax
                   StrictHostKeyChecking
                   TCPKeepAlive
                   UpdateHostKeys
                   UsePrivilegedPort
                   User
                   UserKnownHostsFile
                   VerifyHostKeyDNS

     -P port
             Specifies the port to connect to on the remote host.  Note that this option is written with a capital ‘P’, because -p is already reserved for pre‐
             serving the times and modes of the file.

     -p      Preserves modification times, access times, and modes from the original file.

     -q      Quiet mode: disables the progress meter as well as warning and diagnostic messages from ssh(1).

     -r      Recursively copy entire directories.  Note that scp follows symbolic links encountered in the tree traversal.

     -S program
             Name of program to use for the encrypted connection.  The program must understand ssh(1) options.

     -v      Verbose mode.  Causes scp and ssh(1) to print debugging messages about their progress.  This is helpful in debugging connection, authentication, and
             configuration problems.

EXIT STATUS
     The scp utility exits 0 on success, and >0 if an error occurs.

SEE ALSO
     sftp(1), ssh(1), ssh-add(1), ssh-agent(1), ssh-keygen(1), ssh_config(5), sshd(8)

HISTORY
     scp is based on the rcp program in BSD source code from the Regents of the University of California.

AUTHORS
     Timo Rinne <tri@iki.fi>
     Tatu Ylonen <ylo@cs.hut.fi>

BSD                                                                      November 6, 2020                                                                      BSD

```


## 三、命令参数中文释义

- -1 强制 scp 命令使用协议 ssh1。
- -2 强制 scp 命令使用协议 ssh2。
- -3 通过本机主机在两个远程主机之间传输数据。没有这个选项，数据将直接在远程主机间拷贝数据。 注意：这个选项不支持进度条显示。
- -4 强制 scp 命令只使用 IPv4 寻址。
- -6 强制 scp 命令只使用 IPv6 寻址。
- -B 使用批处理模式（传输过程中不询问传输口令或短语）。
- -C 允许压缩。（将 -C 标志传递给 ssh，从而打开压缩功能）。
- -p 保留原文件的修改时间，访问时间和访问权限。
- -q 不显示传输进度条。
- -r 递归复制整个目录。
- -v 详细方式显示输出。scp 和 ssh(1) 会显示出整个过程的调试信息。这些信息用于调试连接，验证和配置问题。
- -c cipher 以 cipher 将数据传输进行加密，这个选项将直接传递给ssh。
- -F ssh_config 指定一个替代的 ssh 配置文件，此参数直接传递给ssh。
- -i identity_file 从指定文件中读取传输时使用的密钥文件，此参数直接传递给ssh。
- -l limit 限定用户所能使用的带宽，以Kbit/s为单位。
- -P port 指定数据传输用到的端口号
- -S program 指定加密传输时所使用的程序。此程序必须能够理解 ssh(1) 的选项。
## 四、使用示例
环境信息：
|                        |                 |
| ---------------------- | --------------- |
| 远程服务器IP           | 47.100.247.240  |
| 远程服务器登录用户     | testuser        |
| 远程服务器文件所在路径 | /home/testuser/ |
| 远程服务器文件名       | test.sql        |
| 本地服务器文件路径     | /home/testuser1 |
| 本地服务器文件名       | test1.sql       |


1. 将远程服务器文件拷贝到本地服务器当前路径下  
在本地服务器当前路径下，输入如下命令，回车后输入远程服务器的登录密码，即可将远程文件拷贝到本地服务器当前路径下。
```
$ scp testuser@47.100.247.240:/home/testuser/test.sql .
```

2. 将本地服务器文件推送到远程服务器  
在本地服务器当前路径下，输入如下命令，回车后输入远程服务器的登录密码，即可将本地文件拷贝到远程服务器指定路径下。
```
$ scp test1.sql testuser@47.100.247.240:/home/testuser/
```

3. 将远程服务器文件夹全部复制到本地服务器
```
$ scp -r testuser@47.100.247.240:/home/testuser/ .
```

4. 将本地服务器文件夹全部复制到远程服务器
```
$ scp -r /home/testuser1/ testuser@47.100.247.240:/home/testuser/
```

