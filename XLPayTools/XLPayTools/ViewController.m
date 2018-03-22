//
//  ViewController.m
//  XLPayTools
//
//  Created by XL on 2018/3/22.
//  Copyright © 2018年 张博. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)wxPay:(id)sender {
}
- (IBAction)aliPay:(id)sender {
    Product *product = [Product new];
    product.body = @"我是测试数据";
    product.subject = @"1";
    product.price = 0.01;
    [[XLAliPayHandler shared] alipay:product];
    [XLAliPayHandler shared].block = ^(NSDictionary *result) {
        NSLog(@"%@", result);
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
