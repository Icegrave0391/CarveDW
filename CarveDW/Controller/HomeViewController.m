//
//  HomeViewController.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/2.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "HomeViewController.h"
#import "OverViewController.h"
#import <Masonry.h>
@interface HomeViewController ()<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@property(nonatomic, strong)UIImageView * backView ;
@property(nonatomic, strong)UIView * dimingView ;
@property(nonatomic)BOOL isPresenting ;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPresenting = YES ;
    //set UI
    [self setUI] ;
}

- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated] ;
    [self.navigationController setNavigationBarHidden:YES animated:YES] ;
    [super viewWillAppear:animated] ;

}
- (void) setUI{
    //backview
    self.view.backgroundColor = [UIColor whiteColor] ;
    _backView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
    _backView.image = [UIImage imageNamed:@"bg_home"] ;
    _backView.userInteractionEnabled = YES ;
    [self.view addSubview:_backView] ;
    //button
    UIButton * btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 173, 332)] ;
    btn1.tag = 1 ;
    UIButton * btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 210, 268)] ;
    btn2.tag = 2 ;
    UIButton * btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 233, 265)] ;
    btn3.tag = 3 ;
    UIButton * btn4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 201, 285)] ;
    btn4.tag = 4 ;
    [btn1 setImage:[UIImage imageNamed:@"概况"] forState:UIControlStateNormal] ;
    [btn2 setImage:[UIImage imageNamed:@"工艺"] forState:UIControlStateNormal] ;
    [btn3 setImage:[UIImage imageNamed:@"故事"] forState:UIControlStateNormal] ;
    [btn4 setImage:[UIImage imageNamed:@"趣味"] forState:UIControlStateNormal] ;
    for(UIButton * btn in @[btn1, btn2, btn3, btn4]){
        [self.backView addSubview:btn] ;
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.view.mas_centerY) ;
//        }];
        [btn addTarget:self action:@selector(pushBtnClicked:) forControlEvents:UIControlEventTouchUpInside] ;
    }
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@173) ;
        make.height.mas_equalTo(@332) ;
        make.centerY.equalTo(self.view) ;
//        make.left.equalTo(self.view.mas_left).with.offset(136) ;
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@210) ;
        make.height.mas_equalTo(@268) ;
        make.centerY.equalTo(self.view) ;
//        make.left.equalTo(self.view.mas_left).with.offset(416) ;
    }];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@233) ;
        make.height.mas_equalTo(@265) ;
        make.centerY.equalTo(self.view) ;
//        make.right.equalTo(self.view.mas_right).with.offset(-431) ;
    }];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@201) ;
        make.height.mas_equalTo(@285) ;
        make.centerY.equalTo(self.view) ;
//        make.right.equalTo(self.view.mas_right).with.offset(-150) ;
    }];
    [@[btn1, btn2, btn3, btn4] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:200 leadSpacing:136 tailSpacing:150] ;
    
}

- (void)pushBtnClicked:(UIButton *)sender{
    if(sender.tag == 1){
        OverViewController * OverViewVC = [[OverViewController alloc] init] ;
        OverViewVC.transitioningDelegate = self ;
        [self presentViewController:OverViewVC animated:YES completion:nil] ;
    }
    else if(sender.tag == 2){
        
    }
    else if(sender.tag == 3){
        
    }
    else{
        
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //1.获得容器视图
    UIView* containerView = [transitionContext containerView];
    
    //2.获得目标控制器和视图
    UIView* toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView* fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
//    if (self.isPresenting) {
        //present& dismiss
        fromView.alpha = 0 ;
        toView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        toView.center = CGPointMake(containerView.center.x, containerView.center.y);
        toView.alpha = 0 ;
        //3.创建遮罩视图
        self.dimingView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.dimingView.backgroundColor = [UIColor blackColor];
        //        self.dimingView.alpha = 0.0;
        self.dimingView.layer.opacity = 1;
        //4.将要进行动画的视图添加到容器视图中
        [containerView addSubview:self.dimingView];
        [containerView addSubview:toView];
        /*
         一定要注意添加顺序，如果toView在dimingView之前添加，dimingView就把toView给覆盖了，这样就无法点击toView了，点击的全部都是dimingView
         */
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            self.dimingView.layer.opacity = 0 ;
            toView.alpha = 1 ;
//            toView.center = CGPointMake(containerView.center.x, containerView.center.y);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:true];
            //如果视图被移除，我们就自己添加上去
//            [[UIApplication sharedApplication].keyWindow insertSubview:fromView belowSubview:containerView];
        }];
    
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresenting = true;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresenting = false;
    return self;
}
@end
