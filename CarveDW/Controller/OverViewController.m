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
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kDismissOffset kScreenWidth / 2
@interface OverViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIImageView * bgView ;
@property(nonatomic, strong)UIScrollView * scrollView ;

@property(nonatomic, strong)UIView * CAImgView ;
@property(nonatomic, strong)UIView * CAImgView1 ;
@property(nonatomic, strong)UIView * CATitleView1 ;
@property(nonatomic, strong)UIView * CATextView1 ;
@property(nonatomic, strong)CABasicAnimation * imgViewTran ;
@property(nonatomic, strong)CABasicAnimation * imgViewOpa ;

@property(nonatomic, strong)UIView * CAImgView2 ;
@property(nonatomic, strong)UIView * CATitleView2 ;
@property(nonatomic, strong)UIView * CATextView2 ;

@property(nonatomic, strong)UIView * CAImgView3 ;
@property(nonatomic, strong)UIView * CATitleView3 ;
@property(nonatomic, strong)UIView * CATextView3 ;
@end

@implementation OverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set UI
    [self setUI] ;
    //initial animation
    [self loadAnimationStart] ;
}

- (void) setUI{
    //background
    _bgView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
    [_bgView setImage:[UIImage imageNamed:@"bg_overview"]] ;
    _bgView.userInteractionEnabled = YES ;
    [self.view addSubview:_bgView] ;
    //init
    _CAImgView = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CAImgView] ;
    [_CAImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom) ;
        make.right.equalTo(self.scrollView.mas_left).with.offset(kScreenWidth) ;
        make.width.height.mas_equalTo(400) ;
    }];
    [self.view layoutIfNeeded] ;
    _CAImgView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_img"].CGImage) ;
    _CAImgView.layer.opacity = 1 ;
    //
    _CAImgView1 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CAImgView1] ;
    //初始化布局
    [_CAImgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_left).with.offset(98) ;
        make.width.mas_equalTo(@517) ;
        make.height.mas_equalTo(@340) ;
        make.centerY.equalTo(self.view.mas_centerY).with.offset(100) ;          //偏移（初始上移动画）
    }];
    _CAImgView1.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_img1"].CGImage) ;
    _CAImgView1.layer.opacity = 1 ;
    
    _CATextView1 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CATextView1] ;
    //return nav
    UIButton * retBtn = [[UIButton alloc] init] ;
    [self.view addSubview:retBtn] ;
    [retBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).with.offset(42) ;
        make.width.height.mas_equalTo(@42) ;
    }];
    [retBtn setImage:[UIImage imageNamed:@"retNav"] forState:UIControlStateNormal] ;
    [retBtn addTarget:self action:@selector(navigationReturn) forControlEvents:UIControlEventTouchUpInside] ;
    //初始化布局
    [_CATextView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.CATitleView1.mas_left) ;
        make.right.equalTo(self.view.mas_right).with.offset(-25) ;
        //            make.top.equalTo(self.CATitleView1.mas_bottom).with.offset(30) ;
        make.top.equalTo(self.CAImgView1.mas_top).with.offset(63) ;
        make.width.mas_equalTo(@508) ;
        make.height.mas_equalTo(@254) ;
    }];
    _CATextView1.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_text1"].CGImage) ;
    _CATextView1.layer.opacity = 0 ;
    
    //init
    _CATitleView1 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CATitleView1] ;
    //初始化布局
    [_CATitleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.scrollView.mas_left).with.offset(735) ;
        //            make.left.equalTo(self.CAImgView1.mas_right).with.offset(50) ;
        make.left.equalTo(self.CATextView1.mas_left) ;
        make.width.mas_equalTo(@101) ;
        make.height.mas_equalTo(@35) ;
        make.top.equalTo(self.CAImgView1.mas_top) ;
    }];
    _CATitleView1.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_title1"].CGImage) ;
    _CATitleView1.layer.opacity = 0 ;
    //init
    _CATitleView1 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CATitleView1] ;
    //初始化布局
    [_CATitleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.scrollView.mas_left).with.offset(735) ;
        //            make.left.equalTo(self.CAImgView1.mas_right).with.offset(50) ;
        make.left.equalTo(self.CATextView1.mas_left) ;
        make.width.mas_equalTo(@101) ;
        make.height.mas_equalTo(@35) ;
        make.top.equalTo(self.CAImgView1.mas_top) ;
    }];
    _CATitleView1.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_title1"].CGImage) ;
    _CATitleView1.layer.opacity = 0 ;
    //scrollview2
    _CAImgView2 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CAImgView2] ;
    [_CAImgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_left).with.offset(kScreenWidth) ;
        make.centerY.equalTo(self.view.mas_centerY) ;
        make.height.mas_equalTo(@571) ;
        make.width.mas_equalTo(@637) ;
    }];
    _CAImgView2.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_img2"].CGImage) ;
    _CAImgView2.layer.opacity = 1 ;//test -> 0
    //
    _CATextView2 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CATextView2] ;
    [_CATextView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scrollView.mas_left).with.offset(2 * kScreenWidth - 100) ;
        make.centerY.equalTo(self.view.mas_centerY) ;
        make.height.mas_equalTo(@178) ;
        make.width.mas_equalTo(@466) ;
    }];
    _CATextView2.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_text2"].CGImage) ;
    _CATextView2.layer.opacity = 1 ;
    //
    _CATitleView2 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CATitleView2] ;
    [_CATitleView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.CATextView2.mas_left) ;
        make.bottom.equalTo(self.CATextView2.mas_top).with.offset(-28) ;
        make.height.mas_equalTo(@35) ;
        make.width.mas_equalTo(@102) ;
    }];
    _CATitleView2.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_title2"].CGImage) ;
    _CATitleView2.layer.opacity = 1 ;
    //scrollview3
    _CAImgView3 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CAImgView3] ;
    [_CAImgView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_left).with.offset(2 * kScreenWidth + 100) ;
        make.centerY.equalTo(self.scrollView.mas_centerY) ;
        make.width.mas_equalTo(@508) ;
        make.height.mas_equalTo(@624) ;
    }];
    _CAImgView3.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_img3"].CGImage) ;
    _CAImgView3.layer.opacity = 1 ;
    //
    _CATextView3 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CATextView3] ;
    [_CATextView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scrollView.mas_left).with.offset(3 * kScreenWidth - 100) ;
        make.centerY.equalTo(self.scrollView.mas_centerY) ;
        make.width.mas_equalTo(@460) ;
        make.height.mas_equalTo(@255) ;
    }];
    _CATextView3.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_text3"].CGImage) ;
    _CATextView3.layer.opacity = 1 ;
    //
    _CATitleView3 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CATitleView3] ;
    [_CATitleView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.CATextView3.mas_left) ;
        make.bottom.equalTo(self.CATextView3.mas_top).with.offset(-28) ;
        make.width.mas_equalTo(@101) ;
        make.height.mas_equalTo(@35) ;
    }];
    _CATitleView3.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_title3"].CGImage) ;
    _CATitleView3.layer.opacity = 1 ;
}

- (void)navigationReturn{
//    [self.navigationController popViewControllerAnimated:YES] ;
    [self dismissViewControllerAnimated:YES completion:nil] ;
}


- (UIScrollView *)scrollView{
    if(!_scrollView){
        //scrollview set
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds] ;
        _scrollView.pagingEnabled = YES ;
        _scrollView.scrollEnabled = YES ;
        _scrollView.showsVerticalScrollIndicator = NO ;
        _scrollView.showsHorizontalScrollIndicator = NO ;
        _scrollView.bounces = NO ;
        [self.view addSubview:_scrollView] ;
        _scrollView.contentSize = CGSizeMake(3 * kScreenWidth, kScreenHeight) ;
        _scrollView.contentOffset = CGPointMake(0, 0) ;
        _scrollView.delegate = self ;
    }
    return _scrollView ;
}

#pragma mark - animation
- (void)loadAnimationStart{
    [self.view layoutIfNeeded];
    //img animation
    CABasicAnimation * imgAnimation = [CABasicAnimation animation] ;
    imgAnimation.keyPath = @"position" ;
    imgAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.CAImgView1.center.x, self.view.center.y)] ;
    imgAnimation.duration = 0.5f ;
    imgAnimation.removedOnCompletion = NO ;
    imgAnimation.fillMode = kCAFillModeForwards ;
    CABasicAnimation * imgOpa = [CABasicAnimation animation] ;
    imgOpa.keyPath = @"opacity" ;
    imgOpa.fromValue = [NSNumber numberWithFloat:0] ;
    imgOpa.toValue = [NSNumber numberWithFloat:1.0] ;
    imgOpa.duration = 0.5f ;
    imgOpa.fillMode = kCAFillModeForwards ;
    imgOpa.removedOnCompletion = NO ;
//    CAAnimationGroup * imgGroup = [CAAnimationGroup animation] ;
//    imgGroup.animations = @[imgAnimation, imgOpa] ;
//    imgGroup.duration = 0.5f ;
//    [self.CAImgView1.layer addAnimation:imgGroup forKey:nil] ;
    [self.CAImgView1.layer addAnimation:imgAnimation forKey:nil] ;
    [self.CAImgView1.layer addAnimation:imgOpa forKey:nil] ;
    //title animation
    CABasicAnimation * titleAnimation = [CABasicAnimation animation] ;
    titleAnimation.keyPath = @"position" ;
    titleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.CATitleView1.center.x, self.CATitleView1.center.y - 100)] ;
    titleAnimation.duration = 0.5f ;
    titleAnimation.removedOnCompletion = NO ;
    titleAnimation.fillMode = kCAFillModeForwards ;
    CABasicAnimation * titleOpa = [CABasicAnimation animation] ;
    titleOpa.keyPath = @"opacity" ;
    titleOpa.fromValue = [NSNumber numberWithFloat:0] ;
    titleOpa.toValue = [NSNumber numberWithFloat:1.0f] ;
    titleOpa.duration = 0.5f ;
    titleOpa.fillMode = kCAFillModeForwards ;
    titleOpa.removedOnCompletion = NO ;
    [self.CATitleView1.layer addAnimation:titleAnimation forKey:nil] ;
    [self.CATitleView1.layer addAnimation:titleOpa forKey:nil] ;
    //text animation
    CABasicAnimation * textAnimation = [CABasicAnimation animation] ;
    textAnimation.duration = 0.5f ;
    textAnimation.keyPath = @"position" ;
    textAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.CATextView1.center.x, self.CATextView1.center.y - 100)] ;
    textAnimation.removedOnCompletion = NO ;
    textAnimation.fillMode = kCAFillModeForwards ;
    [self.CATextView1.layer addAnimation:textAnimation forKey:nil] ;
    [self.CATextView1.layer addAnimation:imgOpa forKey:nil] ;
}
#pragma mark - scroll view delegate
//while scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x ;
    //scrollview 1 animation
    if(offset <= kScreenWidth){
        self.imgViewTran.timeOffset = offset / kScreenWidth ;
        self.imgViewOpa.timeOffset = offset / kScreenWidth ;
        NSLog(@"==========curr offsert:%f", offset) ;
        NSLog(@"+++++++++++++opa time offset : %f", self.imgViewOpa.timeOffset) ;
    }
}
//begin drag
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    CGFloat offset = scrollView.contentOffset.x ;
//    if(offset <= kScreenWidth){
//        self.imgViewTran.timeOffset = offset / kScreenWidth ;
//    }
//}
#pragma mark - animation (set time offset)
- (CABasicAnimation *)imgViewTran{
    if(!_imgViewTran){
        _imgViewTran = [CABasicAnimation animation] ;
        _imgViewTran.keyPath = @"position" ;
        [self.view layoutIfNeeded] ;
        _imgViewTran.toValue = [NSValue valueWithCGPoint:CGPointMake(self.CAImgView.center.x - kScreenWidth, self.CAImgView.center.y)] ;
        _imgViewTran.speed = 0 ;
        _imgViewTran.duration = 1 ;
        _imgViewTran.removedOnCompletion = NO ;
        _imgViewTran.fillMode = kCAFillModeForwards ;
        [self.CAImgView.layer addAnimation:_imgViewTran forKey:nil] ;
    }
    return _imgViewTran ;
}
- (CABasicAnimation *)imgViewOpa{
    if(!_imgViewOpa){
        _imgViewOpa = [CABasicAnimation animation] ;
        _imgViewOpa.keyPath = @"opacity" ;
        _imgViewOpa.fromValue = [NSNumber numberWithFloat:1] ;
        _imgViewOpa.toValue = [NSNumber numberWithFloat:0] ;
        _imgViewOpa.speed = 0 ;
        _imgViewOpa.duration = 1 ;
        _imgViewOpa.removedOnCompletion = NO ;
        _imgViewOpa.fillMode = kCAFillModeForwards ;
        [self.CAImgView.layer addAnimation:_imgViewOpa forKey:nil] ;
    }
    return _imgViewOpa ;
}
@end
