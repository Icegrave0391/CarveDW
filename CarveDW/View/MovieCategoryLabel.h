//
//  MovieCategoryLabel.h
//  CarveDW
//
//  Created by 张储祺 on 2019/8/1.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCategoryLabel : UIView

@property(nonatomic, strong)UILabel * textLabel;
@property(nonatomic, strong)UIView * line;
@property(nonatomic, assign)BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
