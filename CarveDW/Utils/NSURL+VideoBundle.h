//
//  NSURL+VideoBundle.h
//  CarveDW
//
//  Created by 张储祺 on 2019/6/28.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (VideoBundle)

+(NSURL *)videoURLWithName:(NSString *)videoName andType:(NSString *)type;
+ (NSURL *)videoURLWithMainBundle:(NSString *)videoName andType:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
