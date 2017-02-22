//
//  FXRouterOption.m
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "FXRouterOption.h"
#import "FXRoutableConfig.h"

@implementation FXRouterOption
+ (instancetype)routerOptionsWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                                   transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     defaultParams: (NSDictionary *)defaultParams
                                           isModal: (BOOL)isModal {
    FXRouterOption *options = [[FXRouterOption alloc] init];
    options.presentationStyle = presentationStyle;
    options.transitionStyle = transitionStyle;
    options.defaultParams = defaultParams;
    options.modal = isModal;
    
    options.navigationControllerClass = [[FXRoutableConfig sharedInstance] defaultNavigationControllerClass];
    
    options.webViewControllerClass = [[FXRoutableConfig sharedInstance] defaultWebViewControllerClass];
    
    return options;
}
+ (instancetype)routerOptions {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                            isModal:NO];
}
+ (instancetype)routerOptionsAsModal {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                            isModal:YES];
}
+ (instancetype)routerOptionsWithPresentationStyle:(UIModalPresentationStyle)style {
    return [self routerOptionsWithPresentationStyle:style
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:nil
                                            isModal:NO];
}
+ (instancetype)routerOptionsWithTransitionStyle:(UIModalTransitionStyle)style {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:style
                                      defaultParams:nil
                                            isModal:NO];
}
+ (instancetype)routerOptionsForDefaultParams:(NSDictionary *)defaultParams {
    return [self routerOptionsWithPresentationStyle:UIModalPresentationNone
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                      defaultParams:defaultParams
                                            isModal:NO];
}

@end
