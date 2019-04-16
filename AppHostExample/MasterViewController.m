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
    
    [[AHResponseManager defaultManager] addCustomResponse:HUDResponse.class];
    
    // Do any additional setup after loading the view.
    NSArray *dataSource = [NSArray arrayWithObjects:@{
                                              @"name":@"加载接口示例页面，观察接口调用",@"url": @"http://qian.163.com/act/pub/ZtJm9plcJr.html"
                                              },
                           @{@"name":@"加载复杂页面，观察其性能参数",@"url": @"https://m.you.163.com"},
                           @{@"name":@"加载本地页面，测试接口参数", @"fileName":@"/index.html",@"dir": @"TestCase", @"domain": @"https://m.you.163.com"},
                           @{@"name":@"加载本地页面，向服务方式请求", @"fileName":@"mymt.html",@"domain": @"http://i.meituan.com"},
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
    cell.textLabel.text = [object objectForKey:@"name"];
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
