//
//  MasterViewController.m
//  AppHostExample
//
//  Created by liang on 2019/4/16.
//  Copyright © 2019 liang. All rights reserved.
//

#import "MasterViewController.h"
#import "WebViewViewController.h"
#import <AppHost/AppHost.h>
#import "HUDResponse.h"

@interface MasterViewController ()

@property NSArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    kWebViewProgressTintColorRGB = 0xdcb000;
    kFakeCookieWebPageURLWithQueryString = @"https://you.163.com?26u-KQa-fKQ-3BD";
    kGCDWebServer_logging_enabled = YES;
    [[AHDebugServerManager sharedInstance] showDebugWindow];
    [[AHDebugServerManager sharedInstance] start];
    // 添加新的 Response，提供新的接口能力
    [[AHResponseManager defaultManager] addCustomResponse:HUDResponse.class];
    
    // Do any additional setup after loading the view.
    // https://h5.m.jd.com/babelDiy/Zeus/2eWUit9hhREhCRJqkBCB1VXCTvw9/index.html?channel=5&lng=120.186718&lat=30.189141&un_area=15_1213_1215_50115&sid=67b5c76977573adac5a0b17718113f7w#/
    NSArray *dataSource = [NSArray arrayWithObjects:
                           @{@"name":@"加载京东页面，拦截京东 JSBridge 协议",
                             @"url": @"https://item.m.jd.com/ware/view.action?wareId=5904827&sid=null",
                             @"desc":@"本用例展示：AppHost 不仅提供了内置的 JSBridge 协议，还可以和原有的协议共存。\n 通过继承 AppHostViewController，重载了 decidePolicy 来实现这一点。保持内聚的同时，也具备一定的灵活性。\na.另外，可以看到 AppHostRespone 作为业务逻辑实现类的角色，不仅可以被 h5 调用，AppHost 也可以让 native 主动调用此能力。将前后端能力统一。\nb. 操作步骤；\n, 点击顶部的立即下载，此时弹出一个 toast，内容是京东 JSBridge 接口参数。\n 另外这里的 toast 是由 AppHostRespone 的扩展类 HUDResponse 来实现具体功能的，展示灵活的业务扩展能力。\nPS: 通过 AppHost 提供的 debugger，可以看到线上的代码里还有 console.log 日志"
                           },
                           @{@"name":@"加载严选移动端首页，观察其性能参数",
                             @"url": @"https://m.you.163.com",
                             @"desc": @"本用例展示：AppHost 的定制能力和 profile 工具。这次加载的进度条是金色的，颜色是可配置的,当遇到某个请求 302 时，进度条也可以正常显示。\n查看 profile 步骤，运行之后，按照 XCode 日志里的提示(或者点击 App 里右上角一个 AH 样的图标，展开后的日志了有 url，长按复制或者在浏览器输入)，用电脑浏览器打开调试页面，按照提示或者点击左侧快捷菜单、或直接输入 :timing 接口查看"
                             },
                           @{@"name":@"加载严选酒水专题页面，使用 weinre 调试样式",
                             @"url": @"http://m.you.163.com/item/list?categoryId=1005002&style=pd",
                             @"desc":@"本用例展示：AppHost 的扩展能力，可以接入现有的工具，增强调试能力。\n 在命令行里输入，本地启动的 weinre 目标调试脚本，不需要修改目标调试页面即可实现对此页面的调试，而且对后续的所有页面都有效。\n注意：因为浏览器 CSP 的限制 https 的页面无法加载 http 的资源。如果需要调试 https，你可能需要安装 ngrok，输入命令，:weinre https://3c2c9d94.ngrok.io/target/target-script-min.js#anonymous"
                             },
                           @{@"name":@"加载本地文件夹，测试接口参数",
                             @"fileName":@"/index.html",
                             @"dir": @"TestCase",
                             @"domain": @"https://m.you.163.com",
                             @"desc": @"本用例展示：AppHost 加载本地文件夹资源的能力。可以加载 html，以及 html 里引用的相同目录下的 图片资源\\javascript\\css 文件 3 类资源（不支持字体等）。\n如果要加载的主域是 http 的，可以使用嵌套性的资源引用，如 css 文件里引用了一个相对路径的图标。"
                             },
                           @{@"name":@"加载本地页面，可向服务器发 ajax 请求",
                             @"fileName":@"mymt.html",
                             @"desc": @"本地文件向美团的服务器发送请求。因为 Cookie 不对，所以返回错误数据，但是也演示了，是可以正确的发送和接受数据的",
                             @"domain": @"http://i.meituan.com"},
                           nil];
    self.objects = dataSource;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *object = self.objects[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - %@", (long)indexPath.row + 1, [object objectForKey:@"name"]];
    cell.detailTextLabel.text = [object objectForKey:@"desc"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewViewController *vc = [[WebViewViewController alloc] init];
    NSDictionary *object = self.objects[indexPath.row];
    NSString *url = [object objectForKey:@"url"];
    NSString *fileName = [object objectForKey:@"fileName"];
    if (url) {
        vc.url = url;
    } else if(fileName.length > 0){
        NSString *dir = [object objectForKey:@"dir"];
        NSURL * _Nonnull mainURL = [[NSBundle mainBundle] bundleURL];
        NSString* domain = [object objectForKey:@"domain"];
        if (dir.length > 0) {
            NSURL *url = [mainURL URLByAppendingPathComponent:dir];
            [vc loadIndexFile:fileName inDirectory:url domain:domain];
        } else {
            [vc loadLocalFile:[mainURL URLByAppendingPathComponent:fileName] domain:domain];
        }
    }

    [self.navigationController pushViewController:vc animated:YES];
}

@end
