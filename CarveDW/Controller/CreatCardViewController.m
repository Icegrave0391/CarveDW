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
// FZLTXIHJW--GB1-0
@interface CreatCardViewController ()
@property(nonatomic, strong)NSArray <CardButton *> * buttonArr ;
//init viewgroup
@property(nonatomic, strong)UILabel * genderLabel ;
@property(nonatomic, strong)CardInitGenderView * genderSelView ;
@property(nonatomic, strong)UILabel * nameLabel ;
@property(nonatomic, strong)UITextField * nameTextField ;
@property(nonatomic, strong)UIButton * generateButton ;
//
@end

@implementation CreatCardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
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
//    [self.buttonArr[0] mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.
//    }]
    
    //init card view
    self.genderLabel = ({
        UILabel * label = [[UILabel alloc] init] ;
        label.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:42] ;
        label.textColor = [UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1] ;
        label.text = @"您的性别" ;
        label.textAlignment = NSTextAlignmentCenter ;
        [self.view addSubview:label] ;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(254) ;
            make.top.equalTo(self.view.mas_top).with.offset(376) ;
            make.width.mas_equalTo(@164) ;
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
            make.left.equalTo(self.view.mas_left).with.offset(254) ;
            make.top.equalTo(self.genderLabel.mas_bottom).with.offset(212) ;
            make.width.mas_equalTo(@164) ;
            make.height.mas_equalTo(@44) ;
        }];
        label ;
    });
//    self
    self.nameTextField = ({
        UITextField * textField = [[UITextField alloc] init] ;
        textField.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:42] ;
        textField.placeholder = @"四个字以内" ;
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
        [button setTitle:@"点击生成" forState:UIControlStateNormal] ;
        button.titleLabel.textColor =[UIColor colorWithRed:131.0/255 green:24.0/255 blue:9.0/255 alpha:1] ;
        button ;
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
- (void)stateButtonClicked:(CardButton *)sender{
    if(sender.tag == 1){
        self.state = CardStateCard ;
        self.buttonArr[0].isSelected = YES ;
        self.buttonArr[1].isSelected = NO ;
    }else{
        self.state = CardStateMoji ;
        self.buttonArr[0].isSelected = NO ;
        self.buttonArr[1].isSelected = YES ;
    }
}

#pragma mark - setter
- (void)setState:(CardState)state{
    _state = state ;
    if(state == CardStateCard){
        
    }
    else{
        
    }
}

- (void)setIsInitial:(BOOL)isInitial{
    _isInitial = isInitial ;
    if(isInitial){
        
    }
    else{
        
    }
}
@end
