//
//  UIImage+Bundle.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/19.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "UIImage+Bundle.h"

@implementation UIImage (Bundle)
+ (UIImage *)getBundleImageName:(NSString *)imgName{
    //get bundle
    NSString * bdPath = [[NSBundle mainBundle] pathForResource:@"resourceBundle" ofType:@"bundle"] ;
    NSBundle * bundle = [NSBundle bundleWithPath:bdPath] ;
    //get image from file
    UIImage * img = [UIImage imageWithContentsOfFile:[bundle pathForResource:imgName ofType:@"png"]] ;
    return img ;
}

+ (UIImage *)getBundleGifName:(NSString *)gifName{
    //get bundle
    NSString * bdPath = [[NSBundle mainBundle] pathForResource:@"resourceBundle" ofType:@"bundle"] ;
    NSBundle * bundle = [NSBundle bundleWithPath:bdPath] ;
    //get image from file
    UIImage * img = [UIImage imageWithContentsOfFile:[bundle pathForResource:gifName ofType:@"gif"]] ;
    return img ;
}
@end
