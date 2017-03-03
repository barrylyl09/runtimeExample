
#Runtime梳理总结
##什么是runtime
runtime是一套比较底层的纯C语言API，属于1个C语言库，包含了很多底层的C语言API。
##runtime对Objective-C影响
Objective-C之所以是一个动态语言，可以动态得创建类和对象、进行消息传递和转发。正因为它拥有`Runtime`这个了不起的库。  

(ps:静态语言：它的数据类型是在编译期间检查的，编写时必须申明所有变量的数据类型)
##runtime核心—消息传递
Objective-C中对象调用某个方法，它不像静态语言，在编译时就已经决定在某块内存中执行函数方法，而是在运行时给obj对象发送一条方法消息，runtime会根据对象能否对这条消息作出响应给出不同处理方式。

因为在编写Objective-C函数调用时，都会被转换成一个C的函数调用:`-objc_msgSend()`  
```oc
例:  
  [person work] => objc_msgSend(person, @selector(work))
```
###消息传递的执行过程
在`runtime.h`头文件中，我们可以看出，OC中的类，对象以及方法其实都是一个C的结构体。

￼
￼

`IMP:即函数指针，为方法具体实现代码块地址`

下面我们通过一个流程图来看看`objc_mgSend`传递过程中做了什么。
以`[obj work]`为例：
￼

####objc_cache作用
流程图这种执行方式效率较低。因为一个class方法列表中的方法，我们可能常常连一半也用不到，而每个消息都需要遍历一边 `objc_method_list` 这样消耗很大 。所以我们使用`objc_cache`,在找到 `method` 之后，把 `method_imp` 对应 `method_name` 利用键值存储起来。下次再接收到 `method` 消息时，可以直接在 `cache` 中查询使用。

##runtime之动态方法解析和消息转发
####如果流程图过程中，我们最终还是没有找到`work_imp`，那么我们的程序将面临崩溃，这时`runtime` 还给我们提供了动态添加方法的补救措施。  
-Runtime提供了三种方式来将原来的方法实现代替掉。  

####1. `Method Resolution:`  当 `Runtime` 系统在Cache和方法分发表中（包括超类）找不到要执行的方法时，`Runtime` 会调用 `resolveInstanceMethod:` 或 `resolveClassMethod:` 来给程序员一次动态添加方法实现的机会。我们需要用 `class_addMethod` 函数完成向特定类添加特定方法实现的操作  
由于`Method Resolution`不能像消息转发那样可以交给其他对象来处理，所以只适用于在原来的类中代替掉。  

```oc
+ (BOOL)resolveInstanceMethod:(SEL)aSEL
{	
	if (aSEL == @selector(method)) {
			class_addMethod([self class], @selector(method), (IMP)method, "v@:");
			return YES;
		}
		return [super resolveInstanceMethod:aSEL];
		
}
```
  
####2. `Fast Forwarding`: 它可以将消息处理转发给其他对象，使用范围更广，不只是限于原来的对象。  

```oc
- (id)forwardingTargetForSelector:(SEL)aSEL
{
    if(aSelector == @selector(method:)){
        return alternateObject;
    }
    return [super forwardingTargetForSelector:aSEL];
}
```  
如果此方法返回nil或self,则会进入消息转发机制(forwardInvocation:);否则将向返回的对象重新发送消息。  

####3. `Normal Forwarding`: 它跟Fast Forwarding一样可以消息转发，但它能通过NSInvocation对象获取更多消息发送的信息，例如：target、selector、arguments和返回值等信息。

```oc
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    newClass *Obj = [newClass new];
    if ([mobile respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:Obj];
    }
}
```

￼

##runtime的一些使用
- 获取类的属性列表  
- 获取类的方法列表  
- 获取类的协议列表  
- 获取类的成员变量列表  
- 改变私有变量的值
- 为一个类增加新方法
- 为类的category 增加新的属性
- 交换方法  
- 自动归档／解档  
