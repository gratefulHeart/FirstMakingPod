//
//  ViewController.m
//  HBAlertControllerDemo
//
//  Created by gfy on 2017/5/18.
//  Copyright © 2017年 gfy. All rights reserved.
//

#import "ViewController.h"

#import "HBAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"second" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}

- (void)btnClick{

    [HBAlertController alertControllerShowInViewController:self title:@"提示" message:@"提示框测试" actionName:@[@"取消",@"确定"] handler:^(NSUInteger index) {
    
        if (index == 0) {
            NSLog(@"取消");
        }
        else{
            NSLog(@"确定");
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
