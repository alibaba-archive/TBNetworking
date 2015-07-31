//
//  TBValidator.h
//  TBNetworking
//
//  Created by ChenHao on 7/31/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBValidator : NSObject


+ (BOOL)checkJsonType:(id)json withValidator:(id)validator;

@end
