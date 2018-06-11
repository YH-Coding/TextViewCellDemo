//
//  YHExpandStoreEditCell.h
//  ShopAssistant
//
//  Created by Hui Yin on 2018/6/4.
//  Copyright © 2018年 Hui Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YHExpandStoreCellType0,
    YHExpandStoreCellType1,
    YHExpandStoreCellType2
}(YHExpandStoreCellType);

@class YHExpandStoreEditCell;
@protocol YHExpandStoreEditCellDelegate <NSObject>

- (void)textView:(YHExpandStoreEditCell *)cell didChangeText:(NSString *)text;

@end

@interface YHExpandStoreEditCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLbl;
@property (strong, nonatomic) UITextView *textView;

@property (weak, nonatomic) id<YHExpandStoreEditCellDelegate> delegate;

@end
