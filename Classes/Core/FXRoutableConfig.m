//
//  FXRoutableConfig.m
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "FXRoutableConfig.h"

@implementation FXRoutableConfig

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static FXRoutableConfig*sharedObject;
    dispatch_once(&onceToken, ^{
        sharedObject = [[FXRoutableConfig alloc] init];
        [sharedObject singleInit];
    });
    return sharedObject;
}

-(void) singleInit {
    _defaultNavigationControllerClass = [UINavigationController class];
}

-(void) setWebViewControllerClass:(Class) webViewControllerClass {
    if (webViewControllerClass) {
        if ([webViewControllerClass conformsToProtocol:@protocol(IFXWebRoutableProtocol)]) {
            _defaultWebViewControllerClass = webViewControllerClass;
        } else {
            NSString *reason = [NSString stringWithFormat:@"%@ 没有实现协议 IFXWebRoutableProtocol",NSStringFromClass(webViewControllerClass)];
            @throw [NSException exceptionWithName:@"FXRoutableConfigException" reason:reason userInfo:nil];
        }
    }
}

-(void) setNavigationControllerClass:(Class) navigationControllerClass {
    if ([navigationControllerClass isSubclassOfClass:[UINavigationController class]]) {
        _defaultNavigationControllerClass = navigationControllerClass;
    } else {
        NSString *reason = [NSString stringWithFormat:@"%@ 非UINavigationController子类",NSStringFromClass(navigationControllerClass)];
        @throw [NSException exceptionWithName:@"FXRoutableConfigException" reason:reason userInfo:nil];
    }
}

-(void) setRegisterClass:(Class)urlRegisterClass {
    if (urlRegisterClass) {
        if ([urlRegisterClass conformsToProtocol:@protocol(IFXRegisterRoutableProtocol)]) {
            _urlRegisterClass = urlRegisterClass;
        } else {
            NSString *reason = [NSString stringWithFormat:@"%@ 没有实现协议 IFXRegisterRoutableProtocol",NSStringFromClass(urlRegisterClass)];
            @throw [NSException exceptionWithName:@"FXRoutableConfigException" reason:reason userInfo:nil];
        }
    }
}

@end
