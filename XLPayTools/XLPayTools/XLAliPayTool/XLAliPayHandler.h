//
//  XLAliPayHandler.h
//  XLPayTools
//
//  Created by XL on 2018/3/22.
//  Copyright © 2018年 张博. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AlipayResult)(NSDictionary *result);
@interface Product :NSObject
@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@end

@interface XLAliPayHandler : NSObject
@property (nonatomic, copy) AlipayResult block;
@property (nonatomic, strong) NSDictionary *result;

+ (instancetype)shared;
- (void)alipay:(Product *)product;

@end

