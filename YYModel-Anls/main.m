//
//  main.m
//  YYModel-Anls
//
//  Created by wenguang pan on 2017/3/28.
//  Copyright © 2017年 wenguang pan. All rights reserved.
//

#import <Foundation/Foundation.h>
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
        
        // 用clang -rewrite-objc main.m 后，以下的对应C++语句
        // ((void (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("foo"));
        [NSObject foo];
    }
    return 0;
}
