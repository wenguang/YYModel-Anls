//
//  main.m
//  YYModel-Anls
//
//  Created by wenguang pan on 2017/3/28.
//  Copyright © 2017年 wenguang pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

@interface NSObject (Sark)
+ (void)foo;
@end
@implementation NSObject (Sark)
+ (void)foo
{
    NSLog(@"IMP: -[NSObject(Sark) foo]");
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // http://chun.tips/2014/11/06/objc-runtime-3/ (刨根问底 Objective－C Runtime（3）－ 消息 和 Category)
        // 用clang -rewrite-objc main.m 后，以下的对应C++语句
        // ((void (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("foo"));
        // 以下3句是等价的
        [NSObject foo];
        ((void (*)(id, SEL))objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("foo"));
        ((void (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("foo"));
    }
    return 0;
}
