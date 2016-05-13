//
//  ViewController.m
//  SZPresentControllerDemo
//
//  Created by 陈圣治 on 16/5/13.
//  Copyright © 2016年 shengzhichen. All rights reserved.
//

#import "ViewController.h"
#import "SZPresentController.h"
#import "SZDemoViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *positionSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *presentStyleSeg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dismissStyleSeg;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    _contentView.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
//    SZPresentController *vc = [SZPresentController controllerWithContentView:_contentView];
    SZDemoViewController *vc = [[SZDemoViewController alloc] init];
    vc.contentPosition = (SZContentViewPresentedPosition)(_positionSeg.selectedSegmentIndex);
    vc.presentStyle = (SZModalPresentationStyle)(_presentStyleSeg.selectedSegmentIndex);
    vc.dismissStyle = (SZModalPresentationStyle)(_dismissStyleSeg.selectedSegmentIndex);
    [self presentViewController:vc animated:YES completion:nil];
}

@end
