//
//  IFXRoutableProtocol.h
//  TTTT
//
//  Created by 张大宗 on 2017/2/21.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IFXRoutableProtocol <NSObject>
/**
 *  路由视图控制器初始化方法
 *
 *  @param params   参数
 *
 *  @return 视图控制器
 */
-(id) initWithURL:(NSString*) URL routerParams:(NSDictionary*) params;

@end
