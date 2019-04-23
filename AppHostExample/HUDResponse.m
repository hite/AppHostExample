//
//  HUDResponse.m
//  AppHostExample
//
//  Created by liang on 2019/4/16.
//  Copyright © 2019 liang. All rights reserved.
//

#import "HUDResponse.h"
#import "UIView+Toast.h"

@implementation HUDResponse

+ (NSDictionary<NSString *, NSString *> *)supportActionList
{
    return @{
             @"toast_":@"1",
             @"showLoading_":@"1",
             @"hideLoading":@"1"
             };
}

#pragma mark - override
ah_doc_begin(hideLoading, "隐藏 loading 的 HUD 动画，UIView+Toast实现。")
ah_doc_code(window.appHost.invoke("hideLoading"))
ah_doc_code_expect("在有 loading 动画的情况下，调用此接口，会隐藏 loading。")
ah_doc_end
- (void)hideLoading
{
    [self.appHost.view hideToastActivity];
}
ah_doc_begin(showLoading_, "loading 的 HUD 动画，UIView+Toast实现。")
ah_doc_param(text, "字符串，设置和 loading 动画一起显示的文案")
ah_doc_code(window.appHost.invoke("showLoading",{"text":"请稍等..."}))
ah_doc_code_expect("UIView+Toast 只会在屏幕上出现 loading 动画，不显示文字")
ah_doc_end
- (void)showLoading:(NSDictionary *)paramDict
{
    // display toast with an activity spinner
    [self.appHost.view makeToastActivity:CSToastPositionCenter];
}
ah_doc_begin(toast_, "显示居中的提示，过几秒后消失，UIView+Toast实现。")
ah_doc_param(text, "字符串，显示的文案，可多行")
ah_doc_code(window.appHost.invoke("toast",{"text":"请稍\n等..."}))
ah_doc_code_expect("在屏幕上出现 '请稍等...'，多次调用此接口，会出现多个")
ah_doc_end
- (void)toast:(NSDictionary *)paramDict
{
    CGFloat delay = [[paramDict objectForKey:@"delay"] floatValue];
    [self showTextTip:[paramDict objectForKey:@"text"] delay:delay];
}

- (void)showTextTip:(NSString *)tip delay:(CGFloat)delay
{
    // create a new style
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    
    // this is just one of many style options
    style.messageColor = [UIColor orangeColor];
    
    // present the toast with the new style
    [self.appHost.view makeToast:tip
                duration:delay>0?delay:3
                position:CSToastPositionBottom
                   style:style];
}
@end
