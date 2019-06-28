//
//  CraftViewController.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/17.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "CraftViewController.h"
#import <Masonry.h>
#import "CraftFirstPage.h"
#import "CraftPageView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface CraftViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong)UIImageView * bgView ;
@property(nonatomic, strong)UIScrollView * scrollView ;
@property(nonatomic, strong)CraftFirstPage * beginPage ;
@property(nonatomic, strong)NSArray<CraftPageView *> * pageArr ;
//begin animation
@property(nonatomic, assign)CGPoint operateViewInitPos ;
@property(nonatomic, assign)CGPoint overViewInitPos ;
@property(nonatomic, assign)CGPoint page1TextViewInitPos ;
@property(nonatomic, assign)CGPoint page1ImgViewInitPos ;
@end

@implementation CraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set UI
    [self setUI] ;
}

- (void)setUI{
    _bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_craft"]] ;
    _bgView.frame = [UIScreen mainScreen].bounds ;
    _bgView.userInteractionEnabled = YES ;
    [self.view addSubview:_bgView] ;
    //init scrollview 1 UI
    self.beginPage = [[CraftFirstPage alloc] init] ;
    [self.scrollView addSubview:self.beginPage] ;
    //page
    NSMutableArray * tempArr = [NSMutableArray array] ;
    for (int i = 0; i < 8; i++) {
        CraftPageView * page = [[CraftPageView alloc] initWithPage:i+1] ;
        page.frame = CGRectMake(0, kScreenHeight * (i+1), kScreenWidth, kScreenHeight) ;
        [self.scrollView addSubview:page] ;
        [tempArr addObject:page] ;
    }
    self.pageArr = [NSArray arrayWithArray:tempArr] ;
    //return button
    UIButton * retBtn = [[UIButton alloc] init] ;
    [self.view addSubview:retBtn] ;
    [retBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).with.offset(42) ;
        make.width.height.mas_equalTo(@42) ;
    }];
    [retBtn setImage:[UIImage imageNamed:@"retNav"] forState:UIControlStateNormal] ;
    [retBtn addTarget:self action:@selector(navigationReturn) forControlEvents:UIControlEventTouchUpInside] ;
}

- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds] ;
        _scrollView.pagingEnabled = YES ;
        _scrollView.scrollEnabled = YES ;
        _scrollView.showsVerticalScrollIndicator = NO ;
        _scrollView.showsHorizontalScrollIndicator = NO ;
        _scrollView.bounces = NO ;
        [self.view addSubview:_scrollView] ;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, 9 * kScreenHeight) ;
        _scrollView.contentOffset = CGPointMake(0, 0) ;
        _scrollView.delegate = self ;
    }
    return _scrollView ;
}
#pragma mark - animation
- (void)viewDidLayoutSubviews{
    self.scrollView.contentOffset = CGPointMake(0, 0) ;
    //begin page animation
    [self.view layoutIfNeeded] ;
    self.operateViewInitPos = self.beginPage.operateView.layer.position ;
    self.overViewInitPos = self.beginPage.overView.layer.position ;
//    self.beginPage.operateTran = [self.beginPage operateViewTranWithBeginPosition:self.operateViewInitPos] ;
//    self.beginPage.overViewTran = [self.beginPage overViewTranWithBeginPosition:self.overViewInitPos] ;
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y ;
    CGFloat beginPageBeginOffset = 300 - 47 - self.beginPage.robbinBottom.frame.size.height ;
    if(offset < beginPageBeginOffset){
//        self.beginPage.timeOffset = 0 ;
        CGPoint operacenter = self.beginPage.operateView.center ;
        operacenter.y = self.operateViewInitPos.y + offset ;
        self.beginPage.operateView.center = operacenter ;
        CGPoint overcenter = self.beginPage.overView.center ;
        overcenter.y = self.overViewInitPos.y + offset ;
        self.beginPage.overView.center = overcenter ;
    }
    if(offset < kScreenHeight){
        self.pageArr[0].timeOffset = offset / kScreenHeight ;
    }
    if(kScreenHeight <= offset && offset < kScreenHeight + 150){
        [self.pageArr[0].page1ImgView.layer removeAllAnimations] ;
        CGPoint oriCenter = self.pageArr[0].page1ImgView.center ;
        oriCenter.y = self.pageArr[0].page1InitImgPos.y + offset - kScreenHeight;
        self.pageArr[0].page1ImgView.center = oriCenter ;
    }
    //page2 animation
//    if(kScreenHeight <= offset && offset < kScreenHeight + 100){
//        for(UIImageView * imgView in self.pageArr[1].page2ImgeArr){
//            [imgView.layer removeAllAnimations] ;
//            CGPoint oriCenter = imgView.center ;
//            oriCenter.y = self.pageArr[1].page2ImgViewInitPosY + offset - kScreenHeight ;
//            imgView.center = oriCenter ;
//        }
//    }
//    CGFloat kOffset = 100 ;
//    if(kScreenHeight * 2 - kOffset <= offset && offset <= 2 * kScreenHeight){
//        self.pageArr[1].timeOffset = (offset + kOffset - 2 * kScreenHeight) / kOffset ;
//        NSLog(@"off : %f",self.pageArr[1].timeOffset);
//    }
    if(kScreenHeight <= offset && offset <= 2 * kScreenHeight){
        self.pageArr[1].timeOffset = 0 ;
        if(offset == 2 * kScreenHeight){
            self.pageArr[1].timeOffset = 1 ;
        }
    }
//    CGPoint point = [scrollView.panGestureRecognizer translationInView:self.view];
//    if (point.y > 0){
//        self.pageArr[1].timeOffset = 0 ;
//        if (offset == 2 * kScreenHeight) {
//            self.pageArr[1].timeOffset = 1 ;
//        }
//    }
}

- (void)navigationReturn{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}


@end