//
//  main.m
//  sign
//
//  Created by bokeadmin on 8/19/16.
//  Copyright © 2016 bokeadmin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "payArgument.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
#import "getIPAddress.h"
#import "Order.h"
#import "DataSigner.h"
#import "Product.h"

NSString *MD5(NSString *v){
    const char *cStr = [v UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

NSString *genNonceStr() {
    static int kNumber = 15;

    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned) time(0));
    for (int i = 0; i < kNumber; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
NSString * alipaySign(){
    NSString *partner = @"";
    NSString *seller = @"";
//    NSString *privateKey = @"-----BEGIN PRIVATE KEY-----\n"
//            "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALxPLDYJUpJNXwXY\n"
//            "cZIj80mBOUz9rWSe7OeW/WOjhi0AVRFcSoJRAA/R51/UeFOAHxFzLpPjNQhUUP5z\n"
//            "SVNxkAFvEo71pdoDPzwp0wez3OPTBQ/vuQqNiduXApTL9/BJJl3dDL6pE9mcKsi9\n"
//            "yKHU3jogEfqvMTEY7wtRkLxfNKchAgMBAAECgYB6/5/aH9a+VylFES6FjVPg5DZA\n"
//            "UsZKHgCR+K7DwVDn3fqynzzPyAapTqq5jneV2u7wH/MBh/vg1+obecQga+Hp3Zji\n"
//            "zRG0CrRQihZ9RAdgfys81VxvvUeCfuGdRYbIbwDFbuGZ2QmhyiH/+swTlKgEwTix\n"
//            "tZ0S3L6Tgjb1+VqFQQJBAPKVxmd1bAEQUNLtjXSnFZ38EHqz2sRSoS6v9q8Dj9Co\n"
//            "12ItS/C1AvwR/x0Pnz/G1uoA2ZJBh8v5sHa0ks2mgnkCQQDGuQbh+HiabatgnUA/\n"
//            "H2NY7LkNlr3HV6ekUp3hCAdIAzaGaKBmblu+MnRbAnhfYOCa9uBIzyY/rfE4ONzC\n"
//            "5V/pAkEA13ElT+T9EsTGw02uf5eUn0ap7A+njwxDkg886pojM5GAF/VaqGBaUjw5\n"
//            "cjnZmO6jGBfBIx+H1yPeEM62QmZLIQJAAvi5VZ+1jfmd2m//ifIaNjYz/jQG2nhB\n"
//            "FX/2xGquUTFbG19tJpr33Dw86S98RVDZiveuGuieFc2wEbsn8fIkIQJBAPG9su3o\n"
//            "E2c1cqDYXrhJc+O8bm2WqmG1jPA4t1kaw1z+Z78zOaw+hWZB+tZtVoYRzoZh57sy\n"
//            "2DK2rZtAjH3arfM=\n"
//            "-----END PRIVATE KEY-----";
    NSString * privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALxPLDYJUpJNXwXY\n"
            "cZIj80mBOUz9rWSe7OeW/WOjhi0AVRFcSoJRAA/R51/UeFOAHxFzLpPjNQhUUP5z\n"
            "SVNxkAFvEo71pdoDPzwp0wez3OPTBQ/vuQqNiduXApTL9/BJJl3dDL6pE9mcKsi9\n"
            "yKHU3jogEfqvMTEY7wtRkLxfNKchAgMBAAECgYB6/5/aH9a+VylFES6FjVPg5DZA\n"
            "UsZKHgCR+K7DwVDn3fqynzzPyAapTqq5jneV2u7wH/MBh/vg1+obecQga+Hp3Zji\n"
            "zRG0CrRQihZ9RAdgfys81VxvvUeCfuGdRYbIbwDFbuGZ2QmhyiH/+swTlKgEwTix\n"
            "tZ0S3L6Tgjb1+VqFQQJBAPKVxmd1bAEQUNLtjXSnFZ38EHqz2sRSoS6v9q8Dj9Co\n"
            "12ItS/C1AvwR/x0Pnz/G1uoA2ZJBh8v5sHa0ks2mgnkCQQDGuQbh+HiabatgnUA/\n"
            "H2NY7LkNlr3HV6ekUp3hCAdIAzaGaKBmblu+MnRbAnhfYOCa9uBIzyY/rfE4ONzC\n"
            "5V/pAkEA13ElT+T9EsTGw02uf5eUn0ap7A+njwxDkg886pojM5GAF/VaqGBaUjw5\n"
            "cjnZmO6jGBfBIx+H1yPeEM62QmZLIQJAAvi5VZ+1jfmd2m//ifIaNjYz/jQG2nhB\n"
            "FX/2xGquUTFbG19tJpr33Dw86S98RVDZiveuGuieFc2wEbsn8fIkIQJBAPG9su3o\n"
            "E2c1cqDYXrhJc+O8bm2WqmG1jPA4t1kaw1z+Z78zOaw+hWZB+tZtVoYRzoZh57sy\n"
            "2DK2rZtAjH3arfM=";
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;

    //fake product info
    Product *product = [[Product alloc]init];
    product.tradeNo = @"订单ID（由商家自行制定）";
    product.subject = @"商品标题";
    product.body = @"商品标题";
    product.price = 888;

    order.outTradeNO = product.tradeNo; //订单ID（由商家自行制定）
    order.subject = product.subject; //商品标题
    order.body = product.body; //商品标题
    order.totalFee = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL

    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";


    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);

    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    return signedString;
    NSLog(signedString);
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                                 orderSpec, signedString, @"RSA"];
    }
    return @"alipay sign";
}
NSString * wechatSign () {
    //noceStr
    NSString *nonceStr = genNonceStr();
    //IP
    getIP *getip = [[getIP alloc]init];
    NSString *ip = [getip getIPAddress:true];
    //TODO mchId
    payArgument *payargument = [[payArgument alloc]init];
    payargument.appid =             @"wxb4ba3c02aa476ea1";
    payargument.mchId =             @"I am mchId";
    payargument.nonceStr =          nonceStr;
    payargument.body =              @"腾讯充值中心-QQ会员充值";
    payargument.outTradeNo =        @"0603";
    payargument.totalFee =          888;
    payargument.spbillCreateIp =    ip;
    payargument.notifyUrl =         @"http://zhouzhongyuan.com/notiryUrl";
    payargument.tradeType =         @"APP";
    //去除空值
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([payargument class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithUTF8String:property_getName(property)];
        id propertyValue = [payargument valueForKey:(NSString *)propertyName]; //check propertyValue here
        if(propertyValue == nil || [propertyValue isEqual:@0] ){
            continue;
        }
        [dic setValue:propertyValue forKey:propertyName];
    }
    free(properties);
    //ASCII排序
    NSArray *keys = [dic allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    NSString *stringA = @"";
    for (NSString *categoryId in sortedArray) {
        NSString *value =[dic objectForKey:categoryId];
        stringA = [stringA stringByAppendingFormat:@"%@=%@&", categoryId, value];
    }
    stringA = [stringA substringWithRange:NSMakeRange(0, [stringA length]-1)];
//    NSLog(stringA);
    //MD5 && toUpperCase
    stringA = MD5(stringA);
    stringA = [stringA uppercaseString];
    return stringA;
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *sign = wechatSign();
        NSString *aliSign = alipaySign();
        NSLog(@"%@", aliSign);
    }
    return 0;
}

//TODO 参数名错误
