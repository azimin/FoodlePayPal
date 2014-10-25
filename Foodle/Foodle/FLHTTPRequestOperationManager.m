//
//  ETHTTPRequestOperationManager.m
//  easyten
//
//  Created by Nikita Pestrov on 25.08.14.
//  Copyright (c) 2014 cognitico. All rights reserved.
//

#import "FLHTTPRequestOperationManager.h"

@implementation FLHTTPRequestOperationManager

+ (AFHTTPRequestOperationManager *)getBasicManager {
  AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"someurl"]];
  manager.securityPolicy.allowInvalidCertificates = YES;
  return manager;
}

+ (void)parseResponse:(id)response data:(NSData *)data withSuccess:(void (^)(id responseData))success failure:(void (^)(id responseData))failure {
  if (response) {

    NSDictionary *responseDictionary = nil;
    if ([response isKindOfClass:[NSDictionary class]]) {
      responseDictionary = response;
    } else {
      responseDictionary = [NSJSONSerialization JSONObjectWithData:response
                                                           options:kNilOptions
                                                             error:nil];
    }
    
    if ([responseDictionary[@"status"] isEqualToString:@"success"]) {
      if (success)
        success(responseDictionary[@"data"]);
    } else {
      if (failure)
        failure(responseDictionary[@"data"]);
    }
  } else {
    if (failure)
      failure(nil);
  }
}
@end
