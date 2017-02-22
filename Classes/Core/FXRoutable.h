//
//  FXRoutable.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FXCommon.h"
#import "IFXRoutableProtocol.h"
#import "FXRouterOption.h"

#define FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER [[[[UIApplication sharedApplication] delegate] window] rootViewController]

@interface FXRoutable : NSObject

AS_SINGLETON(FXRoutable);

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

- (void)open:(NSString *)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams;

- (void)openRoot:(UIViewController*) rootViewController;

@end
