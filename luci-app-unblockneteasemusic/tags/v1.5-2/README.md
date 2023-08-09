# 前言：
1. #### 这是一个用于解除网易云音乐播放限制的OpenWRT/LEDE插件，完整支持 播放/下载 无版权/收费 歌曲
2. #### 如果你目前的网易云音乐客户端能正常使用，那就不要轻易升级（不然可能会炸）
3. #### 求dalao们点个Star
4. #### 欢迎加入我的Telegram群组：[@ctcgfw_openwrt_discuss](https://t.me/ctcgfw_openwrt_discuss)

## 功能说明：
1. 支持自定义音源选择，一般设置默认即可；如需高音质音乐，推荐选择“咪咕”或“酷我”
2. 支持使用IPset/Hosts自动劫持相关请求，客户端无需设置代理即可使用
3. 支持HTTPS劫持，客户端信任证书后即可正常使用，网页端需要额外安装油猴插件：[NeteaseMusic UI Unlocker](https://greasyfork.org/zh-CN/scripts/382285-neteasemusic-ui-unlocker)
4. 支持将服务公开至公网（默认监听局域网），支持开启严格模式
5. 支持设定代理，支持指定网易云音乐服务器IP（针对Hosts劫持法）
- PS：如果直接在本插件中开启Hosts劫持，则无需指定网易云音乐服务器IP

## 原理
- 其原理是采用 [网易云旧链/QQ/虾米/百度/酷狗/酷我/咕咪/JOOX] 等音源，替换网易云 无版权/收费 歌曲链接
- 通俗地理解就是通过脚本，将主流客户端的音乐链接汇集到一个客户端上

## 编译
- 插件显式依赖Node.JS，OpenWRT/LEDE源码默认是v8.10.0版本，编译过程中下载会比较慢，可以提前将Node.JS源码下载好上传到dl目录
- 下载链接(17.5M)：https://nodejs.org/dist/v8.10.0/node-v8.10.0.tar.xz  
```bash
    #进入OpenWRT/LEDE源码package目录
    cd package
    #克隆插件源码
    git clone https://github.com/project-openwrt/UnblockNeteaseMusic.git
    #返回上一层目录
    cd ..
    #配置
    make menuconfig
    #在luci->application选中插件，开始编译
    make package/luci-app-unblockneteasemusic/compile V=99
```

## 使用方法
- ### 路由器插件配置
1. 在路由器Luci界面“服务”选项中找到“解除网易云音乐播放限制”
2. 勾选“启用本插件”
3. “音源接口”选择“默认”
4. 勾选“启用劫持”
5. 点击“保存&应用”
- 现在您局域网下的设备，即可自动解除播放限制
- ### 特别说明
1. iOS/MacOS设备请将 WiFi/有线 代理方式设置为自动
2. 如需使用网页端，请额外安装Tampermonkey插件：[NeteaseMusic UI Unlocker](https://greasyfork.org/zh-CN/scripts/382285-neteasemusic-ui-unlocker)
3. 推荐在客户端信任[UnblockNeteaseMusic证书](https://raw.githubusercontent.com/nondanee/UnblockNeteaseMusic/master/ca.crt)，以方便HTTPS通讯；若您不放心，也可以[自行签发证书](https://github.com/nondanee/UnblockNeteaseMusic/issues/48#issuecomment-477870013)

## 效果图
### luci界面
  ![Image text](https://raw.githubusercontent.com/project-openwrt/luci-app-unblockmusic/master/views/view1.jpg)
  ![Image text](https://raw.githubusercontent.com/project-openwrt/luci-app-unblockmusic/master/views/view2.jpg)
  ![Image text](https://raw.githubusercontent.com/project-openwrt/luci-app-unblockmusic/master/views/view3.jpg)
### UWP网易云音乐客户端
  ![Image text](https://raw.githubusercontent.com/project-openwrt/luci-app-unblockmusic/master/views/view4.jpg)

## 协议
### 本项目使用[GPLv3.0](https://github.com/project-openwrt/UnblockNeteaseMusic/blob/master/LICENSE)协议授权，在遵循此协议的前提下，你可以自由修改和分发
#### 总而言之，根据协议，你可以：
- ##### 仅自己使用，在不重新分发的情况下，没有任何限制
- ##### 不修改源代码并重新分发，需要在明显的地方标注本项目源码地址，并沿用GPLv3.0协议
- ##### 修改源代码（包括引用）并重新分发，需提供修改后的源码，并沿用GPLv3.0协议

## 鸣谢
##### [UnblockNeteaseMusic](https://github.com/nondanee/UnblockNeteaseMusic)的开发者：[nondanee](https://github.com/nondanee)
##### [luci-app-unblockmusic](https://github.com/maxlicheng/luci-app-unblockmusic)的开发者：[maxlicheng](https://github.com/maxlicheng)
##### IPSet劫持方式指导：[恩山692049 #125楼](https://www.right.com.cn/forum/forum.php?mod=viewthread&tid=692049&page=9#pid4104303) [Lean修改版](https://github.com/coolsnowwolf/lede/tree/master/package/lean/luci-app-unblockmusic)
##### Hosts劫持方式指导：[UnblockNeteaseMusic](https://github.com/nondanee/UnblockNeteaseMusic) [云音乐安卓又搞事啦](https://jixun.moe/post/netease-android-hosts-bypass/)

