//
//  RepoPresenter.m
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "RepoPresenter.h"
#import "ApiManager.h"



@interface RepoPresenter()  <ApiManagerDelegate>

@property (strong, nonatomic) ApiManager *apiManger;
@property (strong, nonatomic) NSMutableArray *arrayRepos;
@property (assign, nonatomic) BOOL isLoading;
@property(nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSFetchedResultsController *itemsController;
@end

@implementation RepoPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialise];
        self.apiManger = [[ApiManager alloc] init];
        self.apiManger.delegate = self;
        self.arrayRepos = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)searchReposWithText:(NSString*)searchText nextPage:(BOOL)nextPage {
    if (self.isLoading && nextPage)
        return;
    self.isLoading = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(presenter:didChangeStateLoading:)])
        [self.delegate presenter:self didChangeStateLoading:YES];
    
    if (!nextPage)
        self.page = 1;// Default in github doc
    typeof(self) __weak weakSelf = self;
    [self.apiManger searchRepositoryWithString:searchText withPage:self.page complitionBlock:^(BOOL isComplition) {
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            if (isComplition) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(presenter:didChangeStateLoading:)])
                    [self.delegate presenter:self didChangeStateLoading:YES];
                if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(presenter:didItemsLoaded:)])
                    [strongSelf.delegate presenter:self didItemsLoaded:YES];
                strongSelf.page++;
            } else {
                if (self.delegate && [self.delegate respondsToSelector:@selector(presenter:didChangeStateLoading:)])
                    [self.delegate presenter:self didChangeStateLoading:NO];
            }
        }
        strongSelf.isLoading = NO;
    }];
}

- (NSFetchRequest*)createRequest {
    NSFetchRequest *request =  [[NSFetchRequest alloc] initWithEntityName:@"Repo"];
    [request setSortDescriptors:@[
                                  [NSSortDescriptor sortDescriptorWithKey:@"stargazers_count" ascending:NO]
                                  ]];
    request.relationshipKeyPathsForPrefetching = [NSArray arrayWithObject:@"owner"];
    request.includesPropertyValues = YES;
    request.returnsObjectsAsFaults = NO;
    return request;
}

@end
