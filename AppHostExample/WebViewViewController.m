//
//  WebViewViewController.m
//  AppHostExample
//
//  Created by liang on 2019/4/16.
//  Copyright © 2019 liang. All rights reserved.
//

#import "WebViewViewController.h"
#import <AppHost/AppHost.h>

@interface WebViewViewController ()

@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest *request = navigationAction.request;
    //此url解析规则自己定义
    NSString *rurl = [[request URL] absoluteString];
    NSString *kProtocol = @"openapp.jdmobile://virtual?params=";
    if ([rurl hasPrefix:kProtocol]) {
        NSString *param = [rurl stringByReplacingOccurrencesOfString:kProtocol withString:@""];
        
        NSDictionary *contentJSON = nil;
        NSError *contentParseError;
        if (param) {
            param = [self stringDecodeURIComponent:param];
            contentJSON = [NSJSONSerialization JSONObjectWithData:[param dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&contentParseError];
        }
        
        [self callNative:@"toast" parameter:@{
                                              @"text":[contentJSON description]
                                              }];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        [super webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    }
}

- (NSString *)stringDecodeURIComponent:(NSString *)encoded{
    NSString *decoded = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)encoded, CFSTR(""), kCFStringEncodingUTF8);
    //    NSLog(@"decodedString %@", decoded);
    return decoded;
}
@end
