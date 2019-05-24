//
//  ApiManager.m
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "ApiManager.h"
#import "AFNetworking.h"
#import "Api.h"
#import "Repo+ResponseDictionary.h"
#import "User+ResponseDictionary.h"
#import "Commit+ResponseDictionary.h"



@interface ApiManager()

@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) NSMutableArray *arrayUsers;
@property (strong, nonatomic) NSMutableArray *arrayCommits;
@property (assign, nonatomic) BOOL loadMore;
@end

@implementation ApiManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.array = [[NSMutableArray alloc] init];
        self.arrayUsers = [[NSMutableArray alloc] init];
        self.arrayCommits = [[NSMutableArray alloc] init];
        self.loadMore = YES;
    }
    return self;
}

- (void)searchRepositoryWithString:(NSString*)searchString withPage:(NSInteger)page complitionBlock:(void (^)(BOOL isComplition)) completionHandler {
    NSString *searchUrl = [NSString stringWithFormat:@"%@/%@/%@",kApiBaseURL, kApiSearchPath, kApiSearchRepositoriesPath];
    NSString* queryString = [NSString stringWithFormat:@"%@:%@", kApiSearchLanguageQualifier, searchString];
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:queryString, kApiSearchQueryParameter, kApiSearchSortsStars, kApiSearchSortParameter, @(page), @"page",@(20), @"per_page", nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:searchUrl parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject[@"items"]) {
            NSNumber *loadmore = responseObject[@"total_count"];
            if (loadmore && [loadmore integerValue] > self.array.count)
                self.loadMore = YES;
            else
                self.loadMore = NO;
            NSArray *items = responseObject[@"items"];
            if (page == 0)
                [self.array removeAllObjects];
          
            for (NSDictionary* item in items) {
                [theApp save:^(NSManagedObjectContext *localContext) {
                    NSNumber *idx = item[@"id"];
                    Repo *repo = [Repo objectWithId:idx inContext:localContext relationshipKeyPathsForPrefetchingArray:[NSArray arrayWithObject:@"owner"]];
                    if (!repo)
                        repo = [Repo createInContext:localContext];
                    
                    [repo populateFromResponseDictionary:item context:localContext];
                    [self.array addObject:repo];
                    [self.arrayUsers addObject:repo.owner];
                }];
            }
            if (self.array.count) {
                [theApp save:^(NSManagedObjectContext *localContext) {
                    [Repo deleteWithPredicate:[NSPredicate predicateWithFormat:@"NOT SELF IN %@" , self.array] inContext:localContext];
                    [User deleteWithPredicate:[NSPredicate predicateWithFormat:@"NOT SELF IN %@" , self.arrayUsers] inContext:localContext];
                }];
            }
            completionHandler(YES);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(NO);
    }];
}

- (void)commitsWithRepoFullName:(NSString*)repoFullName complitionBlock:(void (^)(BOOL isComplition)) completionHandler {
    NSString *searchUrl = [NSString stringWithFormat:@"%@/%@/%@/%@",kApiBaseURL, kApiCommitsReposPath, repoFullName, kApiCommitsCommitsPath];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:searchUrl parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *array = responseObject;
            [self.arrayCommits removeAllObjects];
            for (NSDictionary* item in array) {
                [theApp save:^(NSManagedObjectContext *localContext) {
                    NSString *sha = item[@"sha"];
                    Commit *commit = [Commit objectWithPropertyName:@"sha" andValue:sha inContext:localContext relationshipKeyPathsForPrefetchingArray:[NSArray arrayWithObject:@"owner"]];
                    if (!commit)
                        commit = [Commit createInContext:localContext];
                    [commit populateFromResponseDictionary:item context:localContext];
                    commit.repoFullName = repoFullName;
                    [self.arrayCommits addObject:commit];
                }];
            }
            if (self.arrayCommits.count) {
                [theApp save:^(NSManagedObjectContext *localContext) {
                    [Commit deleteWithPredicate:[NSPredicate predicateWithFormat:@"NOT SELF IN %@" , self.arrayCommits] inContext:localContext];
                }];
            }
            completionHandler(YES);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(NO);
    }];
}
@end
