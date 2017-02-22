//
//  IFXRegisterRoutableProtocol.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXRoutable.h"

@protocol IFXRegisterRoutableProtocol <NSObject>

/**
 *  注册URL
 */
+(void) routerURLRegister:(FXRoutable*) routable;

@end
