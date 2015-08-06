---
README(Chinese)
==========

## TBNetwork 是什么

TBNetwork 是Teambition iOS 研发团队基于 [AFNetworking]() [YTKNetworking]() 封装的 iOS 网络库 。

## TBNetwork提供了哪些功能

相比 AFNetworking，TBNetwork 提供了以下更高级的功能：

 * 支持检查返回 JSON 内容的合法性
 * 支持批量的网络请求发送，并统一设置它们的回调。
 * 支持方便地设置有相互依赖的网络请求的发送，例如：发送请求A，根据请求A的结果，选择性的发送请求B和C，再根据B和C的结果，选择性的发送请求D。

## TBNetwork适用的版本

TBNetwork 适合稍微复杂一些的项目，不适合个人的小项目。

如果你的项目中需要缓存网络请求、管理多个网络请求之间的依赖、希望检查服务器返回的 JSON 是否合法，那么 TBAPIManager 能给你带来很大的帮助。如果你缓存的网络请求内容需要依赖特定版本号过期，那么 TBAPIManager 就能发挥出它最大的优势。

TBNetwork 支持iOS 7或之后的版本。

## TBNetwork 的基本思想

TBNetwork 的基本的思想是把每一个网络请求封装成对象。所以使用 TBNetwork，你的每一个请求都需要继承`TBAPIManager`类，通过覆盖父类的一些方法来构造指定的网络请求。

把每一个网络请求封装成对象其实是使用了设计模式中的 Command 模式，它有以下好处：

 * 将网络请求与具体的第三方库依赖隔离。
 * 方便在基类中处理公共逻辑，例如据版本号信息就统一在基类中处理。
 * 方便在基类中处理缓存逻辑，以及其它一些公共逻辑。
 * 方便做对象的持久化。

当然，如果说它有什么不好，那就是如果你的工程非常简单，这么写会显得没有直接用 AFNetworking 将请求逻辑写在 Controller 中方便，所以 TBNetwork 并不合适特别简单的项目。

## CocoaPods 支持

你可以在 Podfile 中加入下面一行代码来使用TBNetwork

    pod 'TBNetwork'

## 相关的使用教程和 Demo

 `TBJSONValidator`数据验证，有时候服务端会返回错误的数据数据，这时候就需要进行数据的正确性验证，反正应用因为错误数据而产生的闪退。
 
 ```
 - (NSDictionary *)jsonValidator {
    return @{
             @"errMsg":TBValidatorPredicate.isNotNull,
             @"errNum":TBValidatorPredicate.isNotNull,
             @"retData":@{
                     @"carrier":TBValidatorPredicate.isNotNull,
                     @"province":TBValidatorPredicate.isNotNull,
                     @"telString":TBValidatorPredicate.isNotNull
                     }
             };
}

 ```
 
 子类中实现`jsonValidator`方法

## 作者

TBNetwork 的主要作者是：

* [HarriesChen](https://github.com/mrchenhao)
* [StormXX](https://github.com/StormXX)

## 感谢

TBNetwork 基于 [AFNetworking][AFNetworking] 和 [YTKNetworking][YTKNetworking] 进行开发，感谢他们对开源社区做出的贡献。
感谢[iOS应用架构谈 网络层设计方案](http://casatwy.com/iosying-yong-jia-gou-tan-wang-luo-ceng-she-ji-fang-an.html)

## 协议

TBNetwork 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。

