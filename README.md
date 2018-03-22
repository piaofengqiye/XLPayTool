# XLPayTool
iOS支付宝支付和微信支付工具类
最近做支付宝支付时, 发现支付宝的SDK已经更新,新申请的应用需要更新最新的SDK,于是就写个新的工具类(已经在iOS10,11的系统测试完成.
SDK的接入这里就不说了,参照蚂蚁金服的文档;
这里说下我写的工具类的使用![文件结构](https://upload-images.jianshu.io/upload_images/4965226-927950545ffdd813.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#####1, 将导入头文件到pch中```#import "XLAliPayConfig.h"```
#####2, 由于最新的SDK只需要应用的appid和私钥, 因此可在```XLAliPayHandler.m```中修改
#####3, 修改AppDelegate
```
- (BOOL)application:(UIApplication *)application
openURL:(NSURL *)url
sourceApplication:(NSString *)sourceApplication
annotation:(id)annotation {

if ([url.host isEqualToString:@"safepay"]) {
//跳转支付宝钱包进行支付，处理支付结果
[[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
XLAliPayHandler.shared.result = resultDic;
}];
}
return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
if ([url.host isEqualToString:@"safepay"]) {
//跳转支付宝钱包进行支付，处理支付结果
[[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
XLAliPayHandler.shared.result = resultDic;
}];
}
return YES;
}
```
#####4, 使用(支付结果在回调中)
```
Product *product = [Product new];
product.body = @"我是测试数据";
product.subject = @"1";
product.price = 0.01;
[[XLAliPayHandler shared] alipay:product];
[XLAliPayHandler shared].block = ^(NSDictionary *result) {
NSLog(@"%@", result);
};
```
[简书地址](https://www.jianshu.com/p/726a70c1d72b)
