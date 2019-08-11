//
//  MovieCardLabel.h
//  CarveDW
//
//  Created by 张储祺 on 2019/8/5.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "WMDragView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieCardLabel : WMDragView
@property(nonatomic, strong)UIImageView * labelImg;

- (instancetype)initWithImage:(UIImage *)img;
@end

NS_ASSUME_NONNULL_END
