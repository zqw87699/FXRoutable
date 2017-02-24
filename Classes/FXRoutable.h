//
//  FXRoutable.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IFXRoutableProtocol.h"
#import "FXRouterOption.h"

#define FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER [[[[UIApplication sharedApplication] delegate] window] rootViewController]

@interface FXRoutable : NSObject

+ (instancetype)sharedInstance;

/*
 *  注册路由(block)
 */
- (void)registe:(NSString *)format toCallback:(FXRouterOpenCallback)callback wihOptions:(FXRouterOption*)option;

/*
 *  注册路由
 */
- (void)registe:(NSString *)format toController:(Class)controllerClass withOptions:(FXRouterOption *)option;

/**
 *  设置回退节点
 */
- (void)setReturnNode:(UIViewController<IFXRoutableProtocol>*)returnNode;

/**
 *  设置回退根节点
 */
- (void)setReturnRootNode:(UIViewController<IFXRoutableProtocol>*)returnRootNode;

/**
 *  打开回退节点
 */
- (BOOL)openReturnNode:(BOOL)animated;

/**
 *  打开回退根节点
 */
- (BOOL)openReturnRootNode:(BOOL)animated;

/**
 *  打开外部url
 */
- (void)openExternal:(NSString *)url;

/**
 *  打开url
 */
- (void)open:(NSString *)url animated:(BOOL)animated;

/**
 *  打开url(带参数)
 */
- (void)open:(NSString *)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams;

/**
 *  打开root页面
 */
- (void)openRoot:(UIViewController*) rootViewController;
/**
 *  关闭视图控制器（当导航控制器[viewControllers count] == 1时，执行dismiss:completion: 否则执行 pop:）
 *
 *  @param animated 动画
 */
- (void) close:(BOOL) animated;

/**
 *  关闭所有视图控制器（当rootViewController有模态视图控制器打开时则关闭模态，否则执行popRoot）
 */
- (void) closeAll:(BOOL) animated;

@end
