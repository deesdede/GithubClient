//
//  YCPresenter.m
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "YCPresenter.h"


@interface YCPresenter() <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *itemsController;
@end

@implementation YCPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initialise {
    [self createControllerAndFetch];
}

- (NSFetchRequest*)createRequest {
    return nil;
}


- (void)createControllerAndFetch {
    NSFetchRequest *request = [self createRequest];
    if (request) {
    _itemsController = [[NSFetchedResultsController alloc]initWithFetchRequest:[self createRequest] managedObjectContext:theApp.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _itemsController.delegate = self;
    [_itemsController performFetch:NULL];
    }
}

- (NSUInteger)numberOfRows {
    return [_itemsController sections][0].numberOfObjects;
}

- (id)objectForIndex:(NSIndexPath*)indexPath {
    return [_itemsController sections][0].objects[indexPath.row];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (self.delegate && [self.delegate respondsToSelector:@selector(presenterWillChangeObjects:)])
        [self.delegate presenterWillChangeObjects:self];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (self.delegate && [self.delegate respondsToSelector:@selector(presenterDidChangeObjects:)])
        [self.delegate presenterDidChangeObjects:self];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(presenter:didChangeObject:atIndex:forChangeType:newIndex:)])
        [self.delegate presenter:self didChangeObject:anObject atIndex:indexPath ? indexPath.row : NSNotFound forChangeType:type newIndex:newIndexPath ? newIndexPath.row : NSNotFound];
}


@end
