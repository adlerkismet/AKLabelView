//
//  ViewController.m
//  AKLabelViewDemo
//
//  Created by kismet adler on 2018/7/8.
//  Copyright © 2018年 kismet adler. All rights reserved.
//

#import "ViewController.h"
#import "AKLabelView.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
@interface ViewController ()
@property (nonatomic, strong) AKPresentView *presentView;
@property (nonatomic, copy) NSArray<NSString *> *classArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.classArray = @[@"AKArrowView"
                        ,@"AKCircleView"
                        ,@"AKRectangleView"];
    
    self.presentView = [[AKPresentView alloc] init];
    self.presentView.drawViewArray = [self randomAKViewArray];
    [self.view addSubview:self.presentView];
    [self.presentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    [self configEditButton];
}

- (void)configEditButton {
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setTitle:@"Add AKView" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addRandomAKView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    
    UIButton *removeButton = [[UIButton alloc] init];
    [removeButton setTitle:@"Remove AKView" forState:UIControlStateNormal];
    [removeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(removeRandomAKView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeButton];
    [removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(addButton.mas_top).offset(-20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
}

- (void)configRandomAKView:(id)akView {
    if ([akView isKindOfClass:[AKView class]]) {
        AKView *tempAKView = akView;
        tempAKView.fillColor = [self randomColor];
        tempAKView.singleTapBlock = ^{
            [self showHUDWithString:[NSString stringWithFormat:@"single tap:[%@]",[akView description]] addTo:self.view];
        };
        tempAKView.doubleTapBlock = ^{
            [self showHUDWithString:[NSString stringWithFormat:@"double tap:[%@]",[akView description]] addTo:self.view];
        };
        tempAKView.longPressBlock = ^{
            [self showHUDWithString:[NSString stringWithFormat:@"long press:[%@]",[akView description]] addTo:self.view];
        };
    }
    if ([akView isKindOfClass:[AKLineView class]]) {
        AKLineView *tempLineView = akView;
        tempLineView.startPoint = [self randomAKPoint];
        tempLineView.endPoint = [self randomAKPoint];
        tempLineView.lineWidth = arc4random()%10;
    }else if ([akView isKindOfClass:[AKArrowView class]]) {
        AKArrowView *tempArrowView = akView;
        tempArrowView.startPoint = [self randomAKPoint];
        tempArrowView.endPoint = [self randomAKPoint];
        tempArrowView.arrowStyle = AKArrowStyle_JoinPoint;
    }else if ([akView isKindOfClass:[AKCircleView class]]) {
        AKCircleView *tempCircleView = akView;
        tempCircleView.radius = arc4random()%400;
        tempCircleView.originPoint = [self randomAKPoint];
    }else if ([akView isKindOfClass:[AKRectangleView class]]) {
        AKRectangleView *tempRectangleView = akView;
        tempRectangleView.startPoint = [self randomAKPoint];
        tempRectangleView.endPoint = [self randomAKPoint];
    }
}

- (void)addRandomAKView {
    [self.presentView addAKView:[self randomAKView]];
    [self.presentView redraw];
}

- (void)removeRandomAKView {
    NSArray<AKView *> *drawViewArray = self.presentView.drawViewArray;
    if (!drawViewArray.count) {
        return;
    }
    [self.presentView removeAKView:drawViewArray[arc4random()%drawViewArray.count]];
    [self.presentView redraw];
}

- (AKView *)randomAKView {
    id akView = [[NSClassFromString(self.classArray[arc4random()%self.classArray.count]) alloc] init];
    [self configRandomAKView:akView];
    return akView;
}

- (NSArray *)randomAKViewArray {
    NSInteger itemCount = arc4random()%20;
    itemCount = itemCount != 0 ? itemCount : 10;
    NSMutableArray *tempMutableArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < itemCount; i ++) {
        id akView = [[NSClassFromString(self.classArray[arc4random()%self.classArray.count]) alloc] init];
        [self configRandomAKView:akView];
        [tempMutableArray addObject:akView];
    }
    
    return [tempMutableArray copy];
}

- (AKPoint)randomAKPoint {
    return AKPointMake(arc4random()%1920, arc4random()%1080);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random()%255/255.0
                           green:arc4random()%255/255.0
                            blue:arc4random()%255/255.0
                           alpha:arc4random()%255/255.0];
}

- (void)showHUDWithString:(NSString *)infoString addTo:(UIView *)view {
    if ([MBProgressHUD HUDForView:view]) {
        [MBProgressHUD hideHUDForView:view animated:NO];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = infoString;
    hud.userInteractionEnabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([MBProgressHUD HUDForView:view]) {
            [hud hideAnimated:YES];
        }
    });
}
@end
