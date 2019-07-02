//
//  CreatCardViewController.h
//  CarveDW
//
//  Created by 张储祺 on 2019/6/30.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardButton.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, CardState) {
    CardStateCard = 0,
    CardStateMoji
};

@interface CreatCardViewController : UIViewController
@property(nonatomic, assign)CardState state ;
@property(nonatomic, assign)BOOL isInitial ;

- (instancetype)init ;

@end

NS_ASSUME_NONNULL_END
