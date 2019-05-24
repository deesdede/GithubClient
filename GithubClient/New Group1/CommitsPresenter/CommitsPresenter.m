//
//  CommitsPresenter.m
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "CommitsPresenter.h"
#import "ApiManager.h"

@interface CommitsPresenter () <ApiManagerDelegate>

@property (strong, nonatomic) ApiManager *apiManger;
@property (assign, nonatomic) BOOL isLoading;
@property (strong, nonatomic) NSString* fullName;
@end

@implementation CommitsPresenter

- (instancetype)initWithFullName:(NSString*)fullName {
    self = [super init];
    if (self) {
        self.fullName = fullName;
        self.apiManger = [[ApiManager alloc] init];
        self.apiManger.delegate = self;
        [self initialise];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.apiManger = [[ApiManager alloc] init];
        self.apiManger.delegate = self;
    }
    return self;
}

- (void)commitsWithRepoFullName:(NSString*)fullName nextPage:(BOOL)nextPage {
    self.fullName = fullName;
    if (self.isLoading && nextPage)
        return;
    self.isLoading = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(presenter:didChangeStateLoading:)])
        [self.delegate presenter:self didChangeStateLoading:YES];
    
    typeof(self) __weak weakSelf = self;
    [self.apiManger commitsWithRepoFullName:fullName complitionBlock:^(BOOL isComplition) {
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            if (isComplition) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(presenter:didChangeStateLoading:)])
                    [self.delegate presenter:self didChangeStateLoading:YES];
                if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(presenter:didItemsLoaded:)])
                    [strongSelf.delegate presenter:self didItemsLoaded:YES];
            } else {
                if (self.delegate && [self.delegate respondsToSelector:@selector(presenter:didChangeStateLoading:)])
                    [self.delegate presenter:self didChangeStateLoading:NO];
            }
        }
        strongSelf.isLoading = NO;
    }];
}

- (NSFetchRequest*)createRequest {
    if (self.fullName) {
        NSFetchRequest *request =  [[NSFetchRequest alloc] initWithEntityName:@"Commit"];
        [request setPredicate:[NSPredicate predicateWithFormat:@"repoFullName == %@", self.fullName]];
        [request setSortDescriptors:@[
                                      [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]
                                      ]];
        request.relationshipKeyPathsForPrefetching = [NSArray arrayWithObject:@"owner"];
        
        request.includesPropertyValues = YES;
        request.returnsObjectsAsFaults = NO;
        return request;
    }
    return nil;
}

@end
