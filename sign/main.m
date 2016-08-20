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
NSString *MD5(NSString *v){
    const char *cStr = [v UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}
NSString * wechatSign () {
    payArgument *payargument = [[payArgument alloc]init];
    payargument.appid =             @"I am appid";
    payargument.mchId =             @"I am mchId";
    payargument.nonceStr =          @"I am nonceStr";
    payargument.sign =              @"I am sign";
    payargument.body =              @"I am body";
    payargument.outTradeNo =        @"I am outTradeNo";
    payargument.totalFee =          888;
    payargument.spbillCreateIp =    @"I am spbillCreateIp";
    payargument.notifyUrl =         @"I am notifyUrl";
    payargument.tradeType =         @"I am tradeType";
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
    //MD5 && toUpperCase
    stringA = MD5(stringA);
    stringA = [stringA uppercaseString];
    return stringA;
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *sign = wechatSign();
        NSLog(@"%@", sign);
    }
    return 0;
}
