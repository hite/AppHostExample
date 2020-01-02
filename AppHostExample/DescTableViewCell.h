//
//  DescTableViewCell.h
//  AppHostExample
//
//  Created by liang on 2020/1/2.
//  Copyright © 2020 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DescTableViewCell : UITableViewCell

- (void)configureWithTitle:(NSString *)title desc:(NSString *)desc;

@end

NS_ASSUME_NONNULL_END
