//
//  AKPolygonView.h
//  ARLabelDemo
//
//  Created by kismet adler on 2018/3/27.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKView.h"

@interface AKPolygonView : AKView
@property (nonatomic, strong) NSArray<NSValue *> *points;
@end

@interface NSValue(AKPoint)
+ (NSValue *)valueWithAKPoint:(AKPoint)point;
- (AKPoint)AKPointValue;
@end
