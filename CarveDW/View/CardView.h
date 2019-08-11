//
//  CardView.h
//  CarveDW
//
//  Created by 张储祺 on 2019/7/6.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardView : UIView
@property(nonatomic, strong)UIImageView * imgView ;
@property(nonatomic, strong)UILabel * label ;
@property(nonatomic, assign)CGSize frameSize ;
@property(nonatomic, assign)NSInteger number ;

- (instancetype)initWithName:(NSString *)name andNumber:(NSInteger)number ;
//+ (NSArray *)generateAllCardWithName:(NSString *)name ;
@end

NS_ASSUME_NONNULL_END
