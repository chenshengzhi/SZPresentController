//
//  SZPresentController.m
//  SZPresentController
//
//  Created by 陈圣治 on 16/5/12.
//  Copyright © 2016年 shengzhichen. All rights reserved.
//

#import "SZPresentController.h"

@interface SZPresentController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *dimView;

@property (nonatomic) BOOL isPresent;

@end


@implementation SZPresentController

+ (instancetype)controllerWithContentView:(UIView *)contentView {
    SZPresentController *vc = [[SZPresentController alloc] init];
    vc.contentView = contentView;
    return vc;
}

- (instancetype)initWithContentView:(UIView *)contentView {
    if (self = [super init]) {
        // should be set here, or will not work correctly
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.contentView = contentView;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        // should be set here, or will not work correctly
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];

    _dimView = [[UIView alloc] initWithFrame:self.view.bounds];
    _dimView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_dimView];

    if (_contentView) {
        [self.view addSubview:_contentView];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _dimView.frame = self.view.bounds;
    self.contentView.frame = [self contentViewPresentedFrame];
}

- (void)tapHandler:(UITapGestureRecognizer *)gesture {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setters -
- (void)setContentView:(UIView *)contentView {
    if (_contentView != contentView) {
        if (_contentView) {
            [_contentView removeFromSuperview];
        }
        _contentView = contentView;
        if ([self isViewLoaded]) {
            [self.view addSubview:_contentView];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint point = [touch locationInView:self.view];
    if (CGRectContainsPoint(_contentView.frame, point)) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate -
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _isPresent = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _isPresent = NO;
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning -
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *transitionContainerView = [transitionContext containerView];
    
    if (self.isPresent) {
        self.view.frame = [transitionContext finalFrameForViewController:self];
        [transitionContainerView addSubview:self.view];
        
        self.dimView.alpha = 0;
        self.contentView.frame = [self contentViewWillPresentFrame];
        
        CGRect presentedFrame = [self contentViewPresentedFrame];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.dimView.alpha = 0.4;
            self.contentView.frame = presentedFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        if (self.willDismissBlock) {
            self.willDismissBlock();
        }
        
        CGRect dismissedFrame = [self contentViewDismissedFrame];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.dimView.alpha = 0;
            self.contentView.frame = dismissedFrame;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            [transitionContext completeTransition:YES];
            
            if (self.didDismissBlock) {
                self.didDismissBlock();
            }
        }];
    }
}

#pragma mark - content view frame -
- (CGRect)contentViewPresentedFrame {
    CGRect frame = self.contentView.frame;
    switch (_contentPosition) {
        case SZContentViewPresentedPositionBottom: {
            frame.origin.x = self.view.frame.size.width/2 - frame.size.width/2;
            frame.origin.y = self.view.frame.size.height - frame.size.height;
            return frame;
        }
        case SZContentViewPresentedPositionTop: {
            frame.origin.x = self.view.frame.size.width/2 - frame.size.width/2;
            frame.origin.y = 0;
            return frame;
        }
        case SZContentViewPresentedPositionLeft: {
            frame.origin.x = 0;
            frame.origin.y = self.view.frame.size.height/2 - frame.size.height/2;
            return frame;
        }
        case SZContentViewPresentedPositionRight: {
            frame.origin.x = self.view.frame.size.width - frame.size.width;
            frame.origin.y = self.view.frame.size.height/2 - frame.size.height/2;
            return frame;
        }
        case SZContentViewPresentedPositionCenter: {
            frame.origin.x = self.view.frame.size.width/2 - frame.size.width/2;
            frame.origin.y = self.view.frame.size.height/2 - frame.size.height/2;
            return frame;
        }
    }
}

- (CGRect)contentViewUnvisiableFrameForStyle:(SZModalPresentationStyle)style {
    CGRect frame = self.contentView.frame;
    switch (style) {
        case SZModalPresentationStyleBottom: {
            frame.origin.x = [self contentViewPresentedFrame].origin.x;
            frame.origin.y = self.view.frame.size.height;
            return frame;
        }
        case SZModalPresentationStyleTop: {
            frame.origin.x = [self contentViewPresentedFrame].origin.x;
            frame.origin.y = -frame.size.height;
            return frame;
        }
        case SZModalPresentationStyleLeft: {
            frame.origin.x = -frame.size.width;
            frame.origin.y = [self contentViewPresentedFrame].origin.y;
            return frame;
        }
        case SZModalPresentationStyleRight: {
            frame.origin.x = self.view.frame.size.width + frame.size.width;
            frame.origin.y = [self contentViewPresentedFrame].origin.y;
            return frame;
        }
    }
}

- (CGRect)contentViewWillPresentFrame {
    return [self contentViewUnvisiableFrameForStyle:_presentStyle];
}

- (CGRect)contentViewDismissedFrame {
    return [self contentViewUnvisiableFrameForStyle:_dismissStyle];
}

@end
