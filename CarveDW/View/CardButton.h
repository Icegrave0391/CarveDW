//
//  CardButton.h
//  CarveDW
//
//  Created by 张储祺 on 2019/6/30.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardButton : UIImageView
@property(nonatomic, assign)BOOL isSelected ;
@property(nonatomic, assign)NSInteger flag ;

- (instancetype)initWithFlag:(NSInteger)flag ;
@end

NS_ASSUME_NONNULL_END
