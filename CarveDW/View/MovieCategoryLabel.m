//
//  MovieCategoryLabel.m
//  CarveDW
//
//  Created by 张储祺 on 2019/8/1.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "MovieCategoryLabel.h"
#import <Masonry.h>
@implementation MovieCategoryLabel

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, 125, 100)];
    if(self){
        self.isSelected = NO;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.textLabel = ({
        UILabel * label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_top).with.offset(60);
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(@125);
            make.height.mas_equalTo(@60);
        }];
        [label setFont:[UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:40]];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:0 blue:15.0/255.0 alpha:0.5];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    self.line = ({
        UIView * view = [[UIView alloc] init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(@120);
            make.height.mas_equalTo(@5);
        }];
        view.backgroundColor = [UIColor colorWithRed:122.0/255.0 green:0 blue:15.0/255.0 alpha:1];
        view.hidden = YES;
        view;
    });
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if(isSelected){
        self.textLabel.textColor = [UIColor colorWithRed:122.0/255.0 green:0 blue:15.0/255.0 alpha:1];
        self.textLabel.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:60];
        self.line.hidden = NO;
    }
    else{
        [self.textLabel setFont:[UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:40]];
        self.textLabel.textColor = [UIColor colorWithRed:122.0/255.0 green:0 blue:15.0/255.0 alpha:0.5];
        self.line.hidden = YES;
    }
}

@end
