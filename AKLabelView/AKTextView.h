//
//  AKTextView.h
//  ARLabelDemo
//
//  Created by kismet adler on 2018/3/27.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKView.h"
NS_ASSUME_NONNULL_BEGIN
@interface AKTextView : AKView
@property (nonatomic, assign) AKPoint originPoint;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@end
NS_ASSUME_NONNULL_END
