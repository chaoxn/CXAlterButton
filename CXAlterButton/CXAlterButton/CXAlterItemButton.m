//
//  CXAlterItemButton.m
//  CXAlterButton
//
//  Created by chaox on 15/11/2.
//  Copyright © 2015年 chaox. All rights reserved.
//

#import "CXAlterItemButton.h"

@implementation CXAlterItemButton

- (instancetype)initWithImage :(UIImage *)image;
{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, 35, 35);
                
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self addTarget:_delegate action:@selector(itemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
