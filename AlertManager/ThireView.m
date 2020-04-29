

//
//  ThireView.m
//  AlertManager
//
//  Created by mac on 2020/4/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ThireView.h"



//
//  SecondView.m
//  AlertManager
//
//  Created by mac on 2020/4/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ThireView.h"
#import <Masonry.h>
#import "NPAlertManager.h"

@interface ThireView ()

@property(nonatomic, strong) UIImageView *contentView;

@property(nonatomic, strong) UIImageView *lineView;

@property(nonatomic, strong) UIView *masView;

@property(nonatomic, assign) NSInteger showType;//显示类型

@property(nonatomic, assign) NSInteger count;//显示次数

@property(nonatomic, strong) NSArray *imageArray;



@end

@implementation ThireView

static BOOL prepareing = NO;

static ThireView *payforView = nil;

+ (ThireView*)payforView {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payforView = [[ThireView alloc] initWithFrame:[[[UIApplication sharedApplication] delegate] window].bounds];

    });
    return payforView;
}

+ (void)show{
    
    if (prepareing) {
        return;
    }
    prepareing = YES;
    
    [[self payforView] prepareUI];
    
    [[self payforView] show];
    
}

+ (void)showType:(NSInteger)type {
    if (prepareing) {
        return;
    }
    prepareing = YES;

    [self payforView].showType = type;
    
    [self payforView].imageArray = @[@"healthDemandMask",@"healthDemandMask",@"healthDemandMask",@"healthDemandMask"];

    [[self payforView] prepareUI];

    [[self payforView] show];
}

+ (void)hide {

    [[self payforView] hide];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //遮罩
        self.masView = [[UIView alloc]init];
        [self addSubview:self.masView];
        [self.masView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        self.masView.userInteractionEnabled = YES;
        [self.masView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)]];
        
    }
    return self;
}

- (void)show {
    
    [NPAlertManager.shared addView:payforView];

    if ([NPAlertManager.shared.mtnArray.firstObject isEqual:self]) {
        
        [UIApplication.sharedApplication.delegate.window addSubview:self];
        self.masView.backgroundColor = [UIColor darkGrayColor];
        self.masView.alpha = 0.7;
    }
}

- (void)hide {
    
    [UIView animateWithDuration:0.15 animations:^{
               self.masView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
               self.alpha = 0;
           } completion:^(BOOL finished) {
               [self removeFromSuperview];
               prepareing = NO;

               if ([NPAlertManager.shared.mtnArray.firstObject isEqual:self]) {
                   [NPAlertManager.shared removeView:payforView];
               }
           }];
    
}

- (void)prepareUI {
    
    self.contentView = ({
        UIImageView *view = UIImageView.new;
        [self addSubview:view];
        view.backgroundColor = UIColor.redColor;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));

        }];
        view;
    });
  
}
 
@end


