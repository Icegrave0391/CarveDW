//
//  CraftFirstPage.h
//  CarveDW
//
//  Created by 张储祺 on 2019/6/17.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CraftFirstPage : UIView
@property(nonatomic, strong)UIImageView * robbinTop ;
@property(nonatomic, strong)UIImageView * robbinBottom ;
@property(nonatomic, strong)UIImageView * operateView ;
@property(nonatomic, strong)UIImageView * overView ;

//@property(nonatomic, strong)CAAnimation * operateTran ;
//@property(nonatomic, strong)CAAnimation * overViewTran ;
@property(nonatomic, assign)CGFloat timeOffset ;

- (CAAnimation *)operateViewTranWithBeginPosition:(CGPoint)position ;
- (CAAnimation *)overViewTranWithBeginPosition:(CGPoint)position ;

//- (CGPoint)convertInitOperateViewPosition ;
//- (CGPoint)convertInitOverViewPosition ;
@end

NS_ASSUME_NONNULL_END
