# AppHostExample

本示例工程一共有 5 个实例，分别展示 AppHost 不同方面的能力，用户可自选下载后，运行后选择不同用例体验。

## 如何打开远程调试功能
工程代码运行之后，按照 XCode 日志里的提示(或者点击 App 里右上角一个 AH 样的图标，展开后的日志了有 url，长按复制或者在浏览器输入)，用电脑浏览器打开调试页面，展现的就是调试 Console。

### 1. 加载京东页面，拦截京东 JSBridge 协议
**本用例展示**：AppHost 不仅提供了内置的 JSBridge 协议，还可以和原有的协议共存。
通过继承 AppHostViewController，重载了 decidePolicy 来实现这一点。保持内聚的同时，也具备一定的灵活性。
另外，可以看到 AppHostRespone 作为业务逻辑实现类的角色，不仅可以被 h5 调用，AppHost 也可以让 native 主动调用此能力。将前后端能力统一。
>操作步骤；
 点击顶部的立即下载，此时弹出一个 toast，内容是京东 JSBridge 接口参数。 另外这里的 toast 是由 AppHostRespone 的扩展类 HUDResponse 来实现具体功能的，展示灵活的业务扩展能力。

PS: 通过 AppHost 提供的 debugger，可以看到线上的代码里还有 console.log 日志
### 2. 加载严选移动端首页，观察其性能参数
**本用例展示**：AppHost 的定制能力和 timing 工具。这次加载的进度条是金色的，颜色是可配置的,当遇到某个请求 302 时，进度条也可以正常显示。
>查看 timing 步骤，首先用电脑浏览器打开调试页面（步骤见前面描述），按照提示或者点击左侧快捷菜单、或直接输入 :timing 接口查看
### 3. 加载严选酒水专题页面，使用 weinre 调试样式
**本用例展示**:  AppHost 的扩展能力，可以接入现有的工具，增强调试能力。
> 首先用电脑浏览器打开调试页面（步骤见前面描述），在命令行里输入，本地启动的 weinre 目标调试脚本，如`:weinre http://10.12.0.0:8888/target/target-script-min.js#anonymous`，不需要修改目标调试页面即可实现对此页面的调试，而且对后续的所有页面都有效。

注意：因为浏览器 CSP 的限制 https 的页面无法加载 http 的资源。如果需要调试 https，你可能需要安装 ngrok，输入命令，`:weinre https://3c2c9d94.ngrok.io/target/target-script-min.js#anonymous`
### 4. 加载本地文件夹，测试接口参数
**本用例展示**:  AppHost 加载本地文件夹资源的能力。可以加载 html，以及 html 里引用的相同目录下的 图片资源\\javascript\\css 文件 3 类资源（不支持字体等）。
如果要加载的主域是 http 的，可以使用嵌套性的资源引用，如 css 文件里引用了一个相对路径的图标。
### 5. 加载本地页面，向美团服务器发 ajax 请求
**本用例展示**: 本地文件向美团的服务器发送请求。因为 Cookie 不对，所以返回错误数据，但也演示了，是可以正确的发送和接受数据的
