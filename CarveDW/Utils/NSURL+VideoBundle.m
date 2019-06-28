//
//  NSURL+VideoBundle.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/28.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "NSURL+VideoBundle.h"

@implementation NSURL (VideoBundle)

+ (NSURL *)videoURLWithName:(NSString *)videoName{
    NSString * bdPath = [[NSBundle mainBundle] pathForResource:@"resourceBundle" ofType:@"bundle"] ;
    NSBundle * bundle = [NSBundle bundleWithPath:bdPath] ;
    NSString * videoPath = [bundle pathForResource:videoName ofType:@"mp4"] ;
    return [NSURL fileURLWithPath:videoPath] ;
}

@end
