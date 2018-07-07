//
//  AKImageView.h
//  ARLabelDemo
//
//  Created by kismet adler on 2018/3/26.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKView.h"
NS_ASSUME_NONNULL_BEGIN
@interface AKImageView : AKView
@property (nonatomic, assign) AKPoint originPoint;
@property (nonatomic, assign) NSInteger imageHeight;
@property (nonatomic, assign) NSInteger imageWidth;
@property (nonatomic, strong) UIImage *image;
@end
NS_ASSUME_NONNULL_END
