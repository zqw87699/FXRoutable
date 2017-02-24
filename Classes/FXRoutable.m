//
//  FXRoutable.m
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "FXRoutable.h"
#import "FXRoutableConfig.h"
#import "FXLogMacros.h"
#import "FXCommon.h"

@interface FXRoutable()

@property (nonatomic,strong) NSMutableDictionary*routes;

@property (nonatomic,strong) NSMutableArray*returnNodes;

@end

@implementation FXRoutable

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static FXRoutable*sharedObject;
    dispatch_once(&onceToken, ^{
        sharedObject = [[FXRoutable alloc] init];
        [sharedObject singleInit];
    });
    return sharedObject;
}

-(void) singleInit {
    self.routes = [[NSMutableDictionary alloc] init];
    self.returnNodes = [[NSMutableArray alloc] init];
    
    Class registerClazz = [[FXRoutableConfig sharedInstance] urlRegisterClass];
    if (registerClazz) {
        [registerClazz routerURLRegister:self];
    } else {
        NSString *reason = @"没有找到 RegisterClass 类型，请在FXRoutableConfig中配置";
        FXLogError(reason);
        @throw [NSException exceptionWithName:@"RoutableInitializerException"
                                       reason:reason
                                     userInfo:nil];
    }
}

- (void)registe:(NSString *)format toCallback:(FXRouterOpenCallback)callback wihOptions:(FXRouterOption *)option{
    if (!option) {
        option = [FXRouterOption routerOptions];
    }
    option.callback = callback;
    
    [self.routes setObject:option forKey:format];
}

- (void)registe:(NSString *)format toController:(Class)controllerClass withOptions:(FXRouterOption *)option{
    if (!option) {
        option = [FXRouterOption routerOptions];
    }
    
    if (controllerClass != Nil && [controllerClass conformsToProtocol:@protocol(IFXRoutableProtocol)]) {
        option.openClass = controllerClass;
    } else {
        FXLogError(@"%@未实现IFXRoutableProtocol协议",controllerClass);
        @throw [NSException exceptionWithName:@"RouteControllerClass"
                                       reason:@"Route controller class invalid（non IFXRoutableProtocol）"
                                     userInfo:nil];
        return;
    }
    [self.routes setObject:option forKey:format];
}

- (void)setReturnNode:(UIViewController<IFXRoutableProtocol> *)returnNode{
    [self.returnNodes addObject:returnNode];
}

- (void)setReturnRootNode:(UIViewController<IFXRoutableProtocol> *)returnRootNode{
    [self.returnNodes removeAllObjects];
    [self.returnNodes addObject:returnRootNode];
}

- (BOOL)openReturnNode:(BOOL)animated{
    BOOL result = NO;
    if ([_returnNodes count] >0) {
        if ([_returnNodes lastObject] == FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER) {
            [FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER dismissViewControllerAnimated:animated completion:NULL];
            result = YES;
        } else {
            NSArray *allModels = [ self allModalControllers];
            for (UIViewController *model in allModels) {
                if ([model isKindOfClass:[UITabBarController class]]) {
                    UIViewController *selectedVC = [(UITabBarController*)model selectedViewController];
                    if (selectedVC == [_returnNodes lastObject]) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                            result = YES;
                            break;
                        }
                    } else if ([selectedVC isKindOfClass:[UINavigationController class]] && [[selectedVC childViewControllers] containsObject:[_returnNodes lastObject]]) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                        }
                        [(UINavigationController*)selectedVC popToViewController:[_returnNodes lastObject] animated:animated];
                        result = YES;
                        break;
                    }
                } else if ([model isKindOfClass:[UINavigationController class]]) {
                    if ([[model childViewControllers] containsObject:[_returnNodes lastObject]]) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                        }
                        [(UINavigationController*)model popToViewController:[_returnNodes lastObject] animated:animated];
                        result = YES;
                        break;
                    }
                } else if ([model isKindOfClass:[UIViewController class]]) {
                    if (model == [_returnNodes lastObject]) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                        }
                        result = YES;
                        break;
                    }
                }
            }
        }
        [_returnNodes removeLastObject];
    }
    return result;
}

- (BOOL)openReturnRootNode:(BOOL)animated{
    BOOL result = NO;
    if ([_returnNodes count] >0) {
        if ([_returnNodes firstObject] == FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER) {
            [FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER dismissViewControllerAnimated:animated completion:NULL];
            result = YES;
        } else {
            NSArray *allModels = [ self allModalControllers];
            for (UIViewController *model in allModels) {
                if ([model isKindOfClass:[UITabBarController class]]) {
                    UIViewController *selectedVC = [(UITabBarController*)model selectedViewController];
                    if (selectedVC == [_returnNodes firstObject]) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                            result = YES;
                            break;
                        }
                    } else if ([selectedVC isKindOfClass:[UINavigationController class]] && [[selectedVC childViewControllers] containsObject:[_returnNodes firstObject]]) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                        }
                        [(UINavigationController*)selectedVC popToViewController:[_returnNodes firstObject] animated:animated];
                        result = YES;
                        break;
                    }
                } else if ([model isKindOfClass:[UINavigationController class]]) {
                    if ([[model childViewControllers] containsObject:[_returnNodes firstObject]]) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                        }
                        [(UINavigationController*)model popToViewController:[_returnNodes firstObject] animated:animated];
                        result = YES;
                        break;
                    }
                } else if ([model isKindOfClass:[UIViewController class]]) {
                    if (model == [_returnNodes firstObject]) {
                        if ([model presentedViewController]) {
                            [model dismissViewControllerAnimated:animated completion:NULL];
                        }
                        result = YES;
                        break;
                    }
                }
            }
        }
        [_returnNodes removeAllObjects];
    }
    return result;
}

- (void)openExternal:(NSString *)url{
    FXLogDebug(@"打开外部链接:%@",url);
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:NULL];
#else
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
#endif
}

- (void)open:(NSString *)url animated:(BOOL)animated{
    [self open:url animated:animated extraParams:nil];
}

- (void)open:(NSString *)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams {
    if ([NSThread isMainThread]) {
        [self openUrl:url animated:animated extraParams:extraParams];
    } else {
        FX_WEAK_REF_TYPE selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [selfObject openUrl:url animated:animated extraParams:extraParams];
        });
    }
}

- (void)openUnRegisterUrl:(NSString *)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams{
    FXLogDebug(@"未注册路由链接:%@",url);
    FXRouterOption * option = [FXRouterOption routerOptions];
    UIViewController*controller=nil;
    
    Class webVCClazz = option.webViewControllerClass;
    if (webVCClazz != Nil) {
        if ([webVCClazz canOpenURL:url]) {
            FXLogDebug(@"%@ 可以打开此链接:%@",NSStringFromClass(webVCClazz),url);
            NSMutableDictionary *mutableExtraParams = [[NSMutableDictionary alloc] init];
            if ([[option defaultParams] count] > 0) {
                [mutableExtraParams addEntriesFromDictionary:[option defaultParams]];
            }
            if ([extraParams count] > 0) {
                [mutableExtraParams addEntriesFromDictionary:extraParams];
            }
            controller = [[webVCClazz alloc] initWithURL:url routerParams:mutableExtraParams];
        } else {
            FXLogDebug(@"%@ 无法打开链接(使用浏览器打开):%@",NSStringFromClass(webVCClazz),url);
            [self openExternal:url];//使用原始链接打开
            return;
        }
    } else {
        FXLogDebug(@"没有找到WebVC，使用浏览器打开此链接:%@",url);
        [self openExternal:url];//使用原始链接打开
        return;
    }
}

- (void)openUrl:(NSString *)url animated:(BOOL)animated extraParams:(NSDictionary *)extraParams{
    FXLogDebug(@"打开路由链接:%@",url);
    
    if (![[self.routes allKeys] containsObject:url]) {
        [self openUnRegisterUrl:url animated:animated extraParams:extraParams];
        return;
    }
    
    FXRouterOption *option = [self.routes objectForKey:url];
    NSMutableDictionary*params = [[NSMutableDictionary alloc] initWithDictionary:option.defaultParams];
    [params addEntriesFromDictionary:extraParams];
    
    if (option.callback) {
        FXRouterOpenCallback callback = option.callback;
        callback(params);
        return;
    }
    
    UIViewController *controller = nil;
    if (![option.openClass conformsToProtocol:@protocol(IFXRoutableProtocol)]) {
        @throw [NSException exceptionWithName:@"RoutableInitializerNotFound"
                                       reason:[NSString stringWithFormat:@"%@没有实现IFXRoutableProtocol协议",option.openClass]
                                     userInfo:nil];
        return;
    }
    controller = [[option.openClass alloc] initWithURL:url routerParams:params];
    controller.modalTransitionStyle = option.transitionStyle;
    controller.modalPresentationStyle = option.presentationStyle;
    
    if ([option isModal]) {
        NSArray *modals = [self allModalControllers];
        id presentingVC = [modals lastObject];
        
        if ([controller isKindOfClass:[UINavigationController class]]) {
            [presentingVC presentViewController:controller animated:animated completion:NULL];
        } else {
            UINavigationController *nav = nil;
            Class navClazz = option.navigationControllerClass;
            if (navClazz != Nil) {
                nav= [[navClazz alloc] initWithRootViewController:controller];
            } else {
                nav = [[UINavigationController alloc] initWithRootViewController:controller];
            }
            FXLogDebug(@"模态打开视图控制器:%@",NSStringFromClass(controller.class));
            [presentingVC presentViewController:nav animated:animated completion:NULL];
        }
    } else {
        UINavigationController *nav = [self currentNavigationController];
        FXLogDebug(@"推送打开视图控制器:%@",NSStringFromClass(controller.class));
        [nav pushViewController:controller animated:animated];
    }
}

- (void)openRoot:(id)rootViewController{
    if ([NSThread isMainThread]) {
        if (rootViewController) {
            if ([FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER presentedViewController]) {
                [FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER dismissViewControllerAnimated:NO completion:NULL];
            }
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:rootViewController];
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (rootViewController) {
                if ([FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER presentedViewController]) {
                    [FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER dismissViewControllerAnimated:NO completion:NULL];
                }
                [[[[UIApplication sharedApplication] delegate] window] setRootViewController:rootViewController];
            }
        });
    }
}

-(void)close:(BOOL)animated {
    if ([NSThread isMainThread]) {
        UINavigationController *nav = [self currentNavigationController];
        if (nav) {
            if ([[nav viewControllers] count] > 1) {
                [nav popViewControllerAnimated:animated];
            } else if(nav.presentingViewController) {
                [nav dismissViewControllerAnimated:animated completion:NULL];
            }
        } else if ([[self allModalControllers] count] > 0) {
            [[[self allModalControllers] lastObject] dismissViewControllerAnimated:animated completion:NULL];
        }
    } else {
        FX_BLOCK_WEAK FXRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            UINavigationController *nav = [selfObject currentNavigationController];
            if (nav) {
                if ([[nav viewControllers] count] > 1) {
                    [nav popViewControllerAnimated:animated];
                } else if(nav.presentingViewController) {
                    [nav dismissViewControllerAnimated:animated completion:NULL];
                }
            } else if ([[selfObject allModalControllers] count] > 0) {
                [[[self allModalControllers] lastObject] dismissViewControllerAnimated:animated completion:NULL];
            }
        });
    }
    
}
-(void)closeAll:(BOOL)animated {
    if ([NSThread isMainThread]) {
        NSArray *modals = [self allModalControllers];
        if ([modals count] > 1) {
            [[modals firstObject] dismissViewControllerAnimated:animated completion:NULL];
        } else {
            UINavigationController *nav = [self currentNavigationController];
            [nav popToRootViewControllerAnimated:animated];
        }
    } else {
        FX_BLOCK_WEAK FXRoutable *selfObject = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *modals = [selfObject allModalControllers];
            if ([modals count] > 1) {
                [[modals firstObject] dismissViewControllerAnimated:animated completion:NULL];
            } else {
                UINavigationController *nav = [selfObject currentNavigationController];
                [nav popToRootViewControllerAnimated:animated];
            }
        });
    }
    
}

/**
 *  所有的模态视图控制器
 */
-(NSArray*) allModalControllers {
    UIViewController *presentingViewController = FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER;
    NSMutableArray *presenteds = [[NSMutableArray alloc] initWithObjects:presentingViewController, nil];
    BOOL endTag = YES;
    while (endTag) {
        if (presentingViewController.presentedViewController) {
            [presenteds addObject:presentingViewController.presentedViewController];
            presentingViewController = presentingViewController.presentedViewController;
        } else {
            endTag = NO;
        }
    }
    return presenteds;
}

/**
 *  当前视图控制器
 */
-(UINavigationController*) currentNavigationController {
    UINavigationController *navigationController = nil;
    NSArray *presentings = [self allModalControllers];
    UIViewController *presentingViewController = [presentings lastObject];
    if (presentingViewController == FX_UIROUTABLER_APP_WINDOW_ROOT_VIEW_CONTROLLER) {
        if ([presentingViewController isKindOfClass:[UITabBarController class]]) {
            UIViewController *selectedVC = [(UITabBarController*)presentingViewController selectedViewController];
            if ([selectedVC isKindOfClass:[UINavigationController class]]) {
                navigationController = (UINavigationController*)selectedVC;
            }
        }
    }
    if (!navigationController && [presentingViewController isKindOfClass:[UINavigationController class]]) {
        navigationController = (UINavigationController*)presentingViewController;
    }
    return navigationController;
}

@end
