//
//  CreatCardViewController.m
//  CarveDW
//
//  Created by 张储祺 on 2019/6/30.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "CreatCardViewController.h"
#import "UIImage+Bundle.h"
#import <Masonry.h>
#import "CardInitGenderView.h"
#import "CardView.h"
#import <Photos/Photos.h>
// FZLTXIHJW--GB1-0
@interface CreatCardViewController ()
@property(nonatomic, strong)NSArray <CardButton *> * buttonArr ;
//init viewgroup
@property(nonatomic, strong)UILabel * genderLabel ;
@property(nonatomic, strong)CardInitGenderView * genderSelView ;
@property(nonatomic, strong)UILabel * nameLabel ;
@property(nonatomic, strong)UITextField * nameTextField ;
@property(nonatomic, strong)UIButton * generateButton ;
//card
@property(nonatomic, strong)CardView * cardView ;
@property(nonatomic, strong)UIButton * refreshButton ;
@property(nonatomic, strong)UIButton * changeFrameButton ;
//moji
@property(nonatomic, strong)UIScrollView * mojiScrollView ;
//save
@property(nonatomic, strong)UIButton * saveBtn;
@end

@implementation CreatCardViewController
const float mojiWidth = 308.0 ;
const float mojiSpacing = 55.0 ;
- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    self.isInitial = YES ;
    [self setUpUI] ;
}

- (void)setUpUI{
    //bg
    UIImageView * bgView = [[UIImageView alloc] initWithImage:[UIImage getBundleImageName:@"card_bgView"]] ;
    bgView.frame = [UIScreen mainScreen].bounds ;
    bgView.userInteractionEnabled = YES ;
    [self.view addSubview:bgView] ;
    //return
    UIButton * retBtn = [[UIButton alloc] init] ;
    [self.view addSubview:retBtn] ;
    [retBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).with.offset(42) ;
        make.width.height.mas_equalTo(@42) ;
    }];
    [retBtn setImage:[UIImage imageNamed:@"retNav"] forState:UIControlStateNormal] ;
    [retBtn addTarget:self action:@selector(navigationReturn) forControlEvents:UIControlEventTouchUpInside] ;
    //buttons
    NSMutableArray * tempArr = [NSMutableArray array] ;
    for(int i = 0 ; i < 2 ; i++){
        CardButton * btn = [[CardButton alloc] initWithFlag:i+1] ;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateButtonClicked:)] ;
        [btn addGestureRecognizer:tap] ;
        [self.view addSubview:btn] ;
        [tempArr addObject:btn] ;
    }
    self.buttonArr = [NSArray arrayWithArray:tempArr] ;
    [self.buttonArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(retBtn.mas_centerY) ;
        make.right.equalTo(self.view.mas_centerX).with.offset(-50) ;
        make.height.mas_equalTo(@44) ;
        make.width.mas_equalTo(@122) ;
    }];
    self.buttonArr[0].isSelected = YES;
    [self.buttonArr[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(retBtn.mas_centerY) ;
        make.left.equalTo(self.view.mas_centerX).with.offset(50) ;
        make.height.mas_equalTo(@44) ;
        make.width.mas_equalTo(@122) ;
    }];
    //init card view
    self.genderLabel = ({
        UILabel * label = [[UILabel alloc] init] ;
        label.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:42] ;
        label.textColor = [UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1] ;
        label.text = @"您的性别" ;
        label.textAlignment = NSTextAlignmentCenter ;
        [self.view addSubview:label] ;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(240) ;
            make.top.equalTo(self.view.mas_top).with.offset(376) ;
            make.width.mas_equalTo(@176) ;
            make.height.mas_equalTo(@44) ;
        }];
        label ;
    });
    self.genderSelView = ({
        CardInitGenderView * genderView = [[CardInitGenderView alloc] init] ;
        [self.view addSubview:genderView] ;
        [genderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(285) ;
            make.centerX.equalTo(self.view.mas_centerX) ;
            make.width.mas_equalTo(@525) ;
            make.height.mas_equalTo(@273) ;
        }];
        genderView ;
    });
    self.nameLabel = ({
        UILabel * label = [[UILabel alloc] init] ;
        label.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:42] ;
        label.textColor = [UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1] ;
        label.text = @"您的姓名" ;
        label.textAlignment = NSTextAlignmentCenter ;
        [self.view addSubview:label] ;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(240) ;
            make.top.equalTo(self.genderLabel.mas_bottom).with.offset(212) ;
            make.width.mas_equalTo(@176) ;
            make.height.mas_equalTo(@44) ;
        }];
        label ;
    });
//    self
    self.nameTextField = ({
        UITextField * textField = [[UITextField alloc] init] ;
        textField.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:42] ;
        textField.textColor = [UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1] ;
        textField.placeholder = @"四个字以内" ;
        textField.keyboardType = UIKeyboardTypeDefault ;
        textField.layer.borderWidth = 1.0 ;
        textField.borderStyle = UITextBorderStyleNone ;
        textField.layer.borderColor= [UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1].CGColor;
        textField.layer.cornerRadius = 5.f ;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged] ;
        [self.view addSubview:textField] ;
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@525) ;
            make.height.mas_equalTo(@87) ;
            make.centerX.equalTo(self.view.mas_centerX) ;
            make.top.equalTo(self.genderSelView.mas_bottom).with.offset(49) ;
        }];
        textField ;
    });
    self.generateButton = ({
        UIButton * button = [[UIButton alloc] init] ;
        button.titleLabel.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:42] ;
        [button setTitleColor:[UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1] forState:UIControlStateNormal] ;
        [button setTitle:@"点击生成" forState:UIControlStateNormal] ;
        button.layer.cornerRadius = 15.f ;
        button.layer.borderWidth = 1.f ;
        button.layer.borderColor = [UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1].CGColor ;
        button.titleLabel.textColor =[UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1] ;
        [self.view addSubview:button] ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX) ;
            make.top.equalTo(self.nameTextField.mas_bottom).with.offset(92) ;
            make.width.mas_equalTo(@362) ;
            make.height.mas_equalTo(@91) ;
        }];
        [button addTarget:self action:@selector(generateCard) forControlEvents:UIControlEventTouchUpInside] ;
        button ;
    });
    self.refreshButton = ({
        UIButton * button = [[UIButton alloc] init] ;
        [button setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal] ;
        [self.view addSubview:button] ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(@44) ;
            make.top.equalTo(self.view.mas_top).with.offset(40) ;
            make.right.equalTo(self.view.mas_right).with.offset(-68) ;
        }];
        [button addTarget:self action:@selector(refreshCardView) forControlEvents:UIControlEventTouchUpInside] ;
        button.hidden = YES ;
        button ;
    });
    self.changeFrameButton = ({
        UIButton * button = [[UIButton alloc] init] ;
        [button setImage:[UIImage imageNamed:@"changeFrame"] forState:UIControlStateNormal] ;
        [self.view addSubview:button] ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(@44) ;
            make.top.equalTo(self.view.mas_top).with.offset(40) ;
            make.right.equalTo(self.refreshButton.mas_left).with.offset(-18) ;
        }];
        [button addTarget:self action:@selector(changeFrame) forControlEvents:UIControlEventTouchUpInside] ;
        button.hidden = YES;
        button ;
    });
    self.mojiScrollView = ({
        UIScrollView * scrollView = [[UIScrollView alloc] init] ;
        scrollView.contentSize = CGSizeMake(4 * mojiWidth + 4 * mojiSpacing, mojiWidth) ;
        scrollView.contentOffset = CGPointMake(0, 0) ;
        scrollView.showsVerticalScrollIndicator = NO ;
        scrollView.showsHorizontalScrollIndicator = NO ;
        [self.view addSubview:scrollView] ;
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left) ;
            make.centerY.equalTo(self.view.mas_centerY) ;
            make.width.mas_equalTo(self.view.frame.size.width) ;
            make.height.mas_equalTo(mojiWidth) ;
        }];
        for(int i = 0 ; i < 4 ; i++){
            UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(mojiSpacing * (i+1) + mojiWidth * i, 0, mojiWidth, mojiWidth)] ;
            imgView.image = [UIImage getBundleImageName:[NSString stringWithFormat:@"moji_%d", i+1]];
            [scrollView addSubview:imgView] ;
        }
        scrollView.hidden = YES ;
        scrollView ;
    });
    self.saveBtn = ({
        UIButton * btn = [[UIButton alloc] init];
        btn.hidden = YES;
        [self.view addSubview:btn];
        [btn setImage:[UIImage getBundleImageName:@"save_btn"] forState:UIControlStateNormal];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-40);
            make.centerX.equalTo(self.view.mas_centerX);
            make.height.width.mas_equalTo(btn.currentImage.size.width / 4);
        }];
        [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
}

#pragma mark - textfield
- (void)textFieldDidChange:(UITextField *)textField{
    NSString *toBeString = textField.text;
    const NSInteger MAX_STARWORDS_LENGTH = 4 ;
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > MAX_STARWORDS_LENGTH)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

- (instancetype)init{
    self = [super init] ;
    if(self){
        self.state = CardStateCard ;
        self.isInitial = YES ;
    }
    return self ;
}

- (void)navigationReturn{
    //    [self.navigationController popViewControllerAnimated:YES] ;
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
#pragma mark - button
- (void)stateButtonClicked:(UITapGestureRecognizer *)tap{
    CardButton * sender = (CardButton * )tap.view ;
    if(sender.flag == 1){
        self.state = CardStateCard ;
        self.buttonArr[0].isSelected = YES ;
        self.buttonArr[1].isSelected = NO ;
    }else{
        self.state = CardStateMoji ;
        self.buttonArr[0].isSelected = NO ;
        self.buttonArr[1].isSelected = YES ;
    }
}

- (void)generateCard{
    //set hide
    self.isInitial = NO ;
    NSInteger value = (arc4random() % 12) + 1 ;
    self.cardView = [[CardView alloc] initWithName:self.nameTextField.text andNumber:value] ;
}

- (void)refreshCardView{
    NSInteger curValue = self.cardView.number ;
    NSInteger value ;
    while ((value = (arc4random() % 12) + 1)) {
        if(value != curValue && curValue <=6 && value != curValue + 6) break ;
        if(value != curValue && curValue > 6 && value != curValue - 6) break ;
    }
    self.cardView = [[CardView alloc] initWithName:self.cardView.label.text andNumber:value] ;
}

- (void)changeFrame{
    NSInteger curValue = self.cardView.number ;
    if(curValue <= 6) curValue += 6 ;
    else curValue -=6 ;
    self.cardView = [[CardView alloc] initWithName:self.cardView.label.text andNumber:curValue] ;
}

#pragma mark - setter
- (void)setState:(CardState)state{
    _state = state ;
    if(state == CardStateCard){
        self.mojiScrollView.hidden = YES ;
        self.saveBtn.hidden = NO;
        self.cardView.hidden = NO ;
        if(!self.isInitial){
            self.refreshButton.hidden = NO ;
            self.changeFrameButton.hidden = NO ;
        }
        else{
            self.nameTextField.hidden = NO ;
            self.genderLabel.hidden = NO ;
            self.genderSelView.hidden = NO ;
            self.nameLabel.hidden = NO ;
            self.generateButton.hidden = NO ;
        }
    }
    else{
        self.saveBtn.hidden = YES;
        self.mojiScrollView.hidden = NO ;
        self.cardView.hidden = YES ;
        self.refreshButton.hidden = YES ;
        self.changeFrameButton.hidden = YES ;
        
        self.nameTextField.hidden = YES ;
        self.genderLabel.hidden = YES ;
        self.genderSelView.hidden = YES ;
        self.nameLabel.hidden = YES ;
        self.generateButton.hidden = YES ;
    }
}

- (void)setIsInitial:(BOOL)isInitial{
    _isInitial = isInitial ;
    if(isInitial){
        self.changeFrameButton.hidden = YES ;
        self.refreshButton.hidden = YES ;
    }
    else{
        self.saveBtn.hidden = NO;
        self.refreshButton.hidden = NO ;
        self.changeFrameButton.hidden = NO ;
        self.nameTextField.hidden = YES ;
        self.genderLabel.hidden = YES ;
        self.genderSelView.hidden = YES ;
        self.nameLabel.hidden = YES ;
        self.generateButton.hidden = YES ;
    }
}

- (void)setCardView:(CardView *)cardView{
    [_cardView removeFromSuperview] ;
    _cardView = nil ;
    _cardView = cardView ;
    [self.view addSubview:_cardView] ;
    [_cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX) ;
        make.centerY.equalTo(self.view.mas_centerY) ;
        make.width.mas_equalTo(self->_cardView.frameSize.width) ;
        make.height.mas_equalTo(self->_cardView.frameSize.height) ;
    }] ;
}

- (void)save{
    UIGraphicsBeginImageContextWithOptions(self.cardView.bounds.size, 1, [[UIScreen mainScreen] scale]);
    [self.cardView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest * request = [PHAssetChangeRequest creationRequestForAssetFromImage:img];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"success = %d, error = %@", success, error);
    }];
}
@end
