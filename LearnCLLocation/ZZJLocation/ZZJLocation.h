//
//  ZZJLocation.h
//  LearnCLLocation
//
//  Created by zhifu360 on 2018/6/6.
//  Copyright © 2018年 智富金融. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@protocol ZZJLocationDelagate <NSObject>

- (void)locationDidEndUpdatingLocation:(Location *)location;

@end

@interface ZZJLocation : NSObject

@property (nonatomic, weak) id<ZZJLocationDelagate>delegate;

///开启定位
- (void)beginUpdatingLocation;

@end
