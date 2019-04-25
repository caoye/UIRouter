# ArchLogger

[![CI Status](http://img.shields.io/travis/王正一/ArchLogger.svg?style=flat)](https://travis-ci.org/王正一/ArchLogger)
[![Version](https://img.shields.io/cocoapods/v/ArchLogger.svg?style=flat)](http://cocoapods.org/pods/ArchLogger)
[![License](https://img.shields.io/cocoapods/l/ArchLogger.svg?style=flat)](http://cocoapods.org/pods/ArchLogger)
[![Platform](https://img.shields.io/cocoapods/p/ArchLogger.svg?style=flat)](http://cocoapods.org/pods/ArchLogger)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

ArchLogger is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ArchLogger"
```

## Requirements

与其他日志输出框架一样,使用此日志框架,需要在mac上安装[XcodeColors](https://github.com/DeepIT/XcodeColors)插件,否则输出的日志不带颜色.

## Usage

在需要使用的控制器中导入`MXLog.h`,或者在`.pch`文件中导入即可全局使用.

在AppDelegate中添加如下代码,使用默认配置(如果不手动设置,则自动使用默认配置),或者根据已有的类方法配置其属性,亦或者给`MXLogConfig`这个配置类的属性赋值,来个性化定制功能:
```
// 默认配置
[MXLogTool configMXLogWithConfiguration:[MXLogConfig defaultConfiguration]];

// 配置输出等级,是否本地保存以及是否开启调试辅助视图
MXLogConfig *config = [MXLogConfig configWithLogLevel:MXLogLevelVerbose andLocalSave:YES debugView:YES];
[MXLogTool configMXLogWithConfiguration:config];

// 自定义输出配置
MXLogConfig *config = [[MXLogConfig alloc] init];
config.shownLevel = MXLogLevelWarning;
config.autoClearInterval = 7;
...
[MXLogTool configMXLogWithConfiguration:config];
```

日志输出:
在需要日志输出时,键入下列方法即可实现日志分级输出:
```
// 全部输出(灰色)
MXLog(...);
// 信息输出(灰色不输出)
MXLogInfo(...);
// 警告输出(只输出黄色警告和红色Error)
MXLogWarn(...);
// 错误输出(只输出红色)
MXLogError(...);
```

唤起辅助输出窗口的方式:在keyWindow连续点击屏幕三次.

## Author

王正一, fsymbio@icloud.com

## License

ArchLogger is available under the MIT license. See the LICENSE file for more info.
