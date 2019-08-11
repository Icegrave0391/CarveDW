//
//  CardView.m
//  CarveDW
//
//  Created by 张储祺 on 2019/7/6.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "CardView.h"
#import "UIImage+Bundle.h"
#import <Masonry.h>
const float kVerHeight = 1469.0 / 2;
const float kVerWidth = 798.0 / 2;
const float kHorHeight = 1498.0 / 2;
const float kHorWidth = 2238.0 / 2;

@implementation CardView
- (instancetype)initWithName:(NSString *)name andNumber:(NSInteger)number{
    self = [super init] ;
    if(self){
        self.imgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:[NSString stringWithFormat:@"hb_%ld", (long)number]]] ;
        _number = number ;
        if(number <= 6){
            [self setFrame:CGRectMake(0, 0, kVerWidth, kVerHeight)] ;
            [self.imgView setFrame:CGRectMake(0, 0, kVerWidth, kVerHeight)] ;
            [self addSubview:self.imgView] ;
            self.frameSize = CGSizeMake(kVerWidth, kVerHeight) ;
        }
        else{
            [self setFrame:CGRectMake(0, 0, kHorWidth, kHorHeight)] ;
            [self.imgView setFrame:self.frame] ;
            [self addSubview:self.imgView] ;
            self.frameSize = CGSizeMake(kHorWidth, kHorHeight) ;
        }
        //label
        self.label = [[UILabel alloc] init] ;
        [self addSubview:self.label] ;
        UIFont * fnt = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:21] ;
        self.label.font = fnt ;
        self.label.textColor = [UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1] ;
        self.label.text = name ;
        CGSize size = [self.label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt, NSFontAttributeName, nil]] ;
        CGFloat wid = size.width + 20 ;
        size = CGSizeMake(wid, size.height) ;
        [self addSubview:self.label] ;
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(size.width) ;
            make.height.mas_equalTo(size.height) ;
            make.right.equalTo(self.mas_right).with.offset(-50) ;
            make.bottom.equalTo(self.mas_bottom).with.offset(-100) ;
        }];
    }
    return self ;
}

@end
