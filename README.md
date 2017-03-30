### 学习剖析YYModel源码

**代码段**

1、强制内联函数

```objective-c
#define force_inline __inline__ __attribute__((always_inline))
// __inline__ 和 __attribute__ 有什么作用？

// __inline__ 表示内联函数，就是把函数的内容拷贝一份放在调用函数的地方，就样就减少了
// 调用函数的进栈出栈的操作时间，但会增加一定的编译后的代码量，一种空间换时间的作法。
// __attribute__((always_inline)) 表示强制内联，__inline__只是通知编译器使用内联的建议
```

[C中\_\_inline\_\_的含义及作用](http://blog.chinaunix.net/uid-30120741-id-4810775.html)

[C语言中内联函数的作用 inline](http://www.voidcn.com/blog/liaoshengshi/article/p-4136320.html)

[神奇的\_\_attribute\_\_](http://www.jianshu.com/p/6153eccdbe62)

2、objc_msgSend直接调用

```objective-c
return @(((bool (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
...
((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, value);

// 这两行代码是什么意思？
// 用clang -rewrite-objc main.m 生成 main.cpp文件中找到 [NSObject foo]; 对应的C++语句
((void (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("foo"));

// (void (*)(id, SEL)) 是函数指针，而后面的(void *)有无都是可以的
// YYModel是把objc_msgSend转为函数指针后直接调用

// objc_msgSend函数定义
id objc_msgSend(id self, SEL op, ...)
// IMP函数指针的定义
typedef id (*IMP)(id, SEL, ...); 
```

[刨根问底 Objective－C Runtime（3）－ 消息 和 Category](http://chun.tips/2014/11/06/objc-runtime-3/)

[动手实现 objc_msgSend](http://blog.cocoabit.com/dong-shou-shi-xian-objc-msgsend/)



3、CF用法

```objective-c
void CFDictionaryApplyFunction(CFDictionaryRef theDict, CFDictionaryApplierFunction CF_NOESCAPE applier, void *context);
void CFArrayApplyFunction(CFArrayRef theArray, CFRange range, CFArrayApplierFunction CF_NOESCAPE applier, void *context);

// 这两个CF方法很重要！
```



4、GDC锁

```objective-c
static dispatch_semaphore_t lock = dispatch_semaphore_create(1);
dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
...
dispatch_semaphore_signal(lock);

// 用dispatch_semaphore_t实现互斥操作
```



5、__unsafe_unretained 修饰符有什么作用？

**它可被用于防止了参数的持有**，可以理解为和assign等同，和weak又略有不一样的地方

[The meaning of __unsafe_unretained?](http://www.jianshu.com/p/0ca31b3e3ac0)



6、位运算

```objective-c
YYEncodingTypeQualifierMask   = 0xFF00,   ///< mask of qualifier
YYEncodingTypeQualifierConst  = 1 << 8,  ///< const 1<< 8 equals 0x0100

YYEncodingType qualifier = 0;
qualifier |= YYEncodingTypeQualifierConst;
// 等同于 qualifier = qualifier | YYEncodingTypeQualifierConst
// 0x0000 | 0x0100 = 0x0100
```

[二、八、十、十六进制转换（图解篇）](http://www.cnblogs.com/gaizai/p/4233780.html)

