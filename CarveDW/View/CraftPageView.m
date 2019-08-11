//
//  CraftPageView.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/17.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "CraftPageView.h"
#import <Masonry.h>
#import "BundleLoader.h"
#import "UIImage+Bundle.h"
@interface CraftPageView()
@property(nonatomic, strong)CABasicAnimation * page1TextAnim ;
@property(nonatomic, strong)CABasicAnimation * page1ImgAnim ;
//@property(nonatomic, strong)CABasicAnimation * page1DismissAnim ;
@property(nonatomic, strong)CAAnimation * page2ImgAnim ;
@property(nonatomic, strong)CAAnimation * page3ImgAnim ;
@property(nonatomic, strong)CAAnimation * page3LabelAnim;
@end

@implementation CraftPageView
- (instancetype)initWithPage:(NSInteger)page{
    self = [super initWithFrame:[UIScreen mainScreen].bounds] ;
    if(self){
        self.page = page ;
        //top img view
        self.TopImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld", (long)page]]] ;
        [self addSubview: self.TopImgView] ;
        [self.TopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right) ;
            make.top.equalTo(self.mas_top) ;
            make.width.mas_equalTo(@350) ;
            make.height.mas_equalTo(@298) ;
        }];
        //set page ui
        [self setUIWithPage:page] ;
        //set timeoffset
        _timeOffset = 0 ;
        _page3LabelOffset = 0;
    }
    return self ;
}

- (void)setUIWithPage:(NSInteger)page{
    [BundleLoader initFrameworkBundle:@"resourceBundle"] ;
    if(page == 1){
        self.page1ImgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page1_img"]] ;
        [self addSubview:self.page1ImgView] ;
        [self.page1ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(321) ;
            make.left.equalTo(self.mas_left).with.offset(144) ;
            make.width.mas_equalTo(@526) ;
            make.height.mas_equalTo(@361) ;
        }];
        self.page1ImgView.layer.speed = 0 ;
        self.page1TextView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page1_text"]] ;
        [self addSubview:self.page1TextView] ;
        [self.page1TextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(397) ;
            make.right.equalTo(self.mas_right).with.offset(-162) ;
            make.width.mas_equalTo(@446) ;
            make.height.mas_equalTo(@355) ;
        }];
        self.page1TextView.layer.speed = 0 ;
        [self layoutIfNeeded] ;
        self.page1InitImgPos = self.page1ImgView.layer.position ;
    }
    if(page == 2){
        NSMutableArray * tempArr = [NSMutableArray array] ;
        CGFloat spacing = ([UIScreen mainScreen].bounds.size.width - 1104 - 48 - 40) / 3 ;
        CGFloat wid1 = 268 ;
        CGFloat wid2 = 316 ;
//        CGFloat wid3 = 263 ;
//        CGFloat wid4 = 258 ;
        for (int i = 0 ; i < 4 ; i++) {
            UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:[NSString stringWithFormat:@"page2_img%d", i+1]]] ;
//            imgView.layer.speed = 0 ;
            [self addSubview:imgView] ;
            [tempArr addObject:imgView] ;
        }
        self.page2ImgeArr = [NSArray arrayWithArray:tempArr] ;
        [self.page2ImgeArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0) ;  //for animation
            make.left.equalTo(self.mas_left).with.offset(48) ;
            make.width.mas_equalTo(wid1) ;
            make.height.mas_equalTo(@198) ;
        }] ;
        [self.page2ImgeArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0) ;
            make.left.equalTo(self.mas_left).with.offset(spacing + 48 + 268) ;
            make.width.mas_equalTo(@316) ;
            make.height.mas_equalTo(@243) ;
        }];
        [self.page2ImgeArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0) ;
            make.left.equalTo(self.mas_left).with.offset(spacing * 2 + 48 + wid1 + wid2) ;
            make.width.mas_equalTo(@262) ;
            make.height.mas_equalTo(@274) ;
        }];
        [self.page2ImgeArr[3] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(0) ;
            make.right.equalTo(self.mas_right).with.offset(-40) ;
            make.width.mas_equalTo(@258) ;
            make.height.mas_equalTo(@246) ;
        }];
        self.page2TextView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page2_text"]] ;
        [self addSubview:self.page2TextView] ;
        [self.page2TextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(131) ;
            make.bottom.equalTo(self.mas_bottom).with.offset(-138) ;
            make.width.mas_equalTo(@1100) ;
            make.height.mas_equalTo(@201) ;
        }];
        [self layoutIfNeeded] ;
        self.page2ImgViewInitPosY = self.page2ImgeArr[0].center.y ;
    }
    if(page == 3){
        self.page3ImgView1 = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page3_img1"]] ;
        self.page3ImgView1.layer.speed = 0;
        [self addSubview:self.page3ImgView1] ;
        [self.page3ImgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(208) ;
            make.left.equalTo(self.mas_left).with.offset(133) ;
            make.width.mas_equalTo(@432) ;
            make.height.mas_equalTo(@471) ;
        }];
        self.page3ImgView2 = [[UIImageView alloc ] initWithImage:[UIImage getBundleImageName:@"page3_img2"]] ;
        self.page3ImgView2.layer.speed = 0;
        [self addSubview:self.page3ImgView2] ;
        [self.page3ImgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-67) ;
            make.bottom.equalTo(self.mas_bottom).with.offset(-47) ;
            make.width.mas_equalTo(@624) ;
            make.height.mas_equalTo(@417) ;
        }];
        self.page3TextView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page3_text"]] ;
        self.page3TextView.layer.speed = 0;
        [self addSubview:self.page3TextView] ;
        [self.page3TextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(353) ;
            make.right.equalTo(self.mas_right).with.offset(-223) ;
            make.width.mas_equalTo(@359) ;
            make.height.mas_equalTo(@124) ;
        }];
    }
    if(page == 4){
        self.page4ImgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page4_img"]] ;
        [self addSubview:self.page4ImgView] ;
        [self.page4ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(165) ;
            make.left.equalTo(self.mas_left).with.offset(73) ;
            make.width.mas_equalTo(@611) ;
            make.height.mas_equalTo(@396) ;
        }];
        self.page4TextView1 = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page4_text1"]] ;
        [self addSubview:self.page4TextView1] ;
        [self.page4TextView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(133) ;
            make.bottom.equalTo(self.mas_bottom).with.offset(-141) ;
            make.width.mas_equalTo(@395) ;
            make.height.mas_equalTo(@145) ;
        }];
        self.page4TextView2 = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page4_text2"]] ;
        [self addSubview:self.page4TextView2] ;
        [self.page4TextView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-156) ;
            make.bottom.equalTo(self.mas_bottom).with.offset(-137) ;
            make.width.mas_equalTo(@444) ;
            make.height.mas_equalTo(@393) ;
        }];
        [self layoutIfNeeded];
        self.page4TopInitPos = self.TopImgView.layer.position;
    }
    if(page == 5){
        self.page5TextView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page5_text"]] ;
        [self addSubview:self.page5TextView] ;
        [self.page5TextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(261) ;
            make.left.equalTo(self.mas_left).with.offset(103) ;
            make.width.mas_equalTo(@470) ;
            make.height.mas_equalTo(@394) ;
        }];
        self.page5ImgView1 = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page5_img1"]] ;
        [self addSubview:self.page5ImgView1] ;
        [self.page5ImgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-114) ;
            make.centerX.equalTo(self.page5TextView.mas_centerX) ;
            make.width.mas_equalTo(@461) ;
            make.height.mas_equalTo(@231) ;
        }];
        self.page5ImgView2 = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page5_img2"]] ;
        [self addSubview:self.page5ImgView2] ;
        [self.page5ImgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-123) ;
            make.top.equalTo(self.mas_top).with.offset(309) ;
            make.width.mas_equalTo(@569) ;
            make.height.mas_equalTo(@498) ;
        }];
    }
    if(page == 6){
        self.page6ImgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page6_img"]] ;
        [self addSubview:self.page6ImgView] ;
        [self.page6ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(119) ;
            make.top.equalTo(self.mas_top).with.offset(338) ;
            make.width.mas_equalTo(@581) ;
            make.height.mas_equalTo(@549) ;
        }];
        self.page6TextView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page6_text"]] ;
        [self addSubview:self.page6TextView] ;
        [self.page6TextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(421) ;
            make.right.equalTo(self.mas_right).with.offset(-159) ;
            make.width.mas_equalTo(@470) ;
            make.height.mas_equalTo(@432) ;
        }];
    }
    if(page == 7){
        self.page7ImgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page7_img"]] ;
        [self addSubview:self.page7ImgView] ;
        [self.page7ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(261) ;
            make.left.equalTo(self.mas_left).with.offset(133) ;
            make.width.mas_equalTo(@487) ;
            make.height.mas_equalTo(@583) ;
        }];
        self.page7TextView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page7_text"]] ;
        [self addSubview:self.page7TextView] ;
        [self.page7TextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(414) ;
            make.right.equalTo(self.mas_right).with.offset(-126) ;
            make.width.mas_equalTo(@508) ;
            make.height.mas_equalTo(@278) ;
        }];
    }
    if(page == 8){
//        NSString * bdPath = [[NSBundle mainBundle] pathForResource:@"resourceBundle" ofType:@"bundle"] ;
//        NSBundle * bundle = [NSBundle bundleWithPath:bdPath] ;
        self.page8ImgView1 = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page8_img1"]] ;
        [self addSubview:self.page8ImgView1] ;
        [self.page8ImgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(97) ;
            make.left.equalTo(self.mas_left).with.offset(188) ;
            make.width.mas_equalTo(@423) ;
            make.height.mas_equalTo(@337) ;
        }];
//        self.page8ImgView2 = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page8_img2"]] ;
//        UIImage * img2 = [UIImage getBundleImageName:@"page8_img2"
//                                    inBundle:bundle
//               compatibleWithTraitCollection:nil] ;
        self.page8ImgView2 = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page8_img2"]] ;
        [self addSubview:self.page8ImgView2] ;
        [self.page8ImgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(318) ;
            make.right.equalTo(self.mas_right).with.offset(-194) ;
            make.width.mas_equalTo(@451) ;
            make.height.mas_equalTo(@256) ;
        }];
        self.page8ImgView3 = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page8_img3"]] ;
        [self addSubview:self.page8ImgView3] ;
        [self.page8ImgView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-61) ;
            make.right.equalTo(self.mas_right).with.offset(-143) ;
            make.width.mas_equalTo(@416) ;
            make.height.mas_equalTo(@310) ;
        }];
        self.page8TextView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"page8_text"]] ;
        [self addSubview:self.page8TextView] ;
        [self.page8TextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(108) ;
            make.bottom.equalTo(self.mas_bottom).with.offset(-82) ;
            make.width.mas_equalTo(@517) ;
            make.height.mas_equalTo(@433) ;
        }];
    }
    [BundleLoader uninitFrameworkBundle] ;
}

- (void)setTimeOffset:(CGFloat)timeOffset{
    _timeOffset = timeOffset ;
    if(self.page == 1){
        self.page1TextView.layer.timeOffset = timeOffset ;
        self.page1ImgView.layer.timeOffset = timeOffset ;
        self.page1TextAnim.timeOffset = timeOffset ;
        self.page1ImgAnim.timeOffset = timeOffset ;
    }
    if(self.page == 2 && timeOffset == 1){
//        for(UIImageView * imgView in self.page2ImgeArr){
//            imgView.layer.timeOffset = timeOffset ;
//        }
//        self.page2ImgAnim.timeOffset = timeOffset ;
        CAAnimation * an = self.page2ImgAnim ;
    }
    if(self.page == 3){
        self.page3ImgView1.layer.timeOffset = timeOffset;
        self.page3ImgView2.layer.timeOffset = timeOffset;
        self.page3ImgAnim.timeOffset = timeOffset;
    }
}

- (void)setPage3LabelOffset:(CGFloat)page3LabelOffset{
    _page3LabelOffset = page3LabelOffset;
    self.page3TextView.layer.timeOffset = page3LabelOffset;
    self.page3LabelAnim.timeOffset = page3LabelOffset;
}

- (CABasicAnimation *)page1ImgAnim{
    if(!_page1ImgAnim){
        _page1ImgAnim = [CABasicAnimation animation] ;
        _page1ImgAnim.keyPath = @"position" ;
        _page1ImgAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.page1InitImgPos.x, self.page1InitImgPos.y + 3000)] ;
        _page1ImgAnim.toValue = [NSValue valueWithCGPoint:self.page1InitImgPos] ;
        _page1ImgAnim.duration = 1 ;
        [self.page1ImgView.layer addAnimation:_page1ImgAnim forKey:nil] ;
    }
    return _page1ImgAnim ;
}

- (CABasicAnimation *)page1TextAnim{
    if(!_page1TextAnim){
        _page1TextAnim = [CABasicAnimation animation] ;
        _page1TextAnim.keyPath = @"position" ;
        CGPoint pos = self.page1TextView.layer.position ;
        _page1TextAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(pos.x, pos.y + 1500)] ;
        _page1TextAnim.toValue = [NSValue valueWithCGPoint:pos] ;
        _page1TextAnim.duration = 1 ;
        [self.page1TextView.layer addAnimation:_page1TextAnim forKey:nil] ;
    }
    return _page1TextAnim ;
}

- (CAAnimation *)page2ImgAnim{
    if(!_page2ImgAnim){
        CABasicAnimation * tran = [CABasicAnimation animation] ;
        tran.keyPath = @"transform.translation.y" ;
        tran.toValue = [NSNumber numberWithFloat:-100] ;
//        tran.fromValue = [NSNumber numberWithFloat:self.center.y + 200] ;
        tran.duration = 1 ;
        tran.removedOnCompletion = NO ;
        tran.fillMode = kCAFillModeForwards ;
        CABasicAnimation * opa = [CABasicAnimation animation] ;
        opa.keyPath = @"opacity" ;
//        opa.toValue = [NSNumber numberWithFloat:1] ;
//        opa.fromValue = [NSNumber numberWithFloat:0] ;
//        opa.duration = 100 ;
        CAAnimationGroup * group = [CAAnimationGroup animation] ;
        group.animations = @[tran, opa] ;
//        group.duration = 1 ;
        _page2ImgAnim = group ;
        for(UIImageView * imgView in self.page2ImgeArr){
            [imgView.layer addAnimation:_page2ImgAnim forKey:nil] ;
//            CGPoint pos = imgView.layer.position ;
//            pos.y -= 100 ;
//            imgView.layer.position = pos ;
        }
    }
    return _page2ImgAnim ;
}

- (CAAnimation *)page3ImgAnim{
    if(!_page3ImgAnim){
        CABasicAnimation * tran = [CABasicAnimation animation];
        _page3ImgAnim = tran;
        tran.keyPath = @"transform.translation.y";
        tran.toValue = @(0);
//        tran.keyPath = @"position";
        tran.duration = 1;
        [self.page3ImgView1.layer addAnimation:tran forKey:nil];
        [self.page3ImgView2.layer addAnimation:tran forKey:nil];
    }
    return _page3ImgAnim;
}

- (CAAnimation *)page3LabelAnim{
    if(!_page3LabelAnim){
        CABasicAnimation * tran = [CABasicAnimation animation];
        _page3LabelAnim = tran;
        tran.keyPath = @"transform.translation.y";
        tran.toValue = @(-500);
        tran.duration = 1;
        [self.page3TextView.layer addAnimation:tran forKey:nil];
    }
    return _page3LabelAnim;
}
@end
