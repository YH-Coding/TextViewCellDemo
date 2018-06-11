//
//  UIView+Category.m
//  ZR_fpt_iPhone
//
//  Created by Apple on 15/10/9.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)
- (void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}
- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWide:(CGFloat)wide{
    CGRect rect = self.frame;
    rect.size.width = wide;
    self.frame = rect;
}
- (CGFloat)wide{
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)setOrign:(CGPoint)orign{
    CGRect rect = self.frame;
    rect.origin = orign;
    self.frame = rect;
}
- (CGPoint)orign{
    return self.frame.origin;
}

- (CGPoint) bottomRight

{
    
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    
    return CGPointMake(x, y);
    
}



- (CGPoint) bottomLeft

{
    
    CGFloat x = self.frame.origin.x;
    
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    
    return CGPointMake(x, y);
    
}



- (CGPoint) topRight

{
    
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    
    CGFloat y = self.frame.origin.y;
    
    return CGPointMake(x, y);
    
}

- (CGFloat) top

{
    
    return self.frame.origin.y;
    
}



- (void) setTop: (CGFloat) newtop

{
    
    CGRect newframe = self.frame;
    
    newframe.origin.y = newtop;
    
    self.frame = newframe;
    
}



- (CGFloat) left

{
    
    return self.frame.origin.x;
    
}



- (void) setLeft: (CGFloat) newleft

{
    
    CGRect newframe = self.frame;
    
    newframe.origin.x = newleft;
    
    self.frame = newframe;
    
}



- (CGFloat) bottom

{
    
    return self.frame.origin.y + self.frame.size.height;
    
}



- (void) setBottom: (CGFloat) newbottom

{
    
    CGRect newframe = self.frame;
    
    newframe.origin.y = newbottom - self.frame.size.height;
    
    self.frame = newframe;
    
}



- (CGFloat) right

{
    
    return self.frame.origin.x + self.frame.size.width;
    
}



- (void) setRight: (CGFloat) newright

{
    
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    
    CGRect newframe = self.frame;
    
    newframe.origin.x += delta ;
    
    self.frame = newframe;
    
}

@end
