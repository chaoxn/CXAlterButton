# CXAlterButton

## Introduction : 

#####An alterButton you can define it's frame,size,image,direction.
<br>
![dong](http://7xnqnj.com1.z0.glb.clouddn.com/Untitled.gif)

## How to use:

<p>
```#import "CXAlterButton.h"```


create CXAlterButton and CXAlterItemButton
<p>

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


<p>Implement protocol method

```
- (void)AlterButton:(CXAlterButton *)button clickItemButtonAtIndex:(NSUInteger)index
{
    NSLog(@"you clicked  %ld button", index);
}
```
<p>
<p>

