//
//  GMMarkButton.m
//  LYB
//
//  Created by Z on 2017/5/12.
//  Copyright © 2017年 Z. All rights reserved.
//






#import "GMMarkButton.h"

/** 按钮状态改变后的消息 */
NSString *const GMMarkButtonChangeStateNotification = @"GMMarkButtonChangeStateNotification";

/** Check按钮选中状态图标 */
static NSString *const kCheckSelectedImage   = @"check_selected";
/** Check按钮未选中状态图标 */
static NSString *const kCheckUnselectedImage = @"check_unselected";
/** Radio按钮选中状态图标 */
static NSString *const kRadioSelectedImage   = @"radio_selected";
/** Radio按钮未选中状态图标 */
static NSString *const kRadioUnselectedImage = @"radio_unselected";



@implementation GMMarkButton

/** 初始化方法，用于从代码中创建的类实例 */
- (instancetype)init {
    self = [super init];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

/** 初始化方法，用于从代码中创建的类实例 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

/** 初始化方法，用于从xib文件中载入的类实例 */
- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

/** 默认的初始化方法 */
- (void)defaultInit {
    _type = GMMarkTypeCheck;
    [self registerNotification];
}

/** 释放对象 */
- (void)dealloc {
    [self logOffNotification];
}


#pragma mark - 点击按钮的事件

/** 触发按钮被点击的方法，刷新同组按钮的选中状态 */
- (void)buttonDidClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:GMMarkButtonChangeStateNotification object:self];
}

#pragma mark - 监控按钮状态改变的消息

/** 注册按钮状态改变的消息 */
- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateButtonMarkState:)
                                                 name:GMMarkButtonChangeStateNotification
                                               object:nil];
}

/** 注销按钮状态改变的消息 */
- (void)logOffNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GMMarkButtonChangeStateNotification object:nil];
}


#pragma mark - 属性

- (void)setType:(GMMarkType)type {
    _type = type;
    NSString *selectedImageName   = @"";
    NSString *unselectedImageName = @"";
    
    switch (type)
    {
        case GMMarkTypeCheck:
        case GMMarkTypeSingleCheck:
        {
            selectedImageName   = kCheckSelectedImage;
            unselectedImageName = kCheckUnselectedImage;
            break;
        }
        case GMMarkTypeRadio:
        case GMMarkTypeSingleRadio:
        {
            selectedImageName   = kRadioSelectedImage;
            unselectedImageName = kRadioUnselectedImage;
            break;
        }
    }
    
    [self setImage:[UIImage imageNamed:selectedImageName]   forState:UIControlStateSelected];
    [self setImage:[UIImage imageNamed:unselectedImageName] forState:UIControlStateNormal];
}


#pragma mark - 更新按钮状态

/**
 *  更新按钮状态
 *
 *  @param notification 被点击的按钮所发出的消息
 */
- (void)updateButtonMarkState:(NSNotification *)notification {
    // 获取发出消息的按钮
    GMMarkButton *button = notification.object;
    
    // 只处理同组、同类型的按钮
    if((_type == button.type && _groupId == button.groupId) == NO)
        return;
    
    // 多选按钮，只更新self按钮的选中状态
    if (_type == GMMarkTypeCheck || _type == GMMarkTypeRadio)
    {
        if ([button isEqual:self]) {
            self.selected = !self.selected;
        }
        
        if (button.selected) {
            GM_BtnBorderRadius(button, 2, 0.8, GM_RGBColor(202, 48, 130));
            
        }else {
            GM_BtnBorderRadius(button, 2, 0.8, GM_RGBColor(156, 156, 156));
        }
        
        return;
    }
    
    // 单选按钮
    if ([button isEqual:self] == NO)
    {
        // 非当前按钮发出的消息，则按钮置为未选状态
        self.selected = NO;
        GM_BtnBorderRadius(self, 2, 0.8, GM_RGBColor(156, 156, 156));
    }
    else
    {
        // 当前按钮发出的消息，则按钮置为已选状态
        self.selected = YES;
         GM_BtnBorderRadius(self, 2, 0.8, GM_RGBColor(202, 48, 130));
    }
}



@end
