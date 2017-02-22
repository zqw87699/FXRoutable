//
//  IFXWebRoutableProtocol.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFXRoutableProtocol.h"

@protocol IFXWebRoutableProtocol <IFXRoutableProtocol>
/**
 *  是否可以打开此url，如果不能打开则使用浏览器打开
 */
+(BOOL) canOpenURL:(NSString*) URL;

@end
