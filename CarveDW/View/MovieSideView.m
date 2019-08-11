//
//  MovieSideView.m
//  CarveDW
//
//  Created by 张储祺 on 2019/8/4.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "MovieSideView.h"
#import <Masonry.h>
#import "UIImage+Bundle.h"
@implementation MovieSideView
const float imgHeading = 33.0;
const float imgSpacing = 20.0;
const float imgTailing = 37.0;
const float imgSize = 177.5;
- (instancetype)initWithType:(SideViewType)type{
    self = [super initWithFrame:CGRectMake(0, 0, 445, 445)];
    if(self){
        self.type = type;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
        self.layer.cornerRadius = 30.f;
        //arr
        NSMutableArray * tempArr = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            UIImageView * imgView = [[UIImageView alloc] init];
            imgView.userInteractionEnabled = YES;
            [self addSubview:imgView];
            [tempArr addObject:imgView];
        }
        self.imgArr = [NSArray arrayWithArray:tempArr];
        //
        [self.imgArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(imgHeading);
            make.left.equalTo(self.mas_left).with.offset(imgHeading);
            make.height.width.mas_equalTo(imgSize);
        }];
        [self.imgArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(imgHeading);
            make.right.equalTo(self.mas_right).with.offset(-imgTailing);
            make.height.width.mas_equalTo(imgSize);
        }];
        [self.imgArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-imgTailing);
            make.left.equalTo(self.mas_left).with.offset(imgHeading);
            make.height.width.mas_equalTo(imgSize);
        }];
        [self.imgArr[3] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(-imgTailing);
            make.right.equalTo(self.mas_right).with.offset(-imgTailing);
            make.height.width.mas_equalTo(imgSize);
        }];
    }
    if(type == SideViewTypeBackground){
        [self setbgImage];
    }
    else{
        
    }
    return self;
}

- (void)setbgImage{
    for(int i = 0; i < 4; i++){
        self.imgArr[i].image = [UIImage getBundleImageName:[NSString stringWithFormat:@"bgCard_thum_%d", i+1]];
    }
}

- (void)setLabelImageWithTag:(NSInteger)tag{
    for(int i = 0; i < 4; i++){
        self.imgArr[i].image = [UIImage getBundleImageName:[NSString stringWithFormat:@"labelCard_thum_%ld_%d", (long)tag, i+1]];
    }
}
@end
