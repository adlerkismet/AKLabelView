//
//  AKPresentView.h
//  ARLabelDemo
//
//  Created by kismet on 2018/3/13.
//  Copyright © 2018年 kismet. All rights reserved.
//

#import "AKView.h"

@interface AKPresentView : UIView

/**
 所需要绘制的AKView的集合
 */
@property (nonatomic, copy) NSArray<AKView*> *drawViewArray;

/**
 重新绘制，在修改drawViewArray后使用
 */
- (void)redraw;
@end
