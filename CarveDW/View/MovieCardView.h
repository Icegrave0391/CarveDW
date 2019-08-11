//
//  MovieCardView.h
//  CarveDW
//
//  Created by 张储祺 on 2019/8/3.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCardView : UIView

@property(nonatomic, strong)UIImageView * imgView;
@property(nonatomic, strong)UIImageView * labelView;

- (instancetype)init;

- (void)changeImg:(UIImage *)img andLabelImg:(UIImage *)labelImg;
@end

NS_ASSUME_NONNULL_END
