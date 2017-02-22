//
//  FXRouterOption.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^FXRouterOpenCallback)(NSDictionary *params);

@interface FXRouterOption : NSObject
@property (readwrite, nonatomic, getter=isModal) BOOL modal;//是否为模态打开
@property (readwrite, nonatomic) UIModalPresentationStyle presentationStyle;
@property (readwrite, nonatomic) UIModalTransitionStyle transitionStyle;
@property (readwrite, nonatomic, strong) NSDictionary *defaultParams;
@property (readwrite, nonatomic) Class navigationControllerClass;//导航控制器Class（当需要用到时会使用）
@property (readwrite, nonatomic) Class webViewControllerClass;//web试图控制器Class（当需要用到时会使用）
@property (readwrite, nonatomic) Class openClass;

@property (readwrite, nonatomic, copy) FXRouterOpenCallback callback;

+ (instancetype)routerOptions;
+ (instancetype)routerOptionsAsModal;
+ (instancetype)routerOptionsWithPresentationStyle:(UIModalPresentationStyle)style;
+ (instancetype)routerOptionsWithTransitionStyle:(UIModalTransitionStyle)style;
+ (instancetype)routerOptionsForDefaultParams:(NSDictionary *)defaultParams;

@end
