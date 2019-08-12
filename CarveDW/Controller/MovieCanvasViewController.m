//
//  MovieCanvasViewController.m
//  CarveDW
//
//  Created by 张储祺 on 2019/8/4.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "MovieCanvasViewController.h"
#import <Masonry.h>
#import "UIImage+Bundle.h"
#import "MovieSideView.h"
#import "MovieCardLabel.h"
#import "NSURL+VideoBundle.h"
#import "NSData+Bundle.h"
#import <AVFoundation/AVFoundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <YYAnimatedImageView.h>
#import <YYImage.h>
#import "lame.h"
#define kSandboxPathStr [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define kMp3FileName @"myRecord.mp3"
#define kCafFileName @"myRecord.caf"
@interface MovieCanvasViewController ()<AVAudioPlayerDelegate, AVAudioRecorderDelegate, UIGestureRecognizerDelegate>
@property(nonatomic, strong)NSArray <UIButton *> * sideButtonArr;
@property(nonatomic, strong)UIImageView * sideBar;
@property(nonatomic, strong)MovieSideView * currentSideView;
@property(nonatomic, strong)UIImageView * currentColorView;
@property(nonatomic, strong)NSMutableArray <MovieCardLabel *> * labelArr;
@property(nonatomic, strong)NSMutableArray <MovieCardLabel *> * delCacheArr;

//@property(nonatomic, strong)AVPlayerLayer * playerLayer;
@property(nonatomic, strong)UIButton * preBtn;
@property(nonatomic, assign)NSTimeInterval playTime ;
@property(nonatomic, strong)YYAnimatedImageView * gifView;
@property(nonatomic, assign)BOOL isPlaying;
@property(nonatomic, strong)UIButton * undoBtn;
@property(nonatomic, strong)UIButton * redoBtn;
//@property(nonatomic, assign)NSInteger selectedTag;
//audio
@property(nonatomic, strong)AVAudioRecorder * audioRecorder;
@property(nonatomic, strong)NSString * cafFilePath;
@property(nonatomic, strong)NSString * mp3FilePath;
@property(nonatomic, strong)UILabel * recordLabel;
//@property(nonatomic, strong)UIView * dimView;
@property(nonatomic, assign)BOOL isRecorded;
@end

@implementation MovieCanvasViewController
static NSMutableDictionary *_musices;
const float sideButtonSize = 52.0;
const float sideButtonSpacing = 60.0;
const float blank = 50.0;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    //
    self.cafFilePath = [kSandboxPathStr stringByAppendingPathComponent:kCafFileName];
    self.mp3FilePath = [kSandboxPathStr stringByAppendingPathComponent:kMp3FileName];
}

- (void)setUpUI{
    //bgview
    self.bgView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.image = [UIImage getBundleImageName:@"bgCard_1"];
    self.bgView.userInteractionEnabled = YES;
    [self.view addSubview:self.bgView];
    //layer
//    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
//    [self.view.layer addSublayer:self.playerLayer];
    self.gifView = [[YYAnimatedImageView alloc] initWithImage: [YYImage imageWithData:[NSData getGifDataWithBundle:[NSString stringWithFormat:@"gif_%ld",(long)self.tag]]]];
    self.gifView.autoPlayAnimatedImage = NO;
    [self.view addSubview:self.gifView];
    self.gifView.frame = self.view.frame;
    if(self.tag != 3){
        //side bar
        self.sideBar = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"sidebar"]];
        self.sideBar.userInteractionEnabled = YES;
        [self.bgView addSubview:self.sideBar];
        [self.sideBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right);
            make.centerY.equalTo(self.view.mas_centerY);
            make.width.mas_equalTo(@202);
            make.height.mas_equalTo(2 * blank + 5 * sideButtonSpacing + 4 * sideButtonSize);
        }];
        //sidebutton
        //audio
        UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTableviewCellLongPressed:)];
        longPress.delegate = self;
        longPress.minimumPressDuration = 0.5;
        NSMutableArray * tempArr = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            UIButton * btn = [[UIButton alloc] init];
            btn.tag = i+1;
            [self.sideBar addSubview:btn];
            [tempArr addObject:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.sideBar.mas_centerX);
                make.width.height.mas_equalTo(sideButtonSize);
                make.top.equalTo(self.sideBar.mas_top).with.offset(blank + (i+1) * sideButtonSpacing + i * sideButtonSize);
            }];
            [btn setImage:[UIImage getBundleImageName:[NSString stringWithFormat:@"side_%d", i+1]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(sideButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            if(i == 2){
                //audio
                [btn addGestureRecognizer:longPress];
            }
        }
        self.sideButtonArr = [NSArray arrayWithArray:tempArr];
        //arr
        self.labelArr = [NSMutableArray array];
        self.delCacheArr = [NSMutableArray array];
    }
        //tap
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSideView)];
    [self.view addGestureRecognizer:tap];
    //button
    self.preBtn = ({
        UIButton * preBtn = [[UIButton alloc] init];
        [self.view addSubview:preBtn];
        [preBtn setImage:[UIImage getBundleImageName:@"movieButton"] forState:UIControlStateNormal];
        [preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-40);
            make.width.mas_equalTo(preBtn.currentImage.size.width / 6);
            make.height.mas_equalTo(preBtn.currentImage.size.height / 6);
        }];
        [preBtn addTarget:self action:@selector(preview) forControlEvents:UIControlEventTouchUpInside];
        preBtn;
    });
    if(self.tag != 3){
        self.undoBtn = ({
            UIButton * btn = [[UIButton alloc] init];
            [self.view addSubview:btn];
            [btn setImage:[UIImage getBundleImageName:@"back_btn"] forState:UIControlStateNormal];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.preBtn.mas_centerY);
                make.right.equalTo(self.preBtn.mas_left).with.offset(-20);
                make.height.width.mas_equalTo(56);
            }];
            btn;
        });
        self.redoBtn = ({
            UIButton * btn = [[UIButton alloc] init];
            [self.view addSubview:btn];
            [btn setImage:[UIImage getBundleImageName:@"forward_btn"] forState:UIControlStateNormal];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.preBtn.mas_centerY);
                make.left.equalTo(self.preBtn.mas_right).with.offset(20);
                make.height.width.mas_equalTo(56);
            }];
            btn;
        });
    }
    //return
    UIButton * retBtn = [[UIButton alloc] init] ;
    [self.view addSubview:retBtn] ;
    [retBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).with.offset(42) ;
        make.width.height.mas_equalTo(@42) ;
    }];
    [retBtn setImage:[UIImage imageNamed:@"retNav"] forState:UIControlStateNormal] ;
    [retBtn addTarget:self action:@selector(navigationReturn) forControlEvents:UIControlEventTouchUpInside] ;
}

- (void)sideButtonClicked:(UIButton *)sender{
    if(self.currentSideView){
        [self.currentSideView removeFromSuperview];
        self.currentSideView = nil;
    }
    else if(self.currentColorView){
        [self.currentColorView removeFromSuperview];
        self.currentColorView = nil;
    }
    
    if(sender.tag == 1){
        self.currentColorView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"colorCard"]];
        [self.view addSubview:self.currentColorView];
        [self.currentColorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.sideBar.mas_left).with.offset(-72);
            make.top.equalTo(self.view.mas_top).with.offset(232);
            make.width.mas_equalTo(self.currentColorView.image.size.width / 6);
            make.height.mas_equalTo(self.currentColorView.image.size.height / 6);
        }];
    }
    else if(sender.tag == 2){
        self.currentSideView = [[MovieSideView alloc] initWithType:SideViewTypeLabel];
        [self.currentSideView setLabelImageWithTag:self.tag];      //set image
        [self.view addSubview:self.currentSideView];
        [self.currentSideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.sideBar.mas_centerY);
            make.right.equalTo(self.sideBar.mas_left).with.offset(-50);
            make.width.height.mas_equalTo(self.currentSideView.frame.size.width);
        }];
    }
    else if(sender.tag == 3){
        //audio
        
    }
    else{
        self.currentSideView = [[MovieSideView alloc] initWithType:SideViewTypeBackground];
        [self.view addSubview:self.currentSideView];
        [self.currentSideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.sideBar.mas_centerY);
            make.right.equalTo(self.sideBar.mas_left).with.offset(-50);
            make.width.height.mas_equalTo(self.currentSideView.frame.size.width);
        }];
    }
}

- (void)setCurrentSideView:(MovieSideView *)currentSideView{
    _currentSideView = currentSideView;
    [self setSideViewEvent];
}

- (void)setSideViewEvent{
    if(self.currentSideView.type == SideViewTypeBackground){
        for(UIImageView * imgView in self.currentSideView.imgArr){
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgSideCardClicked:)];
            [imgView addGestureRecognizer:tap];
        }
    }
    else{
        for(UIImageView * imgView in self.currentSideView.imgArr){
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelSideCardClicked:)];
            [imgView addGestureRecognizer:tap];
        }
    }
}

- (void)hideSideView{
    if(self.currentSideView){
        [self.currentSideView removeFromSuperview];
        self.currentSideView = nil;
    }
    else if(self.currentColorView){
        [self.currentColorView removeFromSuperview];
        self.currentColorView = nil;
    }
    if(self.isPlaying){
        [self resumeView];
    }
}

- (void)bgSideCardClicked:(UITapGestureRecognizer *)tap{
    UIImageView * imgView = (UIImageView *)tap.view;
//    int i = 1;
//    while(imgView != self.currentSideView.imgArr[i-1] && i <= 4){
//        i++;
//    }
    int i;
    if(imgView == self.currentSideView.imgArr[0]){
        i = 1;
    }
    else if(imgView == self.currentSideView.imgArr[1]){
        i = 2;
    }
    else if(imgView == self.currentSideView.imgArr[2]){
        i = 3;
    }
    else{
        i = 4;
    }
    self.bgView.image = [UIImage getBundleImageName:[NSString stringWithFormat:@"bgCard_%d", i]];
}

- (void)labelSideCardClicked:(UITapGestureRecognizer *)tap{
    int i;
    UIImageView * imgView = (UIImageView *)tap.view;
    if(imgView == self.currentSideView.imgArr[0]){
        i = 1;
    }
    else if(imgView == self.currentSideView.imgArr[1]){
        i = 2;
    }
    else if(imgView == self.currentSideView.imgArr[2]){
        i = 3;
    }
    else{
        i = 4;
    }
    MovieCardLabel * label = [[MovieCardLabel alloc] initWithImage:[UIImage getBundleImageName:[NSString stringWithFormat:@"labelCard_%ld_%d", (long)self.tag, i]]];
    [self.view addSubview:label];
    [self.labelArr addObject:label];
}

- (void)navigationReturn{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

- (void)preview{
    self.gifView.currentAnimatedImageIndex = 0;
    self.isPlaying = YES;
    if(self.tag != 3){
        self.sideBar.hidden = YES;
        self.undoBtn.hidden = YES;
        self.redoBtn.hidden = YES;
    }
    self.preBtn.hidden = YES;
//    self.gifView.image = [YYImage imageWithData:[NSData getGifDataWithBundle:[NSString stringWithFormat:@"gif_%ld",(long)self.tag]]];
    [self.gifView startAnimating];
//    [RACObserve(_gifView, currentAnimatedImageIndex) subscribeNext:^(id  _Nullable x) {
//        if([x integerValue] == self->_gifView.animationImages.count){
//            [self resumeView];
//        }
//    }];
    if(self.isRecorded){
        [self playRecord];
    }
}

- (void)resumeView{
    [self.gifView stopAnimating];
    if(self.tag != 3){
        self.sideBar.hidden = NO;
        self.undoBtn.hidden = NO;
        self.redoBtn.hidden = NO;
       
    }
    self.preBtn.hidden = NO;
    [self stopPlayRecord];
}

#pragma mark - audio
- (void)handleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state ==  UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        [self startRecordNotice];
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        [self stopRecordNotice];
    }
}

- (AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[NSURL URLWithString:self.cafFilePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

- (void)startRecordNotice{
    self.isRecorded = YES;
    [self.view addSubview:self.recordLabel];
    [self deleteOldRecordFile];
    [self stopMusicWithUrl:[NSURL URLWithString:self.cafFilePath]];
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
    }
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
    }
}
- (void)stopRecordNotice{
    [self.recordLabel removeFromSuperview];
    [self.audioRecorder stop];
    [self audio_PCMtoMP3];
    
}

-(NSDictionary *)getAudioSetting{
    //LinearPCM 是iOS的一种无损编码格式,但是体积较为庞大
    //录音设置
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    //[recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    return recordSettings;
}

- (void)audio_PCMtoMP3
{
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([self.cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([self.mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = (int)fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        NSLog(@"MP3生成成功: %@",self.mp3FilePath);
    }
    
}

#pragma mark - AudioPlayer方法
/**
 *播放音乐文件
 */
- (BOOL)playMusicWithUrl:(NSURL *)fileUrl
{
    //其他播放器停止播放
    [self stopAllMusic];
    
    if (!fileUrl) return NO;
    
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];  //此处需要恢复设置回放标志，否则会导致其它播放声音也会变小
    [session setActive:YES error:nil];
    
    AVAudioPlayer *player=[self musices][fileUrl];
    
    if (!player) {
        //2.2创建播放器
        player=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
    }
    
    player.delegate = self;
    
    if (![player prepareToPlay]){
        NSLog(@"缓冲失败--");
        //        [self myToast:@"播放器缓冲失败"];
        return NO;
    }
    
    [player play];
    
    //2.4存入字典
    [self musices][fileUrl]=player;
    
    
    NSLog(@"musices:%@ musices",self.musices);
    
    return YES;//正在播放，那么就返回YES
}


/**
 *播放音乐文件
 */
- (void)stopMusicWithUrl:(NSURL *)fileUrl{
    if (!fileUrl) return;//如果没有传入文件名，那么就直接返回
    
    //1.取出对应的播放器
    AVAudioPlayer *player=[self musices][fileUrl];
    
    //2.停止
    if ([player isPlaying]) {
        [player stop];
        NSLog(@"播放结束:%@--------",fileUrl);
    }
    
    if ([[self musices].allKeys containsObject:fileUrl]) {
        
        [[self musices] removeObjectForKey:fileUrl];
    }
}



- (BOOL)isPlayingWithUniqueID:(NSString *)uniqueID
{
    
    if ([[self musices].allKeys containsObject:uniqueID]) {
        AVAudioPlayer *player=[self musices][uniqueID];
        return [player isPlaying];
        
    }else{
        return NO;
    }
    
}


- (void)stopAllMusic
{
    
    if ([self musices].allKeys.count > 0) {
        for ( NSString *playID in [self musices].allKeys) {
            
            AVAudioPlayer *player=[self musices][playID];
            [player stop];
        }
    }
}

- (NSMutableDictionary *)musices
{
    if (_musices==nil) {
        _musices=[NSMutableDictionary dictionary];
    }
    return _musices;
}

#pragma mark - 文件转换
// 二进制文件转为base64的字符串
- (NSString *)Base64StrWithMp3Data:(NSData *)data{
    if (!data) {
        NSLog(@"Mp3Data 不能为空");
        return nil;
    }
    //    NSString *str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *str = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return str;
}

// base64的字符串转化为二进制文件
- (NSData *)Mp3DataWithBase64Str:(NSString *)str{
    if (str.length ==0) {
        NSLog(@"Mp3DataWithBase64Str:Base64Str 不能为空");
        return nil;
    }
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSLog(@"Mp3DataWithBase64Str:转换成功");
    return data;
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark - 播放
- (void)playRecord
{
    [self stopAllMusic];
    
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];  //此处需要恢复设置回放标志，否则会导致其它播放声音也会变小
    
    [self playMusicWithUrl:[NSURL URLWithString:self.cafFilePath]];
}

- (void)stopPlayRecord
{
    [self stopMusicWithUrl:[NSURL URLWithString:self.cafFilePath]];
}

-(void)deleteOldRecordFile{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:self.cafFilePath];
    if (!blHave) {
        NSLog(@"不存在");
        return ;
    }else {
        NSLog(@"存在");
        BOOL blDele= ([fileManager removeItemAtPath:self.cafFilePath error:nil] && [fileManager removeItemAtPath:self.mp3FilePath error:nil]);
        if (blDele) {
            NSLog(@"删除成功");
        }else {
            NSLog(@"删除失败");
        }
    }
}


-(void)deleteOldRecordFileAtPath:(NSString *)pathStr{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:pathStr];
    if (!blHave) {
        NSLog(@"不存在");
        return ;
    }else {
        NSLog(@"存在");
        BOOL blDele= [fileManager removeItemAtPath:self.cafFilePath error:nil];
        if (blDele) {
            NSLog(@"删除成功");
        }else {
            NSLog(@"删除失败");
        }
    }
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"delegate--播放完毕----------------------");
}

- (UILabel *)recordLabel{
    if(!_recordLabel){
        _recordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        CGPoint center = self.view.center;
        center.y = 20;
        _recordLabel.center = center;
        _recordLabel.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:40];
        _recordLabel.textColor = [UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1];
        _recordLabel.text = @"正在录音中";
    }
    return _recordLabel;
}
@end
