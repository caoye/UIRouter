# UIRouter

[![CI Status](http://img.shields.io/travis/“caoye”/UIRouter.svg?style=flat)](https://travis-ci.org/“caoye”/UIRouter)
[![Version](https://img.shields.io/cocoapods/v/UIRouter.svg?style=flat)](http://cocoapods.org/pods/UIRouter)
[![License](https://img.shields.io/cocoapods/l/UIRouter.svg?style=flat)](http://cocoapods.org/pods/UIRouter)
[![Platform](https://img.shields.io/cocoapods/p/UIRouter.svg?style=flat)](http://cocoapods.org/pods/UIRouter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

### 跳转类型 `JumpType`

```
Push,    
Present,
Pop,     
PopRoot,
PopSome,
Dismiss,   
```
	   
	   
### 提供的接口方法

方法名称	 	| 方法描述     						 | 需要参数类型
----------- | ------------------------------ | ------------
JumpType    |跳转类型      	 					| JumpType
fromVC   	 | 从哪个VC跳转  					 |UIViewController *
toVC     	 | 跳转到VC       		  			 | UIViewController *
fromNav 	 | 从哪个NAV跳转（默认为当前页面导航）	 | UINavigationController *
animated	 | 是否有动画，（默认YES） | BOOL
closeWithUrl | 关闭界面   					 | NSString *
getVCFromUrl | 根据URL生成VC   				 | NSString *
deregisterURL| 注销URL  					 | NSString *
handler      |界面跳转完成的回调操作(对应模态界面的回调，push操作不执行)|
 

### 注册URL
```
	+ (void)registerURL {
	 [[UIRouter shareInstance] registerURLPattern:vcOnerac Class:[MineViewControllerOne class] toHandler:^(id param, UINavigationController *nav, JumpType type, UIViewController *fromVC) {
        MineViewControllerOne * toVC = [[MineViewControllerOne alloc] init];
        [self jumpTovc:type nav:nav fromeV:fromVC toVC:toVC];
    }];
	}
```
### 调用注册方法
```
NSArray * moduleArray = @[@"MineModule"];
   for (NSString * moduleString in moduleArray) {
       Class class = NSClassFromString(moduleString);
       if ([class respondsToSelector:@selector(registerURL)]) {
           [class performSelector:@selector(registerURL)
                       withObject:nil];
       }
   }
```


### 打开界面调用

```
self.router.openUrl(@"ichat://work/vcOnerac?name=zhangsan&age=10")
self.router.openUrlWithParam(@"ichat://work/vcOnerac",{@"name":@"zhangsan"});
```		 
 		
### 带回调的调用
```
 [self.router.jump(Present).openUrl(vcTwoarc) handler:^{
      NSLog(@"present 完成");
      }];
```
        
### 关闭界面

```
self.router.closeWithUrl(vcOnerac);
```	 

### 反注册URL 
```
self.router.deregisterURL(vcOnerac);
```

可以用self.router调用，也可以用UIRouter.router去调用，由于用的函数式编程写法，每个方法返回的都是UIRouter的实例，根据跳转类型添加自己需要的方法，但是openUrl方法或者closeWithUrl方法一定要写到最后调用，


## Installation

UIRouter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:


`pod "UIRouter"`


## Author

“caoye”, “1595576349@qq.com”

## License

UIRouter is available under the MIT license. See the LICENSE file for more info.
