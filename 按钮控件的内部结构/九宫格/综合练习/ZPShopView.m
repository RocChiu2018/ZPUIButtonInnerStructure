//
//  ZPShopView.m
//  综合练习
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 UIButton控件内部分为左右两个部分，左边的部分是一个小图片，用imageView属性来表示，右边的部分是文字，用titleLabel属性来表示。如果想要更改按钮内部这两个属性的位置，有如下两个方法：
 （1）调用UIButton类里面相应的更改小图片和文字位置的方法来进行调整；
 （2）调用layoutSubviews方法来更改控件内部子控件的位置。
 */
#import "ZPShopView.h"
#import "Shop.h"

@interface ZPShopView ()

@end

@implementation ZPShopView

#pragma mark ————— 构造自定义控件的方法 —————
+ (instancetype)shopViewWithShop:(Shop *)shop
{
    ZPShopView *shopView = [[self alloc] init];
    shopView.backgroundColor = [UIColor redColor];
    shopView.shop = shop;
    
    return shopView;
}

#pragma mark ————— 初始化本控件 —————
/**
 用代码创建本控件的话会调用这个方法，在这个方法里面让字体居中并调整字号。
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    
    return self;
}

#pragma mark ————— 设置数据 —————
-(void)setShop:(Shop *)shop
{
    _shop = shop;
    
    if (shop.icon)
    {
        [self setImage:[UIImage imageNamed:shop.icon] forState:UIControlStateNormal];
    }

    [self setTitle:shop.name forState:UIControlStateNormal];
}

#pragma mark ————— 更改按钮内部原来左侧小图片的位置 —————
/**
 如果想要更改按钮内部左侧小图片的位置就要调用这个方法。
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, 30, 30);
}

#pragma mark ————— 更改按钮内部原来右侧文字的位置 —————
/**
 如果想要更改按钮内部右侧文字的位置就要调用这个方法。
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 30, 70, 30);
}

#pragma mark ————— 更改控件内部子控件的位置 —————
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    CGFloat buttonW = self.frame.size.width;
//    CGFloat buttonH = self.frame.size.height;
//    CGFloat imageH = buttonH - 10;
//
//    self.imageView.frame = CGRectMake(0, 0, buttonW, imageH);
//    self.titleLabel.frame = CGRectMake(0, imageH, buttonW, buttonH - imageH);
//}

@end
