iOS动画简介
------------

# 关于动画
# UIView动画
UIView动画比较简单，用起来也比较简单。所以它能实现的功能还是有限的，但是一般的开发中是够用的。UIView动画是封装自CoreAnimation的，下面会讲到。

![](http://wx2.sinaimg.cn/mw690/acbce940gy1fgqnguclefg20fo0oqe83.gif)

## 基本动画
* 常规用法begin commit代码段

```
// 第一个参数：动画的标识
    // 第二个参数：附加参数，会发送给动画代理，一般设置为nil就可以了
    [UIView beginAnimations:@"test" context:nil];
    // 动画执行时间
    [UIView setAnimationDuration:kAnimationDuration];
    // 设置动画延迟执行时间，默认为0，一般不用设置
    [UIView setAnimationDelay:0];
    // 动画重复次数
    [UIView setAnimationRepeatCount:1];
    // 动画是否原路返回
    [UIView setAnimationRepeatAutoreverses:NO];
    
    // 要先设置这个代理，后面设置代理方法才会有效果
    [UIView setAnimationDelegate:self];
    // 这里的方法也可以是其它的任何方法,如果是这个标准的代理方法，可以不用设置，只设置代理就会执行这个方法
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    // 动画的时间曲线
    /*UIViewAnimationCurve的枚举值如下：
      UIViewAnimationCurveEaseInOut,//慢进慢出（默认值）
      UIViewAnimationCurveEaseIn,//慢进
      UIViewAnimationCurveEaseOut,//慢出
      UIViewAnimationCurveLinear//匀速
     */
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    // 要执行的view的变化
    self.aniView.backgroundColor = [UIColor purpleColor];
    self.aniView.frame = CGRectMake(200, 80, 100, 100);
    // 提交动画执行
    [UIView commitAnimations];
```

* Block用法

```
// iOS4以后有了block形式的动画，可以更方便的组织代码
    // 只设置动画时间，要执行的变化
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.aniView.backgroundColor = [UIColor purpleColor];
        self.aniView.frame = CGRectMake(200, 80, 100, 100);
    }];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
    } completion:^(BOOL finished) {
        // 动画执行完后的回调
    }];
    
    
    // options 可以设置多个。
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.aniView.backgroundColor = [UIColor purpleColor];
        self.aniView.frame = CGRectMake(200, 80, 100, 100);
    } completion:^(BOOL finished) {
        NSLog(@"动画执行完了");
    }];
```

## Spring动画（带弹簧效果）
iOS7 以后引入的Spring动画，iOS8的时候Apple开放的Spring动画的API，开发者可以借助这个API很简单的实现带有弹簧的动画效果了。

用法：

```
[UIView animateWithDuration:kAnimationDuration // 动画持续时间
                          delay:0 // 动画延迟执行的时间
         usingSpringWithDamping:0.2 // 震动效果，范围0~1，数值越小震动效果越明显
          initialSpringVelocity:10 // 初始速度，数值越大初始速度越快
                        options:UIViewAnimationOptionCurveEaseIn // 动画的过渡效果
                     animations:^{
                         //执行的动画
                         self.aniView.backgroundColor = [UIColor purpleColor];
                         self.aniView.frame = CGRectMake(200, 80, 100, 100);
                     }
                     completion:^(BOOL finished) {
                         // 动画执行完后的回调
                     }];            
```


# Core Animation动画
Core Animation翻译过来就是核心动画，它是iOS平台和MAC OS平台动画的核心组件。上面的UIView动画就是封装自Core Animation。它有一组非常强大的API，可以实现各种各样炫酷的动画效果。在日常开发中，一般的动画效果都可以用UIView层封装好的动画实现，但是有一些动画还是得用Core Animation来实现，例如：一些复杂的直播动画效果、自定义一些圆形进度条、一些路径类的自定义view等。

CAAnimation 的动画是作用在layer上，每个view在创建时，会默认创建一个用于显示的layer。所以要熟练运用Core Animation 必须对CALayer有一定的了解，下面这张图(网上盗的)是CALayer的一些属性。

![](http://wx1.sinaimg.cn/mw690/acbce940gy1fgqgn7ugggj20lr0nxq71.jpg)

## 类结构
Core Animation中开发直接用到的动画类就两个`CABasicAnimation``CAKeyFrameAnimation`,下面是Core Animation的类结构图：

![](http://wx2.sinaimg.cn/mw690/acbce940gy1fgqdpebs9zj20yg0n4wha.jpg)

**CAAnimation** 的一些属性，子类会用到：

* **timingFunction** 动画速度
     - kCAMediaTimingFunctionLinear  线性，匀速
     - kCAMediaTimingFunctionEaseIn  渐进，逐渐进入，然后加速完成
     - kCAMediaTimingFunctionEaseOut 渐出，动画全速进入，然后缓慢完成
     - kCAMediaTimingFunctionEaseInEaseOut  渐进渐出
* **removedOnCompletion** 默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode

**CAMediaTiming**协议 相关属性：

* **beginTime**   动画的开始时间（如果超过的duration，那么动画不会开始）
* **duration**    动画的持续时间
* **speed**       动画的速度
* **repeatCount** 重复次数，默认为0，无限重复可以设置为HUGE_VALF或者MAXFLOAT
* **repeatDuration** 动画重复时间，默认为0
* **fillMode**     决定当前对象在非active时间段的行为。（要想fillMode有效，最好设置removedOnCompletion = NO）
* fillMode类型：
     - kCAFillModeRemoved     这个是默认值，也就是说当动画开始前和动画结束后，动画对layer都没有影响，动画结束后，layer会恢复到之前的状态
     - kCAFillModeForwards    当动画结束后，layer会一直保持着动画最后的状态
     - kCAFillModeBackwards   在动画开始前，只需要将动画加入了一个layer，layer便立即进入动画的初始状态并等待动画开始。
     - kCAFillModeBoth        这个其实就是上面两个的合成,动画加入后开始之前，layer便处于动画初始状态，动画结束后layer保持动画最后的状态

**CAPropertyAnimation** 这是一个抽象类，不能直接使用，要实现动画，一般用它的两个子类，相关属性：

* **keyPath**	指定接收层动画的关键路径（入门篇提供了部分keyPath，敬请参考）
* **cumulative**	下一次动画执行是否接着刚才的动画，默认为false
* **additive**	如何处理多个动画在同一时间段执行的结果，若为true，同一时间段的动画合成为一个动画，默认为false。（使用 * CAKeyframeAnimation 时必须将该属性指定为 true ，否则不会出现期待的结果）

## CABasicAnimation(基础动画)

![](http://wx1.sinaimg.cn/mw690/acbce940gy1fgqngnvxl7g20fo0ksdss.gif)

![](http://wx3.sinaimg.cn/mw690/acbce940gy1fgqo76af3dg20fo0dcdlc.gif)

相关属性：

* **fromValue**   开始的值
* **toValue**     结束时的值
* **byValue**     动画过程中的值

关于这三个属性的设置有如下几种结果：

* 设置fromValue和toValue，keyPath属性值在fromValue与toValue之间渐变
* 设置fromValue和byValue，keyPath属性值在fromValue与(fromValue+byValue)之间渐变
* 设置byValue和toValue，keyPath属性值在(toValue-byValue)与toValue之间渐变
* 只设置fromValue，keyPath属性值在fromValue与图层对应当前值之间渐变
* 只设置toValue，keyPath属性值在图层对应当前值与toValue之间渐变
* 只设置byValue，keyPath属性值在图层对应当前值与(图层对应当前值+toValue)之间渐变


> NOTICE: 为了防止冲突，在指定了toValue时不需要byValue、而指定了byValue也不需要指定toValue。
> value的值可以设置为CATransform3D的对象，实现3D动画效果！

## CAKeyFrameAnimation

示例：

![](http://wx2.sinaimg.cn/mw690/acbce940gy1fgqohgz9dmg209006y0tg.gif)

相关属性：

* **values**  存放“关键帧”，动画会一次到达关键帧指定的值，并自动生成中间动画。
* **path**    路径，可以设置一个CGPathRef的路径，让图层按照路径移动，因此只对anchorPosition和position起作用，当设置了path会忽略掉values中的值。
* **keyTimes** 指定到达每个关键帧的时间，与values对应，不设置就是平分。
* **timingFunctions**  指定到达每一帧的速度，度values对应，可以不设置。

## CATransition

![](http://wx4.sinaimg.cn/mw690/acbce940gy1fgu1rydlkrg20aa0j6dvq.gif)

属性：

* **type**        动画的类型
* **subtype**     动画过度方向（可自行查看相关字符串）

type的类型：

* 基本效果

  - kCATransitionFade        渐入渐出效果
  - kCATransitionMoveIn      移入效果
  - kCATransitionPush        推入效果
  - kCATransitionReveal      截开效果

* 私有API(可安全使用):

  - cube                   方块
  - suckEffect             三角
  - rippleEffect           水波
  - pageCurl               上翻页
  - pageUnCurl             下翻页
  - oglFlip                上下翻转
  - cameralrisHollowOpen      镜头快门开
  - cameralrisHollowClose     镜头快门关

## CAAnimationGroup
* **animations**
数组，里面存放动画（动画可以是，基本动画、关键帧动画等其他动画）里面存放的动画可以不设置时间和重复次数，统一在CAAnimationGrop对象中设置。数组中动画的duration可以单独设置，还可以设置数组中动画的开始时间，来控制动画单个动画在组动画中的执行时间，但是时间不能超过组动画的时间，如果超过，该动画不会执行。
