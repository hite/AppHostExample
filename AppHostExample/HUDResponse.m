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

- (void)hideLoading
{
    [self.appHost.view hideToastActivity];
}

- (void)showLoading:(NSDictionary *)paramDict
{
    // display toast with an activity spinner
    [self.appHost.view makeToastActivity:CSToastPositionCenter];
}

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
