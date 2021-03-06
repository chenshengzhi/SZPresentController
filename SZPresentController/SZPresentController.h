//
//  SZPresentController.h
//  SZPresentController
//
//  Created by 陈圣治 on 16/5/12.
//  Copyright © 2016年 shengzhichen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SZContentViewPresentedPosition) {
    SZContentViewPresentedPositionBottom,
    SZContentViewPresentedPositionTop,
    SZContentViewPresentedPositionLeft,
    SZContentViewPresentedPositionRight,
    SZContentViewPresentedPositionCenter,
};

typedef NS_ENUM(NSUInteger, SZModalPresentationStyle) {
    SZModalPresentationStyleBottom,
    SZModalPresentationStyleTop,
    SZModalPresentationStyleLeft,
    SZModalPresentationStyleRight,
};

@interface SZPresentController : UIViewController <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

//default 0.4
@property (nonatomic) CGFloat dimViewAlphaWhenPresented;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic) SZContentViewPresentedPosition contentPosition;

@property (nonatomic) SZModalPresentationStyle presentStyle;

@property (nonatomic) SZModalPresentationStyle dismissStyle;

@property (nonatomic, copy) void (^willDismissBlock)(void);
@property (nonatomic, copy) void (^didDismissBlock)(void);;

+ (instancetype)controllerWithContentView:(UIView *)contentView;

- (instancetype)initWithContentView:(UIView *)contentView;

@end
