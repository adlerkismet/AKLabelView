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
 在画布上新添加一个AKView

 @param akView 新添加的AKView
 */
- (void)addAKView:(AKView *)akView;

/**
 在画布上删掉一个AKView

 @param akView 要删除的AKView
 */
- (void)removeAKView:(AKView *)akView;

/**
 在画布上新添加一组AKView

 @param akViews 新添加一组的AKView
 */
- (void)addAKViews:(NSArray<AKView *> *)akViews;

/**
 在画布上删掉一组AKView

 @param akViews 要删除的一组AKView
 */
- (void)removeViews:(NSArray<AKView *> *)akViews;

/**
 重新绘制，在修改drawViewArray后使用
 */
- (void)redraw;
@end
