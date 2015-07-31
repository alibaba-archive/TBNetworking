//
//  TBLogger.m
//  TBNetworking
//
//  Created by ChenHao on 7/30/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBLogger.h"
#import "TBAPIResponse.h"

@implementation TBLogger


+ (void)loggerWithRequest:(TBAPIBaseRequest *)request {

#ifdef DEBUG
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                      Request Response                      =\n==============================================================\n\n"];
    
    [logString appendFormat:@"HTTP   state:\t\t%ld\n",[request.response statusCode]];
    [logString appendFormat:@"Hash     Key:\t\t%lu\n",[request hash]];
    [logString appendFormat:@"API     Name:\t\t%@\n",[request class]];
    [logString appendFormat:@"Base     Url:\t\t%@\n",[request baseUrl]];
    [logString appendFormat:@"Request  url:\t\t%@\n",[request.child requestUrl]];
    [logString appendFormat:@"absolute url:\t\t%@\n",request.dataTask.response.URL.absoluteString];
    [logString appendFormat:@"Request Type:\t\t%ld\n",[request requestType]];
    [logString appendFormat:@"ResponseObject:\t\t%@\n",[request.response responseObject]];
    [logString appendFormat:@"Request Time:\t\t%lfs\n",(double)[request requestTime]];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    NSLog(@"%@",logString);
    
#endif

}

+ (void)loggerWithRequest:(TBAPIBaseRequest *)request error:(NSError *)error {
#ifdef DEBUG
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                      Request Response                      =\n==============================================================\n\n"];
    
    [logString appendFormat:@"HTTP   state:\t\t%ld\n",[request.response statusCode]];
    [logString appendFormat:@"Hash     Key:\t\t%lu\n",[request hash]];
    [logString appendFormat:@"API     Name:\t\t%@\n",[request class]];
    [logString appendFormat:@"Base     Url:\t\t%@\n",[request baseUrl]];
    [logString appendFormat:@"Request  url:\t\t%@\n",[request.child requestUrl]];
    [logString appendFormat:@"absolute url:\t\t%@\n",request.dataTask.response.URL.absoluteString];
    [logString appendFormat:@"Request Type:\t\t%ld\n",[request requestType]];
    [logString appendFormat:@"Request Time:\t\t%lfs\n",(double)[request requestTime]];
    [logString appendFormat:@"Error     :\t\t%@\n",error];
    
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    NSLog(@"%@",logString);
    
#endif
    
}


@end
