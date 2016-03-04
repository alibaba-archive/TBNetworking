//
//  TBLogger.m
//  TBNetworking
//
//  Created by ChenHao on 7/30/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBLogger.h"
#import "TBAPIResponse.h"
#import "TBAPIBaseManager.h"

@implementation TBLogger


+ (void)loggerWithRequest:(TBAPIBaseManager *)request responseType:(TBLoggerType )type{

#ifdef DEBUG
    
    if (type == TBLoggerTypeNone) {
        return;
    }
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                      Request Response                      =\n==============================================================\n\n"];
    
    [logString appendFormat:@"HTTP   state:\t\t%ld\n",(long)[request.response statusCode]];
    [logString appendFormat:@"Hash     Key:\t\t%lu\n",(unsigned long)[request hash]];
    [logString appendFormat:@"API     Name:\t\t%@\n",[request class]];
    [logString appendFormat:@"Base     Url:\t\t%@\n",[request baseUrl]];
    [logString appendFormat:@"Request  url:\t\t%@\n",[request.child requestUrl]];
    [logString appendFormat:@"absolute url:\t\t%@\n",request.dataTask.response.URL.absoluteString];
    [logString appendFormat:@"Request Type:\t\t%@\n",[self typeString:[request requestType]]];
    if (type == TBLoggerTypeDetail) {
        [logString appendFormat:@"ResponseObject:\t\t%@\n",[request.response responseObject]];
    }
    [logString appendFormat:@"Request Time:\t\t%lfs\n",(double)[request requestTime]];
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    NSLog(@"%@",logString);
    
#endif

}

+ (void)loggerWithRequest:(TBAPIBaseManager *)request error:(NSError *)error responseType:(TBLoggerType )type{
#ifdef DEBUG
    
    if (type == TBLoggerTypeNone) {
        return;
    }
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                      Request Response                      =\n==============================================================\n\n"];
    
    [logString appendFormat:@"HTTP   state:\t\t%ld\n",(long)[request.response statusCode]];
    [logString appendFormat:@"Hash     Key:\t\t%lu\n",(unsigned long)[request hash]];
    [logString appendFormat:@"API     Name:\t\t%@\n",[request class]];
    [logString appendFormat:@"Base     Url:\t\t%@\n",[request baseUrl]];
    [logString appendFormat:@"Request  url:\t\t%@\n",[request.child requestUrl]];
    [logString appendFormat:@"absolute url:\t\t%@\n",request.dataTask.response.URL.absoluteString];
    [logString appendFormat:@"Request Type:\t\t%@\n",[self typeString:[request requestType]]];
    [logString appendFormat:@"Request Time:\t\t%lfs\n",(double)[request requestTime]];
    [logString appendFormat:@"Error     :\t\t%@\n",error];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    NSLog(@"%@",logString);
    
#endif
    
}

+ (void)TBLog:(NSString *)log {
#ifdef DEBUG
    NSLog(@"%@",log);
#endif
    
}

+ (NSString *)typeString:(TBAPIRequestType )type {

    NSString *typeStr = nil;
    switch (type) {
        case TBAPIManagerRequestTypeGET:
        {
            typeStr = @"GET";
        }
            break;
        case TBAPIManagerRequestTypePOST:
        {
            typeStr = @"POST";
        }
            break;
        case TBAPIManagerRequestTypePUT:
        {
            typeStr = @"PUT";
        }
            break;
        case TBAPIManagerRequestTypeDELETE:
        {
            typeStr = @"DELETE";
        }
            break;
            
        default:
            break;
    }
    return typeStr;
}


@end
