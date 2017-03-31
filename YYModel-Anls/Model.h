//
//  Model.h
//  YYModel-Anls
//
//  Created by wenguang pan on 2017/3/30.
//  Copyright © 2017年 wenguang pan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Block)();

@protocol ModelDelegate <NSObject>
- (void)tme;
@end

@interface Model : NSObject
{
    NSObject *_tobj;
}

@property (atomic, assign) BOOL bl1;
@property (nonatomic, assign) BOOL bl2;
@property (nonatomic, assign, readonly) BOOL bl3;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, weak) NSObject *obj;
@property (nonatomic, copy) Block block;
@property (nonatomic, retain) NSDictionary *dic;
@property (nonatomic, readwrite, getter=getTobj) NSObject *customGetObj;
@property (nonatomic, weak) id<ModelDelegate, NSCopying> delegate;

- (NSObject *)getTobj;

@end
