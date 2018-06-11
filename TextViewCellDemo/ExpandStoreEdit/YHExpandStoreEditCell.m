//
//  YHExpandStoreEditCell.m
//  ShopAssistant
//
//  Created by Hui Yin on 2018/6/4.
//  Copyright © 2018年 Hui Yin. All rights reserved.
//

#import "YHExpandStoreEditCell.h"
#import "UITextView+Placeholder.h"
#import "Masonry.h"
#import "UIView+Category.h"

#define SWIDTH     [UIScreen mainScreen].bounds.size.width
#define SHEIGHT     [UIScreen mainScreen].bounds.size.height

@interface YHExpandStoreEditCell () <UITextViewDelegate>


@end

@implementation YHExpandStoreEditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self prepare];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addNotificationKeyBoard];
    }
    
    return self;
}

-(void)addNotificationKeyBoard{
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyBoardShow:)
                                                name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyBoardHidden:)
                                                name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)prepare {
    
    UILabel *titleLbl = [[UILabel alloc] init];
    
    titleLbl.font = [UIFont systemFontOfSize:14];
    titleLbl.textColor = [UIColor lightGrayColor];
    _titleLbl = titleLbl;
    [self addSubview:titleLbl];
    
    UITextView *textView = [[UITextView alloc] init];
    
    textView.scrollEnabled = NO;
    textView.font = [UIFont systemFontOfSize:15];
    textView.textColor = [UIColor darkGrayColor];
    textView.delegate = self;
    [textView setPlaceholder:@"请输入" placeholdColor:nil];
    _textView = textView;
    [self addSubview:textView];
    
    UIView *lineView = [[UIView alloc] init];
    
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo((100));
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLbl.mas_right).offset(10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.right.equalTo(self).mas_offset((-20));
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

// 获取tableView
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

#pragma mark  - textView delegate
- (void)textViewDidChange:(UITextView *)textView {
    // 通过代理 保存textView的内容,确保不被复用
    if ([self.delegate respondsToSelector:@selector(textView:didChangeText:)]) {
        [self.delegate textView:self didChangeText:textView.text];
    }
    CGRect bounds  = textView.bounds;
    CGRect oldBounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    bounds.size = newSize;
    textView.bounds = bounds;
    // 当textView的高度改变的时候刷新cell高度
    if (oldBounds.size.height != newSize.height) {
        [tableView beginUpdates];
        [tableView endUpdates];
    }
    //cell 高度增加时候 改变contenOffset
    if (oldBounds.size.height < newSize.height ) {
        [tableView layoutIfNeeded];
        CGFloat height = newSize.height - oldBounds.size.height;
        [UIView animateWithDuration:.2 animations:^{
            tableView.contentOffset = CGPointMake(0, tableView.contentOffset.y + height);
        }];
    }
}

#pragma mark  - keyBoard Notification

- (void)keyBoardHidden:(NSNotification *)notifi{
    // 恢复tableView的Y值
    [UIView animateWithDuration:.2 animations:^{
         [self tableView].top = 0;
    }];
}

-(void)keyBoardShow:(NSNotification *)notifi{
    // 过滤textView 拿到当前响应的textView
    if (![self.textView isFirstResponder]) return;
    // 获取键盘高度
    float height = [[notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
 // 获取textView的位置 转换为keyWidow的坐标
    CGRect rect = [self.textView convertRect:self.textView.bounds toView:[UIApplication sharedApplication].keyWindow];
    CGFloat locationY = CGRectGetMaxY(rect);
    
    // 键盘遮住cell的时候改变tableView的Y值
    if (locationY > (SHEIGHT - height)) {
        [UIView animateWithDuration:.2 animations:^{
            [self tableView].top -= (height + locationY- SHEIGHT);
        }];
    }
}


@end
