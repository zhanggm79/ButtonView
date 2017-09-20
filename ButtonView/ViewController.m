//
//  ViewController.m
//  ButtonView
//
//  Created by Z on 2017/9/15.
//  Copyright © 2017年 Z. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic,strong) UIView * backView;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) NSMutableArray * titlesArray;
@property (nonatomic,strong) NSMutableArray * btnIDArray;
@property (nonatomic,strong) NSMutableArray * allBtnArrays;
@property (nonatomic,strong) UIButton * tempBtn;
@property (nonatomic,strong) GMMarkButton * markBtn;
@property (nonatomic,assign) CGFloat btnWidth;
@property (nonatomic,assign) CGFloat backViewHeight;
@property (nonatomic,strong) UIButton * sureBtn;
@property (nonatomic,strong) UILabel * showLabel;

@end

@implementation ViewController
#pragma mark - Lazy loading           懒加载


#pragma mark - LifeCyle               生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
}

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 
 -(void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

- (void)dealloc {
    NSLog(@"%@--->释放了",self.class);
}



#pragma mark - Initial control        初始化控件

//初始化数据
- (void)loadData {
    self.allBtnArrays = [NSMutableArray array];
    self.titlesArray = [NSMutableArray array];
    self.btnIDArray = [NSMutableArray array];
    self.dataArray = @[
                       @{@"goodsID":@"1",@"title":@"丰田丰田丰田"},
                       @{@"goodsID":@"1",@"title":@"宝马宝马"},
                       @{@"goodsID":@"1",@"title":@"梅赛德斯奔驰"},
                       @{@"goodsID":@"1",@"title":@"奥迪奥迪Audi"},
                       @{@"goodsID":@"1",@"title":@"玛莎拉蒂玛莎拉蒂"},
                       @{@"goodsID":@"1",@"title":@"莱斯莱斯"},
                       @{@"goodsID":@"1",@"title":@"宾利慕尚"},
                       @{@"goodsID":@"1",@"title":@"斯巴鲁"}
                       ];
    for (int i=0; i<_dataArray.count; i++) {
        NSDictionary * dict = _dataArray[i];
        [self.btnIDArray addObject:dict[@"goodsID"]];
        [self.titlesArray addObject:dict[@"title"]];
    }
    [self createBtns];
}

//初始化界面
- (void)createBtns {
    
    CGRect frame = CGRectMake(0, 50, SCREEN_WIDTH, 50);
    self.backView = [[UIView alloc] initWithFrame:frame];
    self.backView.backgroundColor = GM_RGBColor(235, 235, 235);
    [self.view addSubview:self.backView];
    
    //适配屏幕大小的每行的按钮的个数
    NSMutableArray * numberBtns = [self returnBtnsForRowAndCol];
    //背景view的高度
    _backViewHeight = numberBtns.count * (KMARGIN + KHEIGHT) + 10;
    
    //设置背景view的高度
    self.backView.height = _backViewHeight;
    
    NSInteger count=0;
    CGFloat Y;
    
    //循环创建按钮
    for (int row = 0; row < numberBtns.count; row++) {
        for (int col = 0; col < [numberBtns[row] intValue]; col++) {
            CGFloat X;
            Y = 10 + row * (KMARGIN + KHEIGHT);
            
            //按钮的宽
            _btnWidth = [self returnBtnWithWithStr:self.titlesArray[count]];
            if (_tempBtn && col) {
                X = CGRectGetMaxX(_tempBtn.frame) + KMARGIN;
            }else{
                X = KMARGIN + col * _btnWidth;
            }
            _markBtn = [[GMMarkButton alloc]initWithFrame:CGRectMake(X, Y, _btnWidth, KHEIGHT)];
            [_markBtn setTitle:self.titlesArray[count] forState:0];
            _markBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            _markBtn.layer.borderWidth = 1;
            _markBtn.layer.borderColor = GM_RGBColor(156, 156, 156).CGColor;
            [_markBtn setTitleColor:GM_RGBColor(156, 156, 156) forState:0];
            [_markBtn setTitleColor:GM_RGBColor(202, 48, 130) forState:UIControlStateSelected];
            _markBtn.backgroundColor=[UIColor clearColor];
            _markBtn.layer.cornerRadius=2;
#pragma mark  ---  这里可选择按钮是单选模式或者多选模式，改变按钮type即可
            //按钮单选模式
            _markBtn.type = GMMarkTypeSingleCheck;
            
            //按钮多选模式
            //_markBtn.type = GMMarkTypeCheck;
            
            //按钮组号，建议取值10000以上
            _markBtn.groupId = 10005;
            _markBtn.tag = [self.btnIDArray[count] integerValue];
            [_markBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.allBtnArrays addObject:_markBtn];
            _tempBtn =_markBtn;
            [self.backView addSubview:_markBtn];
            count += 1;
        }
    }
    
    UIButton * Btn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_backView.frame) + 30, SCREEN_WIDTH - 40, 50)];
    self.sureBtn = Btn;
    [Btn.layer setCornerRadius:6];
    [Btn.layer setMasksToBounds:YES];
    [Btn setTitle:@"确定" forState:0];
    [Btn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:Btn];
    [Btn setBackgroundColor:GM_RGBColor(48, 50, 57)];
    [Btn addTarget:self action:@selector(showSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
    
}



#pragma mark - Action  Method         控件事件
-(void)btnClick:(GMMarkButton *)btn {
    
    [btn buttonDidClick];
    
    
}

//确定按钮
-(void)showSelectedClick:(UIButton *)btn {
    NSMutableArray * strArray = [[NSMutableArray alloc] init];
    for (UIButton * btn in self.allBtnArrays) {
        if (btn.isSelected) {
            [strArray addObject:btn.currentTitle];
        }
    }
    NSString * str = [strArray componentsJoinedByString:@" ** "];
    UIFont * font = [UIFont systemFontOfSize:16];
    CGFloat strH = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 2*KMARGIN, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    //展示文字
    if (!self.showLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KMARGIN, self.sureBtn.bottom+20, SCREEN_WIDTH - 2*KMARGIN, strH)];
        label.font = font;
        label.textColor = [UIColor redColor];
        label.numberOfLines = 0;
        self.showLabel = label;
        [self.view addSubview:label];
    }
    self.showLabel.text = str;
    self.showLabel.height = strH;
    
}

#pragma mark - Private Method         私有方法

#pragma mark - Set/Get Methods        重写设值/取值

#pragma mark - External Delegate      外部代理

#pragma mark - Notification           通知方法

#pragma mark - UITableView            代理方法

#pragma mark - OtherMethods           其他方法
//返回view中有几行几列按钮
- (NSMutableArray *)returnBtnsForRowAndCol {
    CGFloat allWidth = 0.0;
    NSInteger countW = 0;
    NSMutableArray * indexbtns = [NSMutableArray array];
    NSMutableArray *tmpbtns = [NSMutableArray array];
    for (int j = 0;j < self.titlesArray.count; j++) {
        CGFloat width = [self returnBtnWithWithStr:self.titlesArray[j]];
        allWidth += width + KMARGIN;
        countW += 1;
        if (allWidth > SCREEN_WIDTH - 10) {
            //判断第一行情况
            NSInteger lastNum = [[tmpbtns lastObject] integerValue];
            [indexbtns addObject:@(lastNum)];
            [tmpbtns removeAllObjects];
            allWidth = 0.0;
            countW = 0;
            j -= 1;
        }else{
            [tmpbtns addObject:@(countW)];
        }
        
    }
    if (tmpbtns.count != 0) {
        NSInteger lastNum = [[tmpbtns lastObject] integerValue];
        [indexbtns addObject:@(lastNum)];
    }
    return indexbtns;
}

-(CGFloat)returnBtnWithWithStr:(NSString *)str{
    //计算字符长度
    NSDictionary * minattributesri = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize mindetailSizeRi = [str boundingRectWithSize:CGSizeMake(120, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:minattributesri context:nil].size;
    return mindetailSizeRi.width + 12;
    
}



@end
