//
//  SZDemoViewController.m
//  SZPresentControllerDemo
//
//  Created by 陈圣治 on 16/5/13.
//  Copyright © 2016年 shengzhichen. All rights reserved.
//

#import "SZDemoViewController.h"

@implementation SZDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.contentView.backgroundColor = [UIColor greenColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"test test test" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn sizeToFit];
    btn.center = CGPointMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height/2);
    [self.contentView addSubview:btn];
}

@end
