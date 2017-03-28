### 学习剖析YYModel源码

**代码段**

```objective-c
#define force_inline __inline__ __attribute__((always_inline))
// __inline__ 和 __attribute__ 有什么作用？
```



```objective-c
return @(((bool (*)(id, SEL))(void *) objc_msgSend)((id)model, meta->_getter));
...
((void (*)(id, SEL, id))(void *) objc_msgSend)((id)model, meta->_setter, value);

// 这行代码是什么意思？
// 用clang -rewrite-objc main.m 生成 main.cpp文件中找到 [NSObject foo]; 对应的C++语句
((void (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("foo"));

//objc_msgSend函数定义
id objc_msgSend(id self, SEL op, ...)
//IMP函数指针的定义
typedef id (*IMP)(id, SEL, ...); 
```



```objective-c
void CFDictionaryApplyFunction(CFDictionaryRef theDict, CFDictionaryApplierFunction CF_NOESCAPE applier, void *context);

// 这个方法很重要！
```



```objective-c
static dispatch_semaphore_t lock = dispatch_semaphore_create(1);
dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
...
dispatch_semaphore_signal(lock);

// 用dispatch_semaphore_t实现互斥操作
```

