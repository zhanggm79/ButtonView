//
//  GMMarkButton.h
//  LYB
//
//  Created by Z on 2017/5/12.
//  Copyright © 2017年 Z. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 按钮类型 */
typedef NS_ENUM(NSInteger, GMMarkType) {
    /** Check类型，多选 */
    GMMarkTypeCheck,
    /** Radio类型，多选 */
    GMMarkTypeRadio,
    /** Check类型，单选 */
    GMMarkTypeSingleCheck,
    /** Radio类型，单选 */
    GMMarkTypeSingleRadio
};

@interface GMMarkButton : UIButton

/** 选择框类型 */
@property (nonatomic, assign) GMMarkType type;

/** 按钮组号 */
@property (nonatomic, assign) NSInteger groupId;

/** 触发按钮被点击的方法，刷新同组按钮的选中状态 */
- (void)buttonDidClick;

@end
