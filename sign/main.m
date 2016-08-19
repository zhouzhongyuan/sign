//
//  main.m
//  sign
//
//  Created by bokeadmin on 8/19/16.
//  Copyright © 2016 bokeadmin. All rights reserved.
//

#import <Foundation/Foundation.h>


NSString * wechatSign () {
    return @"test";
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *sign = wechatSign();
        NSLog(@"%@", sign);
        
    }
    return 0;
}
