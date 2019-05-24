//
//  ApiManager.h
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@class ApiManager;
@protocol ApiManagerDelegate <NSObject>

@optional
- (void)isLoading:(BOOL)isLoading;
@end


@interface ApiManager : NSObject

- (void)searchRepositoryWithString:(NSString*)searchString withPage:(NSInteger)page complitionBlock:(void (^)(BOOL isComplition)) completionHandler;
- (void)commitsWithRepoFullName:(NSString*)repoFullName complitionBlock:(void (^)(BOOL isComplition)) completionHandler;
@property (weak, nonatomic) id <ApiManagerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
