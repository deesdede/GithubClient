//
//  YCPresenter.h
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@class YCPresenter;

@protocol YCPresenterDelegate <NSObject>

@optional
- (void)presenter:(YCPresenter*)presenter didChangeStateLoading:(BOOL)loading;
- (void)presenter:(YCPresenter*)presenter didItemsLoaded:(BOOL)successfully;
- (void)presenterDidChangeObjects:(YCPresenter*)presenter;
- (void)presenterWillChangeObjects:(YCPresenter*)presenter;
- (void)presenter:(YCPresenter*)presenter didChangeObject:(id)object atIndex:(NSUInteger)index forChangeType:(NSFetchedResultsChangeType)type newIndex:(NSUInteger)newIndex;
@end

@interface YCPresenter : NSObject

@property (weak, nonatomic) id <YCPresenterDelegate> delegate;
- (void)initialise;
- (NSUInteger)numberOfRows;
- (id)objectForIndex:(NSIndexPath*)indexPath;

@end

NS_ASSUME_NONNULL_END
