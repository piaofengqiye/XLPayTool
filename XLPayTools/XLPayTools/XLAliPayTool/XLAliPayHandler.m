//
//  XLAliPayHandler.m
//  XLPayTools
//
//  Created by XL on 2018/3/22.
//  Copyright © 2018年 张博. All rights reserved.
//


#define XLAliPay_APPKey     @"2018020902165789"
#define XLRSA2_PrivateKey   @"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCNl6J2r5BBG5PdJXunLNQMI/kVNsPXJPaCY0cJ4pRs/jxZpXi61iRMczg9Y+ivMpDNYgCt5oyMq+Eug+arHjOCRiNXVQYJ2baQlDswLqaXKmdicQjAC+qCuVJck8zTrfsQhIsi1AMT/0eE8+6vD1qBDvHHPz/2RLmHO2coccPUSUGXAn86pXO5a3k0bhA+38+kUb8sG28lROPB8zq1Rc5x/sFy3GCk0WhpB9klGIjzYq0zAHxepht/pFOKDHy7CNkj2ve65iVNT9grVUV12pEx4hm8aT7UAugnhWfXKQYhgdxckkD475Ll3mWgDM5D4Ja8v0+f4QzHAzsPWd8LAgmfAgMBAAECggEAKgPf4qYQATHku4+e1KmZtoyKIgBhNpsyRticwNMqRflfAR7350EZ/lGGU7ks16gCjd9R4khyVl++byYWsZpBoJudaxHAu/WNlfNWaOK+7kZX7T8rYIloqifBx9TXx8xtnqYl/0y4KRvsJgiYP/wnV/qORhh/q10TTIyU/MxdVsWAH10gK+YHvuPJdLSoYPGhqq1CBf48bRr+8vLCY4XKmSqtENm/H2a6bkssviaKB+inJc+XKfde8TyXX/F0iegvbrlYYD2dzUUBCdcjkBX+2KHvHbZ3ku6OfaJO9EYCFC1lxWRUblKi74X/TG/f3zmFvagctlVntFnLxHo4RloAIQKBgQDZoXf/hUVsw1YbfkiyT5wybJdyM1u0n/t81tOqMIbETI01jaxmU1kcqnBV3pNooc5sZ680zqsTvHCxy0e+4jVDXdkWA9xeXguKlRgDppReXoHScxMA58BK+d7fBoMPUrFu5HHF+PeIKvj/fso2uSwu5NTjV95Hi09vYVqNmzL5EQKBgQCmjkDMwck9CjsCsHHIYkO5fWfbzC943gvBHmn9P9SWZVnf40E5FQk4a2My2jdZ3Z8qUTLbn6OBEuOxKpVzQUytEy10AwVTvPTk1HaN+ThxbOJa58wYYxpaWv1sEgVpWGJ7khW9sXVBG76RSfX8llYjiHx1mHRSjUKBO9blEDVXrwKBgCZe/MxVkBcMHct9KY4e0ThmwxEEkx+2sV2idvFj2u8TXDZcA1CLU4PlXScWtkDVfpLIeTDDW5CAQhJm+ABk2+VDz7m89obA6CIIBZLnNPOqkBMt7OTU96eAhNYnzMXP267kola4fdRJV1uc3ERnw62E9TAcVvmgS2Ik9RVQjt0xAoGBAIZsFvZqjFz8TcYM27grPpeNE+58K/Az3W6+ejJPeubq449jnXdReACWAxi+r5+S02vW3uIMRGze7u9E/BtqH1UsPin8aic8QLYSl6Bb/ObmRwWxQLKKAXHdL90x6jYshEdRDsTrXUPv/WzLMYHrX5gMBs7t/SvHIF6nCfgTjcm3AoGAZJ3Aa9N+83a6Uxdk1PdCT2UVRma6yPQ0cM5lDTst8S5GgTxIxot77wvhgCDKO0d0BoYiBnXk2ffHvyKYA5TD70JyM+Sb9meaqchWRPX48+2IFlyWwDX3yvLhMV00RNPq1Z5zi8UbAcUVl0dOB5vs27wb9pRzyqWR8JvWXOtfS2I="
#define notiBack_URL    @"https://www.baidu.com"

#import "XLAliPayHandler.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"

@implementation Product

@end

@implementation XLAliPayHandler
+ (instancetype)shared {
    return [[self alloc] init];
}

static XLAliPayHandler *_instanceHandler;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instanceHandler = [super allocWithZone:zone];
        
    });
    return _instanceHandler;
}
- (void)alipay:(Product *)product{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = XLAliPay_APPKey;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = @"RSA2";
    // 回调地址
    order.notify_url = notiBack_URL;
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = product.body;
    order.biz_content.subject = product.subject;
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", product.price]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
//    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:XLRSA2_PrivateKey];
    signedString = [signer signString:orderInfo withRSA2:YES];
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
           XLAliPayHandler.shared.result = resultDic;
        }];
    }
}

- (void)setResult:(NSDictionary *)result {
    _result = result;
    if (self.block) {
        self.block(_result);
    }
}

#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
@end



