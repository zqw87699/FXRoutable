//
//  FXRoutableConfig.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IFXWebRoutableProtocol.h"
#import "IFXRegisterRoutableProtocol.h"

@interface FXRoutableConfig : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly) Class defaultWebViewControllerClass;

/**
 *  默认导航视图控制器
 *  Default UINavigationController
 */
@property (nonatomic, readonly) Class defaultNavigationControllerClass;

/**
 *  url 注册器，必须实现协议 IFXRegisterRoutableProtocol
 */
@property (nonatomic, readonly) Class urlRegisterClass;

-(void) setWebViewControllerClass:(Class) webViewControllerClass;

-(void) setNavigationControllerClass:(Class) navigationControllerClass;

-(void) setRegisterClass:(Class) urlRegisterClass;

@end
