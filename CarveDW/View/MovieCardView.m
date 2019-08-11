//
//  MovieCardView.m
//  CarveDW
//
//  Created by 张储祺 on 2019/8/3.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "MovieCardView.h"
#import <Masonry.h>
@implementation MovieCardView

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, 330, 465+40+15)];
    if(self){
        self.imgView = ({
            UIImageView * imgView = [[UIImageView alloc] init];
            [self addSubview: imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                make.centerX.equalTo(self.mas_centerX);
                make.height.mas_equalTo(@465);
                make.width.mas_equalTo(@330);
            }];
            imgView;
        });
        self.labelView = ({
            UIImageView * imgView = [[UIImageView alloc] init];
            [self addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom);
                make.left.equalTo(self.mas_left);
                make.height.mas_equalTo(@40);
                make.width.mas_equalTo(@165);
            }];
            imgView;
        });
    }
    return self;
}

- (void)changeImg:(UIImage *)img andLabelImg:(UIImage *)labelImg{
    self.imgView.image = img;
    self.labelView.image = labelImg;
}
@end
