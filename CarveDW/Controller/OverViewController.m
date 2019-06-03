//
//  OverViewController.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/3.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "OverViewController.h"
#import <Masonry.h>
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [uiScreen mainScreen].bounds.size.height
@interface OverViewController ()

@property(nonatomic, strong)UIImageView * bgView ;
@property(nonatomic, strong)UIScrollView * scrollView ;

@end

@implementation OverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set UI
    [self setUI] ;
}

- (void) setUI{
    //background
    _bgView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
    [_bgView setImage:[UIImage imageNamed:@"bg_overview"]] ;
    _bgView.userInteractionEnabled = YES ;
    [self.view addSubview:_bgView] ;
    //scrollview set
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds] ;
    _scrollView.pagingEnabled = YES ;
    _scrollView.scrollEnabled = YES ;
    _scrollView.showsVerticalScrollIndicator = NO ;
    _scrollView.showsHorizontalScrollIndicator = NO ;
    _scrollView.bounces = NO ;
    [self.view addSubview:_scrollView] ;
    //return nav
    UIButton * retBtn = [[UIButton alloc] init] ;
    [self.view addSubview:retBtn] ;
    [retBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).with.offset(42) ;
        make.width.height.mas_equalTo(@42) ;
    }];
    [retBtn setImage:[UIImage imageNamed:@"retNav"] forState:UIControlStateNormal] ;
    [retBtn addTarget:self action:@selector(navigationReturn) forControlEvents:UIControlEventTouchUpInside] ;
}

- (void)navigationReturn{
//    [self.navigationController popViewControllerAnimated:YES] ;
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
@end
