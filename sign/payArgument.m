//
//  payArgument.m
//  sign
//
//  Created by bokeadmin on 8/20/16.
//  Copyright © 2016 bokeadmin. All rights reserved.
//

#import "payArgument.h"

@implementation payArgument
- (NSString *)appid {
    return appid;
}

- (NSString *)mchId {
    return mchId;
}

- (NSString *)nonceStr {
    return nonceStr;
}

- (NSString *)sign {
    return sign;
}

- (NSString *)body {
    return body;
}

- (NSString *)outTradeNo {
    return outTradeNo;
}

- (NSInteger)totalFee {
    return totalFee;
}

- (NSString *)spbillCreateIp {
    return spbillCreateIp;
}

- (NSString *)notifyUrl {
    return notifyUrl;
}

- (NSString *)tradeType {
    return tradeType;
}


- (void)setAppid:        (NSString *)appidValue                 {appid =              appidValue;}
- (void)setMchId:        (NSString *)machIdValue                {mchId =              machIdValue;}
- (void)setNonceStr:     (NSString *)nonceStrValue              {nonceStr =           nonceStrValue;}
- (void)setSign:         (NSString *)signValue                  {sign =               signValue;}
- (void)setBody:         (NSString *)bodyValue                  {body =               bodyValue;}
- (void)setOutTradeNo:   (NSString *)outTradeNoValue            {outTradeNo =         outTradeNoValue;}
- (void)setTotalFee:     (NSString *)totalFeeValue              {totalFee =           totalFeeValue;}
- (void)setSpbillCreateI:(NSString *)spbillCreateIValuep        {spbillCreateIp =     spbillCreateIValuep;}
- (void)setotifyUrl:     (NSString *)notifyUrlValue             {notifyUrl =          notifyUrlValue;}
- (void)settradeType:    (NSString *)tradeTypeValue             {tradeType =          tradeTypeValue;}

@end
