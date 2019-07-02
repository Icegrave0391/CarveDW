//
//  StoryView.h
//  CarveDW
//
//  Created by 张储祺 on 2019/6/29.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoryView : UIImageView
@property(nonatomic, assign)BOOL isShow ;

- (instancetype)initWithNumber:(NSInteger)storyNum ;
//- (void)showView ;
@end

NS_ASSUME_NONNULL_END
