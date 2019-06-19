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
        //operateView
        _operateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craft_operateView"]] ;
        [self addSubview:_operateView] ;
        [_operateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(250) ;
            make.left.equalTo(self.mas_left).with.offset(106) ;
            make.width.mas_equalTo(@372) ;
            make.height.mas_equalTo(@465) ;
        }];
        self.timeOffset = 0 ;
    }
    return self ;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return [self superview]; // return nil;
    // 此处返回nil也可以。返回nil就相当于当前的view不是最合适的view
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"??????????????") ;
    [super touchesBegan:touches withEvent:event];
}
@end
