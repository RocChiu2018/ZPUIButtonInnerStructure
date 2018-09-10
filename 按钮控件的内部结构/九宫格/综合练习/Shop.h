//
//  Shop.h
//  综合练习
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)shopWithDict:(NSDictionary *)dict;

@end
