//
//  payArgument.h
//  sign
//
//  Created by bokeadmin on 8/20/16.
//  Copyright © 2016 bokeadmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface payArgument : NSObject

@property NSString *appid;
@property NSString *mchId;
@property NSString *nonceStr;
@property NSString *sign;
@property NSString *body;
@property NSString *outTradeNo;
@property NSInteger totalFee;
@property NSString *spbillCreateIp;
@property NSString *notifyUrl;
@property NSString *tradeType;


@end
