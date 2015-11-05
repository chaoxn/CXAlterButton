# CXAlterButton

## Introduction : **可以弹出多个子按钮的button**
#####可以自定义按钮的图片位置大小以及字按钮的方向

![dong](http://7xnqnj.com1.z0.glb.clouddn.com/Untitled.gif)

## How to use:

引入头文件<p>
```#import "CXAlterButton.h"```

创建CXAlterButton,并添加到view上<p>

    CXAlterButton *button = [[CXAlterButton alloc]initWithImage:[UIImage imageNamed:@"add"]highLightImage:[UIImage imageNamed:@"add-Highed"] Direction:DirectionTypeDown];
    
    CXAlterItemButton *item1 = [[CXAlterItemButton alloc]initWithImage:[UIImage imageNamed:@"item1"]];
    
    CXAlterItemButton *item2 = [[CXAlterItemButton alloc]initWithImage:[UIImage imageNamed:@"item2"]];
    
    CXAlterItemButton *item3 = [[CXAlterItemButton alloc]initWithImage:[UIImage imageNamed:@"item3"]];
    
    [button addButtonItems:@[item1, item2, item3]];
    
    button.buttonCenter = CGPointMake(self.view.frame.size.width/2-20, 100);
    button.buttonSize = CGSizeMake(40, 40);
    button.animationDuration = 0.5;
    button.delegate = self;
    [self.view addSubview:button];


实现代理<p>

```
- (void)AlterButton:(CXAlterButton *)button clickItemButtonAtIndex:(NSUInteger)index
{
    NSLog(@"you clicked  %ld button", index);
}
```
<p>
<p>
***
 **还有很多不足 会陆续修改commit**
