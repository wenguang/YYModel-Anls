//
//  main.m
//  YYModel-Anls
//
//  Created by wenguang pan on 2017/3/28.
//  Copyright © 2017年 wenguang pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "Model.h"

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
        
        
        //位运算
        NSUInteger q = 0;
        NSUInteger c = 1 << 8;  // c equals 0x0100 256
        q |= c; // equals q = 0x0000 | 0x0100;
        NSLog(@"%lu", (unsigned long)c);
        
        //类型编码
        // https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList([Model class], &count);
        for (int i=0; i<count; i++) {
            objc_property_t property = properties[i];
            const char *name = property_getName(property);
            const char *typeEncoding = property_getAttributes(property);
            NSLog(@"%@ : %@", [NSString stringWithCString:name encoding:NSUTF8StringEncoding], [NSString stringWithCString:typeEncoding encoding:NSUTF8StringEncoding]);
            
            unsigned int ac;
            objc_property_attribute_t *attributes = property_copyAttributeList(property, &ac);
            for (int j=0; j<ac; j++) {
                NSLog(@"%s : %s", attributes[j].name, attributes[j].value);
            }
        }
    }
    return 0;
}
