//
//  ZPShopView.h
//  综合练习
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 apple. All rights reserved.
//


#import <UIKit/UIKit.h>

@class Shop;

@interface ZPShopView : UIButton

@property (nonatomic, strong) Shop *shop;

//构造方法
+ (instancetype)shopViewWithShop:(Shop *)shop;

@end
