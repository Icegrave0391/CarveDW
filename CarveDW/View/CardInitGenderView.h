//
//  CardInitGenderView.h
//  CarveDW
//
//  Created by 张储祺 on 2019/7/1.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, Gender) {
    GenderNotSelected = 0,
    GenderMale,
    GenderFemale
};
@interface CardInitGenderView : UIView

@property(nonatomic, strong)UIImageView * maleView ;
@property(nonatomic, strong)UIImageView * maleBgView ;
@property(nonatomic, strong)UIImageView * femaleView ;
@property(nonatomic, strong)UIImageView * femaleBgView ;
@property(nonatomic, assign)Gender gender;

- (instancetype)init ;
@end

NS_ASSUME_NONNULL_END
