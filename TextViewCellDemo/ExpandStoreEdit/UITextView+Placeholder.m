//
//  UITextView+Placeholder.m
//  ShopAssistant
//
//  Created by Hui Yin on 2018/6/5.
//  Copyright © 2018年 Hui Yin. All rights reserved.
//

#import "UITextView+Placeholder.h"

@implementation UITextView (Placeholder)

-(void)setPlaceholder:(NSString *)placeholdStr placeholdColor:(UIColor *)placeholdColor
{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholdStr;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    placeHolderLabel.font = self.font;
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    
    /*
     [self setValue:(nullable id) forKey:(nonnull NSString *)]
     ps: KVC键值编码，对UITextView的私有属性进行修改
     */
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}

@end
