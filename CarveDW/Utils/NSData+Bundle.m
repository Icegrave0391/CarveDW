//
//  NSData+Bundle.m
//  CarveDW
//
//  Created by 张储祺 on 2019/8/7.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "NSData+Bundle.h"

@implementation NSData (Bundle)

+ (NSData *)getGifDataWithBundle:(NSString *)gifName{
    //get bundle
    NSString * bdPath = [[NSBundle mainBundle] pathForResource:@"resourceBundle" ofType:@"bundle"];
    NSBundle * bundle = [NSBundle bundleWithPath:bdPath];
    //get gif data
    NSString * gifPath = [bundle pathForResource:gifName ofType:@"gif"];
    NSData * gifData = [NSData dataWithContentsOfFile:gifPath];
    return gifData;
}

@end
