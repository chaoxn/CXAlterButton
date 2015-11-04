//
//  CXAlterButton.m
//  AlterButtonDemo
//
//  Created by fizz on 15/11/2.
//  Copyright © 2015年 chaox. All rights reserved.
//

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#import "CXAlterButton.h"

@interface CXAlterButton()<CXAlterItemButtonDelegate>

@property (strong, nonatomic) UIImage *centerImage;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *keyArr;
@property (nonatomic, strong) UIView *buttonBGView;

@end

@implementation CXAlterButton

#pragma mark- publicMethod
- (instancetype)initWithImage :(UIImage *)centerImage{
    
    if (self = [super init]) {
        
        self.centerImage = centerImage;
        
        self.items = [NSMutableArray array];
        self.keyArr = [NSMutableArray array];

        self.frame = CGRectMake(0, 0,ScreenWidth,ScreenHeight);
        
//        _animationDuration = 0.5;
    
        [self initViews];
    }
    return self;
}

- (void)addButton:(CXAlterItemButton *)button {
    
    assert(button != nil);
    if (self.items == nil) {
        self.items = [[NSMutableArray alloc] init];
    }
    
    if (![self.items containsObject:button]) {
        [self.items addObject:button];
        button.alpha = 0;
        [self addSubview:button];
    }
}

- (void)addButtonItems:(NSArray *)itemButton
{
    assert(itemButton != nil);
    for (CXAlterItemButton *item in itemButton) {
        [self addButton:item];
    }
}

#pragma mark setter&&getter

- (void)setButtonCenter:(CGPoint)buttonCenter
{
    _buttonCenter = buttonCenter;
}

- (void)setButtonSize:(CGSize)buttonSize
{
    _buttonSize = buttonSize;
    self.centerButton.frame = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
    self.buttonBGView.frame = CGRectMake(self.buttonCenter.x, self.buttonCenter.y, buttonSize.width, buttonSize.height);
}

- (void)setAnimationDuration:(float)animationDuration
{
    _animationDuration = animationDuration;
}

- (void)initViews
{
    self.buttonBGView = ({
        UIView *view = [[UIView alloc]initWithFrame:({
            CGRect frame = CGRectMake(0, 0, 40, 40);
            frame;
        })];
        view.backgroundColor = [UIColor clearColor];
        view;
    });
    
    self.centerButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:self.centerImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rollAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 40, 40);
        button;
    });
    [self.buttonBGView addSubview:self.centerButton];
    [self addSubview:self.buttonBGView];
}

- (void)rollAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        [self centerButtonOpen];
    }else{
        
        [self centerButtonClosed];
    }
}

#pragma mark- buttonClicked

// FIXMI:- 展开needFix 
- (void)centerButtonOpen
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];
    [self showAnimatonWithSeleted:M_PI_4];

    for (int i = 0;  i < self.items.count; i++) {
        
        CXAlterItemButton *itemButton = self.items[i];
        itemButton.index = i;
        
        [CATransaction setCompletionBlock:^{
            
//            for (CXAlterItemButton *itemButton in self.items) {
                itemButton.transform = CGAffineTransformIdentity;
                itemButton.alpha = 1;
//            }
         
        }];
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        
        CGPoint originPosition = self.buttonBGView.center;
        CGPoint finalPosition = CGPointMake(self.buttonBGView.center.x, self.buttonBGView.center.y + (i+1)*80);
        
        positionAnimation.duration = _animationDuration;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:originPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
        positionAnimation.beginTime = CACurrentMediaTime() + (0.5/(float)self.items.count * (float)i);
        
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        
        [itemButton.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        
        itemButton.layer.position = finalPosition;

        [CATransaction commit];
    }
}

- (void)closeAnimation
{
     [self showAnimatonWithSeleted:0];
        for (int i = (int)self.items.count - 1; i>=0; i--) {
            
            CXAlterItemButton *button = self.items[i];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 
                                 button.center = self.buttonBGView.center;
                                 button.alpha = 0;
                             }];
                }
}

/**
 *  KeyAnimation
 *
 *  @param i index
 *
 *  @return KeyAnimation
 */
/*
- (CAKeyframeAnimation *)openKeyAnimation:(int)i
{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    NSValue *key = [NSValue valueWithCGPoint:CGPointMake(_buttonBGView.center.x, 300 + (i+1)*100)];
    [self.keyArr addObject:key];
    
    keyframeAnimation.values=[NSArray arrayWithArray:self.keyArr];

    keyframeAnimation.duration=0.5;
    keyframeAnimation.beginTime=CACurrentMediaTime()+(1/(float)self.items.count * (float)i);
    keyframeAnimation.fillMode =kCAFillModeForwards;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return keyframeAnimation;
}
*/

#pragma mark- buttonUnclicked
- (void)centerButtonClosed
{
    [CATransaction begin];
    [self showAnimatonWithSeleted:0];
    [CATransaction setAnimationDuration:_animationDuration];
    
    [CATransaction setCompletionBlock:^{
        
        for (CXAlterItemButton *button in self.items) {
            button.transform = CGAffineTransformIdentity;
            button.alpha = 0;
        }
    }];
    
    for (int i = (int)self.items.count - 1; i>=0; i--) {
        
        CXAlterItemButton *button = self.items[i];
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        
        CGPoint originPosition = button.layer.position;
        CGPoint finalPosition = self.buttonBGView.center;
        
        positionAnimation.duration = _animationDuration;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:originPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
        positionAnimation.beginTime = CACurrentMediaTime() + (_animationDuration/(float)_items.count * (float)i);
        positionAnimation.fillMode = kCAFillModeForwards;
        positionAnimation.removedOnCompletion = NO;
        
        [button.layer addAnimation:positionAnimation forKey:@"positionAnimation"];
        
        button.layer.position = originPosition;

    }
    
    [CATransaction commit];
}

- (void)showAnimatonWithSeleted:(CGFloat)Rotataion
{
    [UIView animateWithDuration:1 delay:0.05 usingSpringWithDamping:0.1 initialSpringVelocity:5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _buttonBGView.transform = CGAffineTransformMakeRotation(Rotataion);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFunction
                     view:(UIView *)theView
{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5;
    animation.type = type;
    animation.subtype = subType;
    
    [self.layer addAnimation:animation forKey:nil];
}

#pragma mark - itemClicked

- (void)itemButtonClicked:(CXAlterItemButton *)itemButton
{
    if ([self.delegate respondsToSelector:@selector(AlterButton:clickItemButtonAtIndex:)]) {
        
        CXAlterItemButton *selectedButton = self.items[itemButton.index];
        
        [UIView animateWithDuration:0.0618f * 3
                         animations:^{
                             selectedButton.transform = CGAffineTransformMakeScale(3, 3);
                             selectedButton.alpha = 0.0f;
                         }];

        for (int i = 0; i < self.items.count; i++) {
            if (i == selectedButton.index) {
                continue;
            }
            CXAlterItemButton *unselectedButton = self.items[i];
            [UIView animateWithDuration:0.0618f * 2
                             animations:^{
                                 unselectedButton.transform = CGAffineTransformMakeScale(0, 0);
                             }];
        }
        
        [self.delegate AlterButton:self clickItemButtonAtIndex:itemButton.index];
        
        self.centerButton.selected = NO;
        
        [self centerButtonClosed];
    }
}

@end
