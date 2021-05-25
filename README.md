# GitHub Hosts

`GitHub Hosts`主要是通过修改`host`的方式加速`GitHub`访问，解决图片无法加载以及访问速度慢的问题。

- 主站: https://github.com/Rexexe/git_hosts

## 说明

|  文件   | 说明  |
|  ----  | ----  |
| git_hosts_update.sh  | 查询当前服务器ip，某些地区可能会连接失败 |
| hosts  | 官方服务器当前hosts集合 |
| git_hosts.sh  | 指定测速全球数据中心，提取最快的服务器ip |
| hosts_fast  | 当前最快hosts |

推荐使用hosts_fast，或者自行运行git_hosts.sh

## 使用方式


### 手动配置hosts

#### macOS

`hosts`文件位置：`/etc/hosts`。

`macOS`系统下修改需要按照如下方式：

##### 1：首先，打开 Mac 终端（command + 空格）。

##### 2：使用cd命令跳转到 git_hosts.sh 所在目录。

##### 3：直接使用命令 sudo ./git_hosts.sh

##### 4：等待替换完成之后关闭终端。

> 注意：如果要求输入密码，你需要输入你管理员账号对应的密码。

最后刷新缓存：

```shell
sudo killall -HUP mDNSResponder
```

#### Windows

`hosts`文件位置：`C:/windows/system32/drivers/etc/hosts`。

将仓库`hosts`内容追加到`hosts`文件，然后刷新`DNS`缓存：

```shell
ipconfig /flushdns
```

### 通过 SwitchHosts! 自动更新

这里推荐使用 `SwitchHosts!` 配置`hosts`，操作很简单，支持跨平台。

详细介绍可以阅读 [SwitchHosts! 还能这样管理hosts，后悔没早点用](https://mp.weixin.qq.com/s/A37XnD3HdcGSWUflj6JujQ) 。

#### 手动配置

添加一条`hosts`规则并启用，然后复制前文`hosts`内容即可。

如果你想保持和云端最新规则同步，可以用下面的配置方式。

#### 定时同步

添加一条规则：

- 方案名：GitHub（可以自行命名）
- 类型：远程
- URL 地址：https://cdn.jsdelivr.net/gh/Rexexe/git_hosts/hosts_fast
- 自动更新：1个小时

这样就可以和最新的`hosts`保持同步。

![switchhost-github.png](https://cdn.jsdelivr.net/gh/Rexexe/git_hosts/SwitchHosts!.png)


## 参考仓库

- [GitHub Hosts](https://github.com/ineo6/hosts)：GitHub最新hosts，定时更新
- [UsbEAm](https://github.com/dogfight360/UsbEAm)：UsbEAm backup source
