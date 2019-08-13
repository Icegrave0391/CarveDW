//
//  InitViewController.m
//  CarveDW
//
//  Created by 张储祺 on 2019/8/13.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "InitViewController.h"
#import "HomeViewController.h"
@interface InitViewController ()
@property(nonatomic, assign)NSTimeInterval playTime ;
@property(nonatomic, strong)UIView * bgView;
@end

@implementation InitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    [self.bgView.layer addSublayer:self.playerLayer] ;
    //return navigation
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(navigationPush)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil] ;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigationPush)];
    [self.view addGestureRecognizer:tap];
}
- (void)viewWillAppear:(BOOL)animated{
    //    [super viewWillAppear:animated] ;
    [self.navigationController setNavigationBarHidden:YES animated:YES] ;
    [super viewWillAppear:animated] ;
}

- (void)navigationPush{
    [self.playerLayer.player pause];
    HomeViewController * homeVC = [[HomeViewController alloc] init];
    [self presentViewController:homeVC animated:YES completion:nil];
}

- (AVPlayerLayer *)playerLayer{
    if(!_playerLayer){
        NSURL * movieURL = [NSURL videoURLWithName:@"init" andType:@"mov"] ;
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:[[AVPlayer alloc] initWithURL: movieURL]] ;
        _playerLayer.frame = [UIScreen mainScreen].bounds ;
        __weak typeof (self) weakSelf = self ;
        [_playerLayer.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            weakSelf.playTime = time.value / time.timescale ;
        }];
        [_playerLayer.player play] ;
    }
    return _playerLayer ;
}
@end
