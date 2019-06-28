//
//  CraftFirstPage.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/17.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "CraftFirstPage.h"
#import <Masonry.h>
@implementation CraftFirstPage
//overwrite init
- (instancetype)init{
    self = [super init] ;
    if(self){
        self.userInteractionEnabled = YES ;
        self.frame = [UIScreen mainScreen].bounds ;
        //robbin top
        _robbinTop = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craft_ribbon"]] ;
        [self addSubview:_robbinTop] ;
        [_robbinTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(65) ;
            make.right.equalTo(self.mas_right) ;
            make.width.mas_equalTo(@593) ;
            make.height.mas_equalTo(@85) ;
        }];
        //robbin bottom
        _robbinBottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craft_ribbon"]] ;
        [self addSubview:_robbinBottom] ;
        [_robbinBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-47) ;
            make.left.equalTo(self.mas_left) ;
            make.width.mas_equalTo(@593) ;
            make.height.mas_equalTo(@85) ;
        }];
        //over view
        _overView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craft_overView"]] ;
        [self addSubview:_overView] ;
        [_overView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-105) ;
            make.top.equalTo(self.mas_top).with.offset(474) ;
            make.width.mas_equalTo(@444) ;
            make.height.mas_equalTo(@272) ;
        }];
        self.overView.layer.speed = 0 ;
        //operateView
        _operateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craft_operateView"]] ;
        [self addSubview:_operateView] ;
        [_operateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(250) ;
            make.left.equalTo(self.mas_left).with.offset(106) ;
            make.width.mas_equalTo(@372) ;
            make.height.mas_equalTo(@465) ;
        }];
        self.operateView.layer.speed = 0 ;
        _timeOffset = 0 ;
    }
    return self ;
}
- (void)setTimeOffset:(CGFloat)timeOffset{
    _timeOffset = timeOffset ;
    //set operate tran timeoffset
//    CABasicAnimation * operateTran = [self.operateView.layer animationForKey:@"operateTran"] ;
//    self.operateTran.timeOffset = timeOffset ;
//    self.operateView.layer.timeOffset = timeOffset ;
//    //set over tran timeoffset
////    CAAnimation * overViewTran = [self.overView.layer animationForKey:@"overViewTran"] ;
//    self.overViewTran.timeOffset = timeOffset ;
//    self.overView.layer.timeOffset = timeOffset ;
//    NSLog(@">>>>>>>>>>>>>>>>>> %f %f", self.operateView.layer.timeOffset, self.operateTran.timeOffset) ;
}

- (CAAnimation *)operateViewTranWithBeginPosition:(CGPoint)position{
    CABasicAnimation * tran = [CABasicAnimation animation] ;
    tran.keyPath = @"position" ;
    CGFloat posY = self.operateView.layer.position.y ;
    CGFloat dis = 250 + self.operateView.layer.frame.size.height ;
//    tran.fromValue = [NSValue valueWithCGPoint:position] ;
    tran.toValue = [NSValue valueWithCGPoint:CGPointMake(self.operateView.layer.position.x, posY - dis)] ;
    tran.duration = 1 ;
    return tran ;
}

- (CAAnimation *)overViewTranWithBeginPosition:(CGPoint)position{
    CABasicAnimation * tran = [CABasicAnimation animation] ;
    tran.keyPath = @"position" ;
    CGFloat posY = self.overView.layer.position.y ;
    CGFloat dis = 474 + self.overView.layer.frame.size.height ;
    tran.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.overView.layer.position.x, posY)] ;
    tran.toValue = [NSValue valueWithCGPoint:CGPointMake(self.overView.layer.position.x, posY - dis)] ;
    tran.duration = 1 ;
    return tran ;
}
//
//- (void)setOperateTran:(CAAnimation *)operateTran{
//    _operateTran = operateTran ;
//    [self.operateView.layer addAnimation:_operateTran forKey:nil] ;
//}
//
//- (void)setOverViewTran:(CAAnimation *)overViewTran{
//    _overViewTran = overViewTran ;
//    [self.overView.layer addAnimation:_overViewTran forKey:nil] ;
//}

@end
