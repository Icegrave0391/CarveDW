//
//  StoryViewController.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/28.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "StoryViewController.h"
#import <Masonry.h>
#import "UIImage+Bundle.h"
#import "StoryView.h"
@interface StoryViewController ()

//@property(nonatomic, assign)CMTime playTime ;
@property(nonatomic, assign)NSTimeInterval playTime ;
@property(nonatomic, strong)UIButton * fstViewButton ;
@property(nonatomic, strong)UIButton * secViewButton ;
@property(nonatomic, strong)UIButton * thrViewButton ;
@property(nonatomic, strong)UIView * dimView ;
@property(nonatomic, strong)NSArray <StoryView * >* storyViewArr ;
@property(nonatomic, strong)StoryView * currentStoryView ;
@property(nonatomic, strong)UIButton * currentButton ;
@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view.layer addSublayer:self.playerLayer] ;
    //return navigation
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(navigationReturn)
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
            weakSelf.playTime = time.value / time.timescale ;
        }];
        [_playerLayer.player play] ;
    }
    return _playerLayer ;
}

//- (void)replayVideo:(NSNotification *)notification{
//    [self.playerLayer.player seekToTime:CMTimeMake(0, 1)] ;
//    self.playTime = 0 ;
//    [self.playerLayer.player play] ;
//}

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
    //UIButton
    self.fstViewButton = ({
        UIButton * button = [[UIButton alloc] init] ;
        [button setImage:[UIImage getBundleImageName:@"story_fstButton"] forState:UIControlStateNormal] ;
        [self.view addSubview:button] ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@98) ;
            make.height.mas_equalTo(@285) ;
            make.top.equalTo(self.view.mas_top).with.offset(58) ;
            make.right.equalTo(self.view.mas_right).with.offset(-52) ;
        }];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside] ;
        button.alpha = 0 ;
        button.tag = 1 ;
        button ;
    });
    self.secViewButton = ({
        UIButton * button = [[UIButton alloc] init] ;
        [button setImage:[UIImage getBundleImageName:@"story_secButton"] forState:UIControlStateNormal] ;
        [self.view addSubview:button] ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@100) ;
            make.height.mas_equalTo(@251) ;
            make.top.equalTo(self.view.mas_top).with.offset(90) ;
            make.left.equalTo(self.view.mas_left).with.offset(90) ;
        }];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside] ;
        button.alpha = 0 ;
        button.tag = 2 ;
        button ;
    });
    self.thrViewButton = ({
        UIButton * button = [[UIButton alloc] init] ;
        [button setImage:[UIImage getBundleImageName:@"story_thrButton"] forState:UIControlStateNormal] ;
        [self.view addSubview:button] ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@100) ;
            make.height.mas_equalTo(@251) ;
            make.top.equalTo(self.view.mas_top).with.offset(58 + 50) ;
            make.right.equalTo(self.view.mas_right).with.offset(-52) ;
        }];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside] ;
        button.alpha = 0 ;
        button.tag = 3 ;
        button ;
    });
    //story view
    NSMutableArray * tempArr = [NSMutableArray array] ;
    for(int i = 0 ; i < 3 ; i++){
        StoryView * storyview = [[StoryView alloc] initWithNumber:i+1] ;
        [self.view addSubview:storyview] ;
        [tempArr addObject:storyview] ;
    }
    self.storyViewArr = [NSArray arrayWithArray:tempArr] ;
    [self.storyViewArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fstViewButton.mas_top) ;
        make.right.equalTo(self.fstViewButton.mas_right) ;
        make.width.mas_equalTo(@447) ;
        make.height.mas_equalTo(@647) ;
    }];
    [self.storyViewArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secViewButton.mas_top) ;
        make.left.equalTo(self.secViewButton.mas_left) ;
        make.width.mas_equalTo(@450) ;
        make.height.mas_equalTo(@646) ;
    }];
    [self.storyViewArr[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thrViewButton.mas_top) ;
        make.right.equalTo(self.thrViewButton.mas_right) ;
        make.width.mas_equalTo(@403) ;
        make.height.mas_equalTo(@643) ;
    }];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStoryView)] ;
//    [tap addTarget:self action:] ;
    self.view.userInteractionEnabled = YES ;
    [self.view addGestureRecognizer:tap] ;
}
- (void)setPlayTime:(NSTimeInterval)playTime{
    _playTime = playTime ;
    if(_playTime == 0){
        [self setInitButtonUI] ;
    }
    if(_playTime < 9){
        self.secViewButton.alpha = 0 ;
        self.thrViewButton.alpha = 0 ;
        self.fstViewButton.alpha = 1 ;
    }
    if(_playTime == 9){
        [UIView animateWithDuration:1.f animations:^{
            CGPoint center = self.fstViewButton.center ;
            center.x -= [UIScreen mainScreen].bounds.size.width ;
            self.fstViewButton.center = center ;
        } completion:nil] ;
    }
    if(_playTime == 10){
        [UIView animateWithDuration:1.5f
                         animations:^{
                             self.secViewButton.alpha = 1 ;
        }
                         completion:nil] ;
    }
    if(_playTime == 16){
        [UIView animateWithDuration:1.5f animations:^{
            self.secViewButton.alpha = 0 ;
        } completion:nil] ;
    }
    if(_playTime == 18){
        [UIView animateWithDuration:1.5f animations:^{
            CGPoint center = self.thrViewButton.center ;
            center.y -= 50 ;
            self.thrViewButton.center = center ;
            self.thrViewButton.alpha = 1 ;
        } completion:nil] ;
    }
}

- (void)buttonClicked:(UIButton *)sender{
    [self.playerLayer.player pause] ;
    NSInteger tag = sender.tag ;
    self.currentButton = sender ;
    [UIView animateWithDuration:0.5 animations:^{
        sender.transform = CGAffineTransformMakeScale(0.1, 0.1) ;
        sender.alpha = 0 ;
    } completion:^(BOOL finished) {
        self.storyViewArr[tag-1].isShow = YES ;
        self.currentStoryView = self.storyViewArr[tag-1] ;
    }];
}

- (void)tapStoryView{
    if(self.currentStoryView){
        self.currentStoryView.isShow = NO ;
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.currentButton.alpha = 1 ;
            self.currentButton.transform = CGAffineTransformMakeScale(1, 1) ;
        } completion:^(BOOL finished) {
            self.currentButton = nil ;
            self.currentStoryView = nil ;
        }];
        [self.playerLayer.player play] ;
    }
}

- (void)setInitButtonUI{
    [self.fstViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@98) ;
        make.height.mas_equalTo(@285) ;
        make.top.equalTo(self.view.mas_top).with.offset(58) ;
        make.right.equalTo(self.view.mas_right).with.offset(-52) ;
    }];
    [self.secViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@100) ;
        make.height.mas_equalTo(@251) ;
        make.top.equalTo(self.view.mas_top).with.offset(90) ;
        make.left.equalTo(self.view.mas_left).with.offset(90) ;
    }];
    [self.thrViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@100) ;
        make.height.mas_equalTo(@251) ;
        make.top.equalTo(self.view.mas_top).with.offset(58 + 50) ;
        make.right.equalTo(self.view.mas_right).with.offset(-52) ;
    }];
}

- (void)navigationReturn{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
@end
