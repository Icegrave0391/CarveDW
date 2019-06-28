//
//  CraftPageView.h
//  CarveDW
//
//  Created by 张储祺 on 2019/6/17.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CraftPageView : UIView
@property(nonatomic, strong)UIImageView * TopImgView ;
//page1
@property(nonatomic, strong)UIImageView * page1TextView ;
@property(nonatomic, strong)UIImageView * page1ImgView ;
@property(nonatomic, assign)CGPoint page1InitImgPos ;
//page2
@property(nonatomic, strong)NSArray<UIImageView *> * page2ImgeArr ;
@property(nonatomic, strong)UIImageView * page2TextView ;
@property(nonatomic, assign)CGFloat page2ImgViewInitPosY ;
//page3
@property(nonatomic, strong)UIImageView * page3ImgView1 ;
@property(nonatomic, strong)UIImageView * page3ImgView2 ;
@property(nonatomic, strong)UIImageView * page3TextView ;
//page4
@property(nonatomic, strong)UIImageView * page4ImgView ;
@property(nonatomic, strong)UIImageView * page4TextView1 ;
@property(nonatomic, strong)UIImageView * page4TextView2 ;
//page5
@property(nonatomic, strong)UIImageView * page5TextView ;
@property(nonatomic, strong)UIImageView * page5ImgView1 ;
@property(nonatomic, strong)UIImageView * page5ImgView2 ;
//pagr6
@property(nonatomic, strong)UIImageView * page6ImgView ;
@property(nonatomic, strong)UIImageView * page6TextView ;
//page7
@property(nonatomic, strong)UIImageView * page7ImgView ;
@property(nonatomic, strong)UIImageView * page7TextView ;
//page8
@property(nonatomic, strong)UIImageView * page8ImgView1 ;
@property(nonatomic, strong)UIImageView * page8ImgView2 ;
@property(nonatomic, strong)UIImageView * page8ImgView3 ;
@property(nonatomic, strong)UIImageView * page8TextView ;
//core animation timeoffset
@property(nonatomic, assign)NSInteger page ;
@property(nonatomic, assign)CGFloat timeOffset ;
- (instancetype)initWithPage:(NSInteger)page ;
@end

NS_ASSUME_NONNULL_END
