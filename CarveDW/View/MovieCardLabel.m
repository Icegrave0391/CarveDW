//
//  MovieCardLabel.m
//  CarveDW
//
//  Created by 张储祺 on 2019/8/5.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "MovieCardLabel.h"

@implementation MovieCardLabel

-(instancetype)initWithImage:(UIImage *)img{
    self = [super initWithFrame:CGRectMake(200, 200, img.size.width/4, img.size.height/4)];
    if(self){
        self.dragEnable = YES;
        self.backgroundColor = [UIColor clearColor];
        self.imageView = [[UIImageView alloc] initWithImage:img];
        [self addSubview:self.imageView];
        self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }
    return self;
}

@end
