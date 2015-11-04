//
//  ViewController.m
//  CXAlterButton
//
//  Created by fizz on 15/11/4.
//  Copyright © 2015年 chaox. All rights reserved.
//

#import "ViewController.h"
#import "CXAlterButton.h"
#import "CXAlterItemButton.h"

@interface ViewController ()<CXAlterButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    CXAlterButton *button = [[CXAlterButton alloc]initWithImage:[UIImage imageNamed:@"jian"]];
    
    CXAlterItemButton *item1 = [[CXAlterItemButton alloc]initWithImage:[UIImage imageNamed:@"item1"]];
    
    CXAlterItemButton *item2 = [[CXAlterItemButton alloc]initWithImage:[UIImage imageNamed:@"item2"]];
    
    CXAlterItemButton *item3 = [[CXAlterItemButton alloc]initWithImage:[UIImage imageNamed:@"item3"]];
    
    [button addButtonItems:@[item1, item2, item3]];
    
    button.buttonCenter = CGPointMake(100, 200);
    button.buttonSize = CGSizeMake(35, 35);
    button.animationDuration = 0.5;
    button.delegate = self;
    [self.view addSubview:button];
}

- (void)AlterButton:(CXAlterButton *)button clickItemButtonAtIndex:(NSUInteger)index
{
    NSLog(@"you clicked  %ld button", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
