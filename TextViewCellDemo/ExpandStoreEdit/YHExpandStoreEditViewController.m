//
//  YHExpandStoreEditViewController.m
//  ShopAssistant
//
//  Created by Hui Yin on 2018/6/4.
//  Copyright © 2018年 Hui Yin. All rights reserved.
//

#import "YHExpandStoreEditViewController.h"
#import "YHExpandStoreEditCell.h"
#import "UITextView+Placeholder.h"

#define SWIDTH     [UIScreen mainScreen].bounds.size.width
#define SHEIGHT     [UIScreen mainScreen].bounds.size.height

@interface YHExpandStoreEditViewController () <UITableViewDelegate, UITableViewDataSource,YHExpandStoreEditCellDelegate>
{
    BOOL baseInfoIsOpen;
    BOOL moreInfoIsOpen;
}
@property (strong, nonatomic) NSArray *baseInfoTitles;
@property (strong, nonatomic) NSArray *moreInfoTitles;
@property (strong, nonatomic) NSArray *baseInfoTexts;
@property (strong, nonatomic) NSArray *moreInfoTexts;
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation YHExpandStoreEditViewController

static NSString *identifer = @"YHExpandStoreEditCellIdentifer";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self tableView];
    self.baseInfoTitles = @[@"拓展门店编号",@"拓展门店名称",@"销售大区",@"区局",@"街道社区",@"拓展门店地址",@"门店运营状态",@"拓展门店类型",@"经纬度坐标"];
    self.moreInfoTitles = @[@"终端销量",@"连锁商信息",@"最近走访日期",@"是否连锁",@"移动卡号",@"联通卡号",@"是否排他",@"是否授权",@"业主主推",@"数据来源",@"备注"];
    self.baseInfoTexts = @[@"",@"",@"",@"",@"",@"",@"",@"",@""];
    self.moreInfoTexts = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    moreInfoIsOpen = baseInfoIsOpen = YES;
}

#pragma mark  - init

- (void)setupNav {
    
    
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT) style:UITableViewStyleGrouped];
        
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        // 设置可变的cell高度,系统自动计算
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 45;
        // 设置滑动的时候隐藏键盘
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YHExpandStoreEditCell class] forCellReuseIdentifier:identifer];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark  - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        
        case 0:
        {
            return baseInfoIsOpen ? self.baseInfoTitles.count : 0;
        }break;
        
        case 1:
        {
            return moreInfoIsOpen ? self.moreInfoTitles.count : 0;
        }break;

        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHExpandStoreEditCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.section == 0) {
        cell.titleLbl.text = self.baseInfoTitles[indexPath.row];
        cell.textView.text = self.baseInfoTexts[indexPath.row];
            } else if (indexPath.section == 1) {
        cell.titleLbl.text = self.moreInfoTitles[indexPath.row];
        cell.textView.text = self.moreInfoTexts[indexPath.row];
    }
    

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *sectionView = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SWIDTH, 45)];
    sectionView.font = [UIFont systemFontOfSize:14];
    sectionView.textColor = [UIColor grayColor];
    if (section == 0) {
        sectionView.text = @"基础信息";
    } else if (section == 1) {
        sectionView.text = @"更多信息";
    }

    UIView *view = [[UIView alloc] init];
    [view addSubview:sectionView];
    view.backgroundColor = [UIColor lightGrayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderAction:)];
    [view addGestureRecognizer:tap];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0) return 10;
    
    return CGFLOAT_MIN;
}



- (void)sectionHeaderAction:(UIGestureRecognizer *)gest {
    
    NSInteger section;
    UILabel *lbl =gest.view.subviews[0];
    
    if ([lbl.text isEqualToString:@"基础信息"]) {
        section = 0;
    } else {
        section = 1;
    }
    switch (section) {
        case 0:
        {
            baseInfoIsOpen = !baseInfoIsOpen;
            [self.tableView reloadData];
        }break;
        
        case 1:
        {
            moreInfoIsOpen = !moreInfoIsOpen;
            [self.tableView reloadData];
        }break;

        default:
            break;
    }
}

// 通过代理保存更新cell的数据
- (void)textView:(YHExpandStoreEditCell *)cell didChangeText:(NSString *)text
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 0) {
        NSMutableArray *data = [self.baseInfoTexts mutableCopy];
        data[indexPath.row] = text;
        self.baseInfoTexts = [data copy];
    } else {
        NSMutableArray *data = [self.moreInfoTexts mutableCopy];
        data[indexPath.row] = text;
        self.moreInfoTexts = [data copy];
    }
    
}





@end
