//
//  AKLineView.h
//  ARLabelDemo
//
//  Created by kismet on 2018/3/13.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKView.h"
NS_ASSUME_NONNULL_BEGIN
@interface AKLineView : AKView
@property (nonatomic, assign) AKPoint startPoint;
@property (nonatomic, assign) AKPoint endPoint;

- (BOOL)isPonitAtLine:(CGPoint)point;
@end
NS_ASSUME_NONNULL_END
