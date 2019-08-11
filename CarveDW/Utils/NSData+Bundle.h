//
//  NSData+Bundle.h
//  CarveDW
//
//  Created by 张储祺 on 2019/8/7.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Bundle)

+(NSData *)getGifDataWithBundle:(NSString *)gifName;

@end

NS_ASSUME_NONNULL_END
