//
//  CardButton.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/30.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "CardButton.h"

@implementation CardButton

- (instancetype)initWithFlag:(NSInteger)flag{
    self = [super init] ;
    if(self){
        self.userInteractionEnabled = YES ;
        self.flag = flag ;
    }
    return self ;
}

- (void)setFlag:(NSInteger)flag{
    _flag = flag ;
    //个性卡
    if(flag == 1){
        self.image = [UIImage imageNamed:@"card_card"] ;
    }else{
        self.image = [UIImage imageNamed:@"card_moji"] ;
    }
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected ;
    if(isSelected){
        if(self.tag == 1){
            self.image = [UIImage imageNamed:@"card_cardSel"] ;
        }
        else{
            self.image = [UIImage imageNamed:@"card_mojiSel"] ;
        }
    }
    else{
        if(self.tag == 1){
            self.image = [UIImage imageNamed:@"card_card"] ;
        }
        else{
            self.image = [UIImage imageNamed:@"card_moji"] ;
        }
    }
}
@end
