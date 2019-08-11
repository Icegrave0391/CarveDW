//
//  MovieSideView.h
//  CarveDW
//
//  Created by 张储祺 on 2019/8/4.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, SideViewType) {
    SideViewTypeLabel = 0,
    SideViewTypeBackground
};
@interface MovieSideView : UIView
@property(nonatomic, assign)SideViewType type;
@property(nonatomic, strong)NSArray <UIImageView *> * imgArr;

-(instancetype)initWithType:(SideViewType)type;
-(void)setLabelImageWithTag:(NSInteger)tag;         //0 : 拜年, 1 : 新年快乐, 2 : 求婚
@end

NS_ASSUME_NONNULL_END
