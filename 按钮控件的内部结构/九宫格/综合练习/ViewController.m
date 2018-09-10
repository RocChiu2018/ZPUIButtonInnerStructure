//
//  ViewController.m
//  综合练习
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "Shop.h"
#import "ZPShopView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *shopsView;
@property (strong, nonatomic) NSArray *shopsArray;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UILabel *hud;


@end

@implementation ViewController

#pragma mark ————— 懒加载 —————
-(NSArray *)shopsArray
{
    if (_shopsArray == nil)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shops" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        //封装对象
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray)
        {
            Shop *shop = [Shop shopWithDict:dict];
            [tempArray addObject:shop];
        }
        
        _shopsArray = tempArray;
    }
    
    return _shopsArray;
}

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建添加按钮
    self.addButton = [self addButtonWithImage:@"add" highlightedImage:@"add_highlighted" disabledImage:@"add_disabled" frame:CGRectMake(30, 80, 50, 50) action:@selector(add)];
    
    //创建删除按钮
    self.removeButton = [self addButtonWithImage:@"remove" highlightedImage:@"remove_highlighted" disabledImage:@"remove_disabled" frame:CGRectMake(270, 80, 50, 50) action:@selector(remove)];
    
    //一开始不能使用删除按钮
    self.removeButton.enabled = NO;
    
    /**
     xib文件编译以后就会变为nib文件
     */

    //加载xib文件的方法1：
//    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"Test" owner:nil options:nil];
//    [self.view addSubview:[objects objectAtIndex:0]];
    
    /**
     加载xib文件的方法2：
     一个UINib对象就代表一个xib文件
     */
//    UINib *nib = [UINib nibWithNibName:@"Test" bundle:[NSBundle mainBundle]];
////    UINib *nib = [UINib nibWithNibName:@"Test" bundle:nil];  //如果bundle参数传nil的话，则默认就是mainBundle，所以这句代码等同于上一句
//    NSArray *objects = [nib instantiateWithOwner:nil options:nil];  //初始化刚才得到的nib文件
//    [self.view addSubview:[objects lastObject]];
}

#pragma mark ————— 创建按钮 —————
-(UIButton *)addButtonWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage disabledImage:(NSString *)disabledImage frame:(CGRect)frame action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:disabledImage] forState:UIControlStateDisabled];
    button.frame = frame;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    return button;
}

#pragma mark ————— 点击添加按钮 —————
-(void)add
{
    //使超过视图部分的控件都不显示出来
    self.shopsView.clipsToBounds = YES;
    
    //每一个商品的尺寸
    CGFloat shopW = 80;
    CGFloat shopH = 90;
    
    //一行的列数
    int cols = 3;
    
    //每一列之间的间距
    CGFloat colMargin = (self.shopsView.frame.size.width - cols * shopW) / (cols - 1);
    //每一行之间的距离
    CGFloat rowMargin = 10;
    
    //商品的索引
    NSUInteger index = self.shopsView.subviews.count;
    
    //创建一个父控件，用于存放图片和文字
    ZPShopView *shopView = [ZPShopView shopViewWithShop:[self.shopsArray objectAtIndex:index]];
    
    //商品所在的列数（取余数）
    NSUInteger col = index % cols;
    
    //商品的x值
    CGFloat shopX = col * (shopW + colMargin);
    
    //商品所在的行数（取商）
    NSUInteger row = index / cols;
    
    //商品的y值
    CGFloat shopY = row * (shopH + rowMargin);
    
    shopView.frame = CGRectMake(shopX, shopY, shopW, shopH);
    [self.shopsView addSubview:shopView];
    
    [self checkState];
}

#pragma mark ————— 点击删除按钮 —————
-(void)remove
{
    [self.shopsView.subviews.lastObject removeFromSuperview];
    
    [self checkState];
}

#pragma mark ————— 检测按钮的状态 —————
-(void)checkState
{
    if (self.shopsView.subviews.count == 0)
    {
        self.addButton.enabled = YES;
        self.removeButton.enabled = NO;
    }else if (self.shopsView.subviews.count > 0 && self.shopsView.subviews.count < self.shopsArray.count)
    {
        self.addButton.enabled = YES;
        self.removeButton.enabled = YES;
    }else if (self.shopsView.subviews.count == self.shopsArray.count)
    {
        self.addButton.enabled = NO;
        self.removeButton.enabled = YES;
    }
    
    NSString *text = nil;
    if (self.removeButton.enabled == NO)
    {
        text = @"已经全部删除了";
    }else if(self.addButton.enabled == NO)
    {
        text = @"已经添加满了";
    }
    
    if (text)
    {
        self.hud.alpha = 1.0;
        self.hud.text = text;
        
        [self performSelector:@selector(hideHud:) withObject:@"123" afterDelay:2.0];
    }else
    {
        return;
    }
}

#pragma mark ————— 隐藏提示框 —————
-(void)hideHud:(NSString *)parameter
{
    self.hud.alpha = 0.0;
    
    NSLog(@"parameter = %@", parameter);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
