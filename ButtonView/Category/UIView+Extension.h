//
//  UIView+Extension.h
//
//  Created by zhang on 15/10/27.
//  Copyright © 2015年 ldd. All rights reserved.
//


#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);


@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/** 左下角的x,y */
@property (readonly) CGPoint bottomLeft;
/** 右下角的x,y */
@property (readonly) CGPoint bottomRight;
/** 右上角x,y */
@property (readonly) CGPoint topRight;
/** x */
@property CGFloat top;
/** y */
@property CGFloat left;
/** 下边的位置：y+height */
@property CGFloat bottom;
/** 右边的位置：x+width */
@property CGFloat right;
/** 移动x,y点 */
- (void) moveBy: (CGPoint) delta;
/** 缩放比例 */
- (void) scaleBy: (CGFloat) scaleFactor;
/** 等比缩放 */
- (void) fitInSize: (CGSize) aSize;

@end
