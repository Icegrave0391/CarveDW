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
@interface OverViewController ()<UIScrollViewDelegate, CAAnimationDelegate>

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
//    [self loadAnimationStart] ;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews] ;
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
    //scroll
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
//        make.centerY.equalTo(self.view.mas_centerY).with.offset(100) ;          //偏移（初始上移动画）
        make.centerY.equalTo(self.view.mas_centerY) ;
    }];
    _CAImgView1.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_img1"].CGImage) ;
//    _CAImgView1.layer.opacity = 0 ;
    
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
        make.right.equalTo(self.scrollView.mas_left).with.offset(kScreenWidth - 25) ;
        make.top.equalTo(self.CAImgView1.mas_top).with.offset(63) ;
        make.width.mas_equalTo(@508) ;
        make.height.mas_equalTo(@254) ;
    }];
    _CATextView1.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_text1"].CGImage) ;
//    _CATextView1.layer.opacity = 0 ;
    
    //init
    _CATitleView1 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CATitleView1] ;
    //初始化布局
    [_CATitleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.CATextView1.mas_left) ;
        make.width.mas_equalTo(@101) ;
        make.height.mas_equalTo(@35) ;
        make.top.equalTo(self.CAImgView1.mas_top) ;
    }];
    _CATitleView1.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"over_title1"].CGImage) ;
//    _CATitleView1.layer.opacity = 0 ;
    //scrollview2
    _CAImgView2 = [[UIView alloc] init] ;
    [self.scrollView addSubview:_CAImgView2] ;
    [_CAImgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_left).with.offset(kScreenWidth + 50) ;
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


//- (UIScrollView *)scrollView{
//    if(!_scrollView){
//        //scrollview set
//        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds] ;
//        _scrollView.pagingEnabled = YES ;
//        _scrollView.scrollEnabled = YES ;
//        _scrollView.showsVerticalScrollIndicator = NO ;
//        _scrollView.showsHorizontalScrollIndicator = NO ;
//        _scrollView.bounces = NO ;
//        [self.view addSubview:_scrollView] ;
//        _scrollView.contentSize = CGSizeMake(3 * kScreenWidth, kScreenHeight) ;
//        _scrollView.contentOffset = CGPointMake(0, 0) ;
//        _scrollView.delegate = self ;
//    }
//    return _scrollView ;
//}

#pragma mark - animation
- (void)loadAnimationStart{
    [self.view layoutIfNeeded];
    //img animation
    CABasicAnimation * imgAnimation = [CABasicAnimation animation] ;
    imgAnimation.keyPath = @"position" ;
    imgAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.CAImgView1.center.x, self.CAImgView1.layer.position.y + 100)] ;
    imgAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.CAImgView1.center.x, self.CAImgView1.layer.position.y)] ;
    imgAnimation.duration = 0.5f ;
    CABasicAnimation * imgOpa = [CABasicAnimation animation] ;
    imgOpa.keyPath = @"opacity" ;
    imgOpa.fromValue = [NSNumber numberWithFloat:0] ;
    imgOpa.toValue = [NSNumber numberWithFloat:1.0] ;
    imgOpa.duration = 0.5f ;
    CAAnimationGroup * imgGroup = [CAAnimationGroup animation] ;
    imgGroup.animations = @[imgAnimation, imgOpa] ;
    imgGroup.duration = 0.5f ;
    imgGroup.delegate = self ;
    [self.CAImgView1.layer addAnimation:imgGroup forKey:@"img1 init group"] ;
    //title animation
    CABasicAnimation * titleAnimation = [CABasicAnimation animation] ;
    titleAnimation.keyPath = @"position" ;
    titleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.CATitleView1.center.x, self.CATitleView1.center.y + 100)] ;
    titleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.CATitleView1.center.x, self.CATitleView1.center.y)] ;
    titleAnimation.duration = 0.5f ;
    CABasicAnimation * titleOpa = [CABasicAnimation animation] ;
    titleOpa.keyPath = @"opacity" ;
    titleOpa.fromValue = [NSNumber numberWithFloat:0] ;
    titleOpa.toValue = [NSNumber numberWithFloat:1.0f] ;
    titleOpa.duration = 0.5f ;
    CAAnimationGroup * titleGroup = [CAAnimationGroup animation] ;
    titleGroup.animations = @[titleAnimation, titleOpa] ;
    titleGroup.duration = 0.5f ;
    [self.CATitleView1.layer addAnimation:titleGroup forKey:nil] ;
    //text animation
    CABasicAnimation * textAnimation = [CABasicAnimation animation] ;
    textAnimation.duration = 0.5f ;
    textAnimation.keyPath = @"position" ;
    textAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.CATextView1.layer.position.x, self.CATextView1.layer.position.y + 100)] ;
    textAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.CATextView1.layer.position.x, self.CATextView1.layer.position.y)] ;
    [self.CATextView1.layer addAnimation:textAnimation forKey:nil] ;
    [self.CATextView1.layer addAnimation:imgOpa forKey:nil] ;
}
#pragma mark - scroll view delegate
//while scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"scroll point : %@",NSStringFromCGPoint(CGPointMake(self.CAImgView1.layer.position.x, self.CAImgView1.layer.position.y))) ;
    CGFloat offset = scrollView.contentOffset.x ;
    //scrollview 1 animation
    if(offset <= 637){
        self.CAImgView1.layer.speed = 0 ;
//
        CAAnimation * anim = [self imgView1Group] ;
        [self.CAImgView1.layer addAnimation:anim forKey:nil] ;
        anim.timeOffset = MAX(0, offset / 637) ;
        self.CAImgView1.layer.timeOffset = MAX(0, offset / 637) ;
//        NSLog(@"layer off : %f \nanimation off: %f", self.CAImgView1.layer.timeOffset, anim.timeOffset) ;
    }
    if(offset <= kScreenWidth / 2){
        self.CATitleView1.layer.speed = 0 ;
        self.CATextView1.layer.speed = 0 ;
        CAAnimation * opa = [self firstViewOpaAnim] ;
        [self.CATitleView1.layer addAnimation:opa forKey:nil] ;
        [self.CATextView1.layer addAnimation:opa forKey:nil] ;
        opa.timeOffset = MAX(0, offset * 2 / kScreenWidth) ;
        self.CATitleView1.layer.timeOffset = MAX(0, offset * 2 / kScreenWidth) ;
        self.CATextView1.layer.timeOffset = MAX(0, offset * 2 / kScreenWidth) ;
//        NSLog(@"layer off : %f \nanimation off: %f", self.CATitleView1.layer.timeOffset, opa.timeOffset) ;
    }
    if(offset <= kScreenWidth){
        self.CAImgView.layer.speed = 0 ;
        self.imgViewTran.timeOffset = offset / kScreenWidth ;                   //以下三个需要同时修改？？？
        self.imgViewOpa.timeOffset = offset / kScreenWidth ;
        self.CAImgView.layer.timeOffset = MAX(0, offset / kScreenWidth) ;
//        NSLog(@"+++++++++++++opa time offset : %f", self.CAImgView.layer.timeOffset) ;
    }
    if(offset == kScreenWidth){
        CAAnimation * spr = [self imgView2SpringAnim] ;
        [self.CAImgView2.layer addAnimation:spr forKey:nil] ;
    }
    if(offset > kScreenWidth && offset <= kScreenWidth + self.CAImgView2.frame.size.width){
        CAAnimation * tran = [self secondViewScrollAnim] ;
        tran.timeOffset = (offset - kScreenWidth) / self.CAImgView2.frame.size.width ;
        for(CALayer * layer in @[self.CATitleView2.layer, self.CATextView2.layer]){
            layer.speed = 0 ;
            [layer addAnimation:tran forKey:nil] ;
            layer.timeOffset = tran.timeOffset ;
        }
    }
    if(offset > 1.5 * kScreenWidth && offset < 2 * kScreenWidth){
        CAAnimation * titleTran = [self thirdTitleViewScrollAnim] ;
        CAAnimation * textTran = [self thirdTextViewScrollAnim] ;
        titleTran.timeOffset = (offset - 1.5 * kScreenWidth) / (0.5 * kScreenWidth) ;
        textTran.timeOffset = titleTran.timeOffset ;
        self.CATitleView3.layer.speed = 0 ;
        self.CATitleView3.layer.timeOffset = titleTran.timeOffset ;
        [self.CATitleView3.layer addAnimation:titleTran forKey:nil] ;
        self.CATextView3.layer.speed = 0 ;
        self.CATextView3.layer.timeOffset = textTran.timeOffset ;
        [self.CATextView3.layer addAnimation:textTran forKey:nil] ;
    }
}

#pragma mark - animation (set time offset)
- (CABasicAnimation *)imgViewTran{
    if(!_imgViewTran){
        _imgViewTran = [CABasicAnimation animation] ;
        _imgViewTran.keyPath = @"position" ;
        [self.view layoutIfNeeded] ;
        _imgViewTran.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.CAImgView.center.x, self.CAImgView.center.y)] ;
        _imgViewTran.toValue = [NSValue valueWithCGPoint:CGPointMake(self.CAImgView.center.x - kScreenWidth, self.CAImgView.center.y)] ;
//        _imgViewTran.speed = 0 ;                                         //不能设置动画的speed = 0否则失效，只能设置layer的speed=0 为什么？
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
//        _imgViewOpa.speed = 0 ;
        _imgViewOpa.duration = 1 ;
        _imgViewOpa.removedOnCompletion = NO ;
        _imgViewOpa.fillMode = kCAFillModeForwards ;
        [self.CAImgView.layer addAnimation:_imgViewOpa forKey:nil] ;
    }
    return _imgViewOpa ;
}
//first scrollview img1
- (CAAnimation *)imgView1Group{
    [self.view layoutIfNeeded] ;
    CABasicAnimation * opa = [CABasicAnimation animation] ;
    opa.keyPath = @"opacity" ;
//    opa.fromValue = [NSNumber numberWithFloat:1] ;
    opa.toValue = [NSNumber numberWithFloat:0] ;
//    opa.removedOnCompletion = NO ;
//    opa.fillMode = kCAFillModeForwards ;
    opa.duration = 10 ;
    CABasicAnimation * tran = [CABasicAnimation animation] ;
    tran.keyPath = @"position" ;
//    tran.removedOnCompletion = NO ;
//    tran.fillMode = kCAFillModeForwards ;
    tran.duration = 1 ;
    CGFloat xPos = self.CAImgView1.layer.position.x ;
//    NSLog(@"center : %@", NSStringFromCGPoint(CGPointMake(self.CAImgView1.center.x, self.CAImgView1.center.y))) ;
    tran.fromValue = [NSValue valueWithCGPoint:CGPointMake(xPos, self.view.center.y)] ;
    tran.toValue = [NSValue valueWithCGPoint:CGPointMake(xPos - 50, self.view.center.y)] ;
    CAAnimationGroup * group = [CAAnimationGroup animation] ;
    group.animations = @[tran, opa] ;
//    group.removedOnCompletion = NO ;
//    group.fillMode = kCAFillModeForwards ;
    group.duration = 10 ;
    return group ;
}

- (CAAnimation *)firstViewOpaAnim{
    CABasicAnimation * opa = [CABasicAnimation animation] ;
    opa.keyPath = @"opacity" ;
//    opa.fromValue = [NSNumber numberWithFloat: 1] ;
    opa.toValue = [NSNumber numberWithFloat: 0] ;
//    opa.speed = 0 ;
    opa.duration = 10 ;
//    opa.removedOnCompletion = NO ;
//    opa.fillMode = kCAFillModeForwards ;
    return opa ;
}

- (CAAnimation *)imgView2SpringAnim{
    CASpringAnimation * spr = [CASpringAnimation animation] ;
    spr.keyPath = @"position" ;
    //参数调整
    spr.mass = 10 ;          //质量 影响惯性和幅度 质量越大幅度越大
    spr.stiffness = 2500 ; //劲度系数，影响加速度（即运动速度）
    spr.damping = 100.0 ;  //阻尼系数， 影响运动时间
    spr.initialVelocity = 1.f ; //初始速率，速率为正表示速度方向和运动方向一致
    spr.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.CAImgView2.layer.position.x, self.CAImgView2.layer.position.y)] ;
    spr.toValue = [NSValue valueWithCGPoint:CGPointMake(self.CAImgView2.layer.position.x - 50, self.CAImgView2.layer.position.y)] ;
    spr.duration = spr.settlingDuration ; //持续时间 = 稳定时间
    spr.removedOnCompletion = NO ;
    spr.fillMode = kCAFillModeForwards ;
    return spr ;
}

- (CAAnimation *)secondViewScrollAnim{
    CABasicAnimation * tran = [CABasicAnimation animation] ;
    tran.keyPath = @"transform.translation.x" ;
    CGPoint imgCenter = self.CAImgView2.layer.position ;
    CGFloat imgHalfWidth = self.CAImgView2.layer.frame.size.width / 2 ;
    CGPoint textCenter = self.CATextView2.layer.position ;
    CGFloat textHalfWidth = self.CATextView2.layer.frame.size.width / 2 ;
    CGFloat disAbs = (textCenter.x - imgCenter.x) - (imgHalfWidth + textHalfWidth) ;
    tran.toValue = [NSNumber numberWithFloat:-disAbs] ;
    tran.duration = 1 ;
    return tran ;
}

- (CAAnimation *)thirdTitleViewScrollAnim{
    CABasicAnimation * tran = [CABasicAnimation animation] ;
    tran.keyPath = @"position" ;
    CGFloat dis = self.CATextView3.layer.frame.size.width + 100 - self.CATitleView3.layer.frame.size.width ;
    tran.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.CATitleView3.layer.position.x + dis, self.CATitleView3.layer.position.y)] ;
    tran.toValue = [NSValue valueWithCGPoint:self.CATitleView3.layer.position] ;
    tran.duration = 1 ;
//    tran.removedOnCompletion = NO ;
//    tran.fillMode = kCAFillModeForwards ;
    return tran ;
}

- (CAAnimation *)thirdTextViewScrollAnim{
    CABasicAnimation * tran = [CABasicAnimation animation] ;
    tran.keyPath = @"position" ;
    CGFloat dis = self.CATextView3.layer.frame.size.width + 100 ;
    tran.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.CATextView3.layer.position.x + dis, self.CATextView3.layer.position.y)] ;
    tran.toValue = [NSValue valueWithCGPoint:self.CATextView3.layer.position] ;
    tran.duration = 1 ;
//    tran.removedOnCompletion = NO ;
//    tran.fillMode = kCAFillModeForwards ;
    return tran ;
}
#pragma mark - animation delegate
//- (void)animationDidStart:(CAAnimation *)anim{
//    if(anim == [self.CAImgView1.layer animationForKey:@"init pos"] ){
//        NSLog(@"AAAAAAAAAAAAAAAAA") ;
//    }
//}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (anim == [self.CAImgView1.layer animationForKey:@"img1 init group"]) {
//        [self.CAImgView1.layer removeAllAnimations] ;
        self.CAImgView1.layer.opacity = 1 ;
        self.CAImgView1.layer.position = CGPointMake(self.CAImgView1.layer.position.x, self.view.center.y) ;
//        self.CAImgView1.layer.opacity = 1 ;
//        NSLog(@"nue : %@", NSStringFromCGPoint(CGPointMake(self.CAImgView1.layer.position.x, self.CAImgView1.layer.position.y))) ;
    }
}
@end
