//
//  payArgument.h
//  sign
//
//  Created by bokeadmin on 8/20/16.
//  Copyright © 2016 bokeadmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface payArgument : NSObject
{
    NSString * appid;
    NSString * mchId;
    NSString * nonceStr;
    NSString * sign;
    NSString * body;
    NSString * outTradeNo;
    NSInteger  totalFee;
    NSString * spbillCreateIp;
    NSString * notifyUrl;
    NSString * tradeType;
}

-(NSString*) appid;
-(NSString*) mchId;
-(NSString*) nonceStr;
-(NSString*) sign;
-(NSString*) body;
-(NSString*) outTradeNo;
-(NSInteger) totalFee;
-(NSString*) spbillCreateIp;
-(NSString*) notifyUrl;
-(NSString*) tradeType;

-(void) setAppid:           (NSString*) appidValue;
-(void) setMchId:           (NSString*) machIdValue;
-(void) setNonceStr:        (NSString*) nonceStrValue;
-(void) setSign:            (NSString*) signValue;
-(void) setBody:            (NSString*) bodyValue;
-(void) setOutTradeNo:      (NSString*) outTradeNoValue;
-(void) setTotalFee:        (NSInteger) totalFeeValue;
-(void) setSpbillCreateI:   (NSString*) spbillCreateIValuep;
-(void) setotifyUrl:        (NSString*) notifyUrlValue;
-(void) settradeType:       (NSString*) tradeTypeValue;

@end
