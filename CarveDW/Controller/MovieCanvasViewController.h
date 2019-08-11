//
//  MovieCanvasViewController.h
//  CarveDW
//
//  Created by 张储祺 on 2019/8/4.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCanvasViewController : UIViewController
@property(nonatomic, strong)UIImageView * bgView;
@property(nonatomic, assign)NSInteger tag;       //1: 拜年, 3: 新年快乐, 2: 求婚
@end

NS_ASSUME_NONNULL_END
