//
//  getIPAddress.h
//  sign
//
//  Created by bokeadmin on 8/20/16.
//  Copyright © 2016 bokeadmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getIP : NSObject 
- (NSString *) getIPAddress:(BOOL)preferIPv4;
- (NSDictionary *) getIPAddresses;
@end
