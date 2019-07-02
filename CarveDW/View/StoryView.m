//
//  StoryView.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/29.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "StoryView.h"
#import "UIImage+Bundle.h"
@implementation StoryView
- (instancetype)initWithNumber:(NSInteger)storyNum{
    if(storyNum == 1){
        self = [super initWithFrame:CGRectMake(0, 0, 447, 647)] ;
        [self setImage:[UIImage getBundleImageName:@"story_fstView"]] ;
//        self.contentMode = UIViewContentModeScaleAspectFit ;
    }
    else if(storyNum == 2){
        self = [super initWithFrame:CGRectMake(0, 0, 450, 646)] ;
        [self setImage:[UIImage getBundleImageName:@"story_secView"]] ;
    }
    else{
        self = [super initWithFrame:CGRectMake(0, 0, 403, 643)] ;
        [self setImage:[UIImage getBundleImageName:@"story_thrView"]] ;
    }
//    self.transform = CGAffineTransformMakeScale(0.1, 0.1) ;
    self.isShow = NO ;
    return self ;
}

- (void)setIsShow:(BOOL)isShow{
    _isShow = isShow ;
    if(isShow){
        [UIView animateWithDuration:0.5f animations:^{
            self.transform = CGAffineTransformMakeScale(1.f, 1.f) ;
            self.alpha = 1 ;
        } completion:nil] ;
    }
    else{
        [UIView animateWithDuration:0.f animations:^{
            self.alpha = 0 ;
            self.transform = CGAffineTransformMakeScale(0.1, 0.1) ;
        } completion:nil];
    }
}
@end
