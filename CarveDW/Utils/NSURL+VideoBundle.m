//
//  NSURL+VideoBundle.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/28.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "NSURL+VideoBundle.h"

@implementation NSURL (VideoBundle)

+ (NSURL *)videoURLWithName:(NSString *)videoName andType:(nonnull NSString *)type{
    NSString * bdPath = [[NSBundle mainBundle] pathForResource:@"resourceBundle" ofType:@"bundle"] ;
    NSBundle * bundle = [NSBundle bundleWithPath:bdPath] ;
    NSString * videoPath = [bundle pathForResource:videoName ofType:type] ;
    return [NSURL fileURLWithPath:videoPath] ;
}

+ (NSURL *)videoURLWithMainBundle:(NSString *)videoName andType:(NSString *)type{
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:videoName ofType:type]];
}
@end
