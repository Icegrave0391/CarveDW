//
//  CardInitGenderView.m
//  CarveDW
//
//  Created by 张储祺 on 2019/7/1.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "CardInitGenderView.h"
#import "UIImage+Bundle.h"
#import <Masonry.h>
@implementation CardInitGenderView
- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, 525, 273)] ;
    if(self){
        self.userInteractionEnabled = YES ;
        self.gender = GenderNotSelected ;
        [self setUpUI] ;
    }
    return self ;
}

- (void)setUpUI{
    self.maleBgView = ({
        UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"gender_notSel"]] ;
        imgView.userInteractionEnabled = YES ;
        [self addSubview:imgView] ;
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left) ;
            make.top.equalTo(self.mas_top) ;
            make.width.mas_equalTo(@251) ;
            make.height.mas_equalTo(@273) ;
        }];
        imgView ;
    });
    self.femaleBgView = ({
        UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"gender_notSel"]] ;
        imgView.userInteractionEnabled = YES ;
        [self addSubview:imgView] ;
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right) ;
            make.top.equalTo(self.mas_top) ;
            make.width.mas_equalTo(@251) ;
            make.height.mas_equalTo(@273) ;
        }];
        imgView ;
    });
    self.maleView = ({
        UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"genderMale_notSel"]] ;
        imgView.userInteractionEnabled = YES ;
        [self addSubview:imgView] ;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(genderBtnClicked:)] ;
        [imgView addGestureRecognizer:tap] ;
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left) ;
            make.top.equalTo(self.mas_top) ;
            make.width.mas_equalTo(@251) ;
            make.height.mas_equalTo(@273) ;
        }];
        imgView ;
    });
    self.femaleView = ({
        UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"genderFemale_notSel"]] ;
        imgView.userInteractionEnabled = YES ;
        [self addSubview:imgView] ;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(genderBtnClicked:)] ;
        [imgView addGestureRecognizer:tap] ;
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left) ;
            make.top.equalTo(self.mas_top) ;
            make.width.mas_equalTo(@251) ;
            make.height.mas_equalTo(@273) ;
        }];
        imgView ;
    });
}

- (void)genderBtnClicked:(UIImageView *)imgView{
    if(imgView == self.maleView){
        self.gender = GenderMale ;
        self.maleView.image = [UIImage getBundleImageName:@"genderMale_sel"] ;
        self.maleBgView.image = [UIImage getBundleImageName:@"gender_sel"] ;
        self.femaleView.image = [UIImage getBundleImageName:@"genderFemale_notSel"] ;
        self.femaleBgView.image = [UIImage getBundleImageName:@"gender_notSel"] ;
    }
    else{
        self.gender = GenderFemale ;
        self.maleView.image = [UIImage getBundleImageName:@"genderMale_notSel"] ;
        self.maleBgView.image = [UIImage getBundleImageName:@"gender_notSel"] ;
        self.femaleView.image = [UIImage getBundleImageName:@"genderFemale_sel"] ;
        self.femaleBgView.image = [UIImage getBundleImageName:@"gender_sel"] ;
    }
}
@end
