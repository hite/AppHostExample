//
//  DescTableViewCell.m
//  AppHostExample
//
//  Created by liang on 2020/1/2.
//  Copyright © 2020 liang. All rights reserved.
//

#import "DescTableViewCell.h"

@interface DescTableViewCell ()

@end

@implementation DescTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.numberOfLines = -1;
        self.detailTextLabel.font = [UIFont systemFontOfSize:16];
        self.detailTextLabel.text = @"这里显示描述，可以多行，支持换行哦。\n,z在🏠写文字看看效果；";
        
        self.textLabel.numberOfLines = -1;
        self.textLabel.font = [UIFont systemFontOfSize:22];
        self.textLabel.textColor = [UIColor blueColor];
        self.textLabel.text = @"这里显示标题";
        
//        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)configureWithTitle:(NSString *)title desc:(NSString *)desc{

    self.textLabel.text = title;
    self.detailTextLabel.text = desc;
}

@end
