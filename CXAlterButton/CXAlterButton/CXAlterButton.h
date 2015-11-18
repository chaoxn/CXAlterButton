//
//  CXAlterButton.h
//  CXAlterButton
//
//  Created by fizz on 15/11/3.
//  Copyright © 2015年 chaox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXAlterItemButton.h"

typedef NS_ENUM(NSInteger, DirectionType)
{
    DirectionTypeRight = 0,
    DirectionTypeLeft,
    DirectionTypeDown,
    DirectionTypeUp
};

@class CXAlterButton;

@protocol CXAlterButtonDelegate <NSObject>

- (void)AlterButton:(CXAlterButton *)button clickItemButtonAtIndex:(NSUInteger)index;

@end

@interface CXAlterButton : UIView

@property (nonatomic, weak) id <CXAlterButtonDelegate> delegate;

@property (nonatomic, assign) DirectionType directionType;

@property (nonatomic, assign) CGPoint  buttonCenter;

@property (nonatomic, assign) CGSize buttonSize;

@property (nonatomic, assign) float animationDuration;

/**
 *  initMethod
 *
 *  @param centerImage     buttonImage
 *  @param higheLightImage higheLightImage
 *  @param type            DirectionType
 *
 *  @return 
 */
- (instancetype)initWithImage :(UIImage *)centerImage
                highLightImage:(UIImage *)higheLightImage
                     Direction:(DirectionType )type;

- (void)addButtonItems:(NSArray *)itemButton;

@end
