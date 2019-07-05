//
//  CreatMenuViewController.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/30.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "CreatMenuViewController.h"
#import "UIImage+Bundle.h"
#import "CreatCardViewController.h"
#import <Masonry.h>
@interface CreatMenuViewController ()

@end

@implementation CreatMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    [self setUpUI] ;
}
- (void)setUpUI{
    UIImageView * bgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"menu_bgView"]] ;
    bgView.frame = [UIScreen mainScreen].bounds ;
    bgView.userInteractionEnabled = YES ;
    [self.view addSubview:bgView] ;
    //return
    UIButton * retBtn = [[UIButton alloc] init] ;
    [self.view addSubview:retBtn] ;
    [retBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).with.offset(42) ;
        make.width.height.mas_equalTo(@42) ;
    }];
    [retBtn setImage:[UIImage imageNamed:@"retNav"] forState:UIControlStateNormal] ;
    [retBtn addTarget:self action:@selector(navigationReturn) forControlEvents:UIControlEventTouchUpInside] ;
    
    //card button
    UIButton * videoBtn = [[UIButton alloc] init] ;
    videoBtn.tag = 1 ;
    [self.view addSubview:videoBtn] ;
    [videoBtn setImage:[UIImage getBundleImageName:@"menu_video"] forState:UIControlStateNormal] ;
    [videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@250) ;
        make.height.mas_equalTo(@250) ;
        make.centerY.equalTo(self.view.mas_centerY) ;
        make.left.equalTo(self.view.mas_left).with.offset(315) ;
    }];
    [videoBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside] ;
    UIButton * cardBtn = [[UIButton alloc] init] ;
    cardBtn.tag = 2 ;
    [self.view addSubview:cardBtn] ;
    [cardBtn setImage:[UIImage getBundleImageName:@"menu_card"] forState:UIControlStateNormal] ;
    [cardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@230) ;
        make.height.mas_equalTo(@257) ;
        make.centerY.equalTo(self.view.mas_centerY) ;
        make.right.equalTo(self.view.mas_right).with.offset(-315) ;
    }];
    [cardBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside] ;
}

- (void)buttonClicked:(UIButton *)sender{
    if (sender.tag == 2) {
        CreatCardViewController * cardVC = [[CreatCardViewController alloc] init] ;
        [self presentViewController:cardVC animated:YES completion:nil] ;
    }
}

- (void)navigationReturn{
    //    [self.navigationController popViewControllerAnimated:YES] ;
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
@end
