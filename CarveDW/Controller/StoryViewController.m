//
//  StoryViewController.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/28.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "StoryViewController.h"
#import <Masonry.h>
@interface StoryViewController ()

@property(nonatomic, assign)CMTime playTime ;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view.layer addSublayer:self.playerLayer] ;
    //loop movie
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(replayVideo:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil] ;
    //UI
    [self setUpUI] ;
}

- (AVPlayerLayer *)playerLayer{
    if(!_playerLayer){
        NSURL * movieURL = [NSURL videoURLWithName:@"故事"] ;
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:[[AVPlayer alloc] initWithURL: movieURL]] ;
        _playerLayer.frame = [UIScreen mainScreen].bounds ;
        __weak typeof (self) weakSelf = self ;
        [_playerLayer.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            weakSelf.playTime = time ;
        }];
        [_playerLayer.player play] ;
    }
    return _playerLayer ;
}

- (void)replayVideo:(NSNotification *)notification{
    [self.playerLayer.player seekToTime:CMTimeMake(0, 1)] ;
    [self.playerLayer.player play] ;
}

- (void)setUpUI{
    //navigation
    UIButton * retBtn = [[UIButton alloc] init] ;
    [self.view addSubview:retBtn] ;
    [retBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).with.offset(42) ;
        make.width.height.mas_equalTo(@42) ;
    }];
    [retBtn setImage:[UIImage imageNamed:@"retNav"] forState:UIControlStateNormal] ;
    [retBtn addTarget:self action:@selector(navigationReturn) forControlEvents:UIControlEventTouchUpInside] ;
}

- (void)setPlayTime:(CMTime)playTime{
    _playTime = playTime ;
//    if()
}
- (void)navigationReturn{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
@end
