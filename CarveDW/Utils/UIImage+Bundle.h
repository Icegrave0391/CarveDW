//
//  UIImage+Bundle.h
//  CarveDW
//
//  Created by 张储祺 on 2019/6/19.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Bundle)
+ (UIImage *)getBundleImageName:(NSString *)imgName ;
+ (UIImage *)getBundleGifName:(NSString *)gifName;
@end

NS_ASSUME_NONNULL_END
