//
//  CreatMovieViewController.m
//  CarveDW
//
//  Created by 张储祺 on 2019/8/1.
//  Copyright © 2019 icegrave0391. All rights reserved.
//

#import "CreatMovieViewController.h"
#import "MovieCategoryLabel.h"
#import "MovieCardView.h"
#import <Masonry.h>
#import "UIImage+Bundle.h"
#import "MovieCanvasViewController.h"
@interface CreatMovieViewController ()
@property(nonatomic, strong)MovieCategoryLabel * cateLabel1;
@property(nonatomic, strong)MovieCategoryLabel * cateLabel2;
@property(nonatomic, strong)MovieCategoryLabel * cateLabel3;
@property(nonatomic, strong)MovieCategoryLabel * selectedLabel;
@property(nonatomic, strong)NSArray<MovieCardView *> *cardArr;
@property(nonatomic, strong)UIScrollView * scrollView;
@end

@implementation CreatMovieViewController
const float cardWidth = 330.0;
const float cardHeight = 520.0;
const float cardSpacing = 50.0;
const float cardHeading = 86.0;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI{
    UIImageView * bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_home"]];
    bgView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:bgView];
    //label
    self.cateLabel1 = ({
        MovieCategoryLabel * label = [[MovieCategoryLabel alloc] init];
        label.textLabel.text = @"节日";
        [self.view addSubview:label];
        label.frame = CGRectMake(170, 123, 125, 100);
        label.isSelected = YES;
        self.selectedLabel = label;
        label;
    });
    self.cateLabel2 = ({
        MovieCategoryLabel * label = [[MovieCategoryLabel alloc] init];
        label.textLabel.text = @"问候";
        [self.view addSubview:label];
        label.frame = CGRectMake(170 + 118 * 2, 123, 125, 100);
        label;
    });
    self.cateLabel3 = ({
        MovieCategoryLabel * label = [[MovieCategoryLabel alloc] init];
        label.textLabel.text = @"爱情";
        [self.view addSubview:label];
        label.frame = CGRectMake(170 + 118 * 4, 123, 125, 100);
        label;
    });
    for(MovieCategoryLabel * label in @[self.cateLabel1, self.cateLabel2, self.cateLabel3]){
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cateLabelCLicked:)];
        [label addGestureRecognizer:tap];
    }
    //card arr
    NSMutableArray * arr = [NSMutableArray array];
    for(int i = 0; i < 4; i++){
        MovieCardView * cardView = [[MovieCardView alloc] init];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardClicked:)];
        [cardView addGestureRecognizer:tap];
        [arr addObject:cardView];
    }
    self.cardArr = [NSArray arrayWithArray:arr];
    [self setCardImageWithSelectedLabel:self.selectedLabel];
    //scroll view
    self.scrollView = ({
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        scrollView.contentSize = CGSizeMake(4 * cardWidth + 3 * cardSpacing + 86, cardHeight);
        scrollView.contentOffset = CGPointMake(0, 0);
        scrollView.showsVerticalScrollIndicator = NO ;
        scrollView.showsHorizontalScrollIndicator = NO ;
        [self.view addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-99);
            make.width.mas_equalTo(self.view.frame.size.width);
            make.height.mas_equalTo(cardHeight);
        }];
        for(int i = 0; i < 4; i++){
            [scrollView addSubview:self.cardArr[i]];
            [self.cardArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(scrollView.mas_top);
                make.left.equalTo(scrollView.mas_left).with.offset(cardHeading + i * (cardWidth + cardSpacing));
                //make.left.equalTo(scrollView.mas_left);
                make.height.mas_equalTo(cardHeight);
                make.width.mas_equalTo(cardWidth);
            }];
        }
        scrollView;
    });
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

- (void)cateLabelCLicked:(UITapGestureRecognizer *)tap{
    MovieCategoryLabel * label = (MovieCategoryLabel *)tap.view;
    self.selectedLabel.isSelected = NO;
    label.isSelected = YES;
    self.selectedLabel = label;
    //set view
    [self setCardImageWithSelectedLabel:label];
}

- (void)cardClicked:(UITapGestureRecognizer *)tap{
    MovieCardView * card = (MovieCardView *)tap.view;
    //test
    MovieCanvasViewController * CanvasVC = [[MovieCanvasViewController alloc] init];
    if(self.selectedLabel == self.cateLabel3 && card == self.cardArr[0]){//求婚卡
        CanvasVC.tag = 2;
    }
    if(self.selectedLabel == self.cateLabel1 && card == self.cardArr[0]){//拜年
        CanvasVC.tag = 1;
    }
    if(self.selectedLabel == self.cateLabel1 && card == self.cardArr[1]){
        CanvasVC.tag = 3;
    }
    [self presentViewController:CanvasVC animated:YES completion:nil];
}

- (void)setCardImageWithSelectedLabel:(MovieCategoryLabel *)selectedLabel{
    if(selectedLabel == self.cateLabel1){
        for (int i = 0; i < 4; i++) {
            [self.cardArr[i] changeImg:[UIImage getBundleImageName:[NSString stringWithFormat:@"fest_%d", i+1]] andLabelImg:[UIImage getBundleImageName:[NSString stringWithFormat:@"fest_label_%d", i+1]]];
        }
    }
    else if(selectedLabel == self.cateLabel2){
        for (int i = 0; i < 4; i++) {
            [self.cardArr[i] changeImg:[UIImage getBundleImageName:[NSString stringWithFormat:@"greet_%d", i+1]] andLabelImg:[UIImage getBundleImageName:[NSString stringWithFormat:@"greet_label_%d", i+1]]];
        }
    }
    else{
        for (int i = 0; i < 4; i++) {
            [self.cardArr[i] changeImg:[UIImage getBundleImageName:[NSString stringWithFormat:@"love_%d", i+1]] andLabelImg:[UIImage getBundleImageName:[NSString stringWithFormat:@"love_label_%d", i+1]]];
        }
    }
}

- (void)navigationReturn{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
@end
