//
//  CommitsViewController.m
//  GithubClient
//
//  Created by book on 26/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "CommitsViewController.h"
#import "CommitsPresenter.h"
#import "CommitTableViewCell.h"
#import "Commit+CoreDataProperties.h"
#import "User+CoreDataProperties.h"

@interface CommitsViewController ()  <UITableViewDelegate, UITableViewDataSource, YCPresenterDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CommitsPresenter *presenter;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation CommitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[CommitsPresenter alloc] initWithFullName:self.repoFullName];
    [self configTableView];
    self.presenter.delegate = self;
    if (self.repoFullName)
        [self.presenter commitsWithRepoFullName:self.repoFullName nextPage:NO];
}

- (void)dealloc {
    self.presenter.delegate = nil;
}

#pragma mark - TableView

- (void)configTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CommitTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommitTableViewCell"];
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [self.refreshControl addTarget:self action:@selector(pullToRefreshAction:) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [self.tableView setRefreshControl:self.refreshControl];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.tableView addSubview:self.refreshControl];
    }
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommitTableViewCell" forIndexPath:indexPath];
    Commit *commit = [self.presenter objectForIndex:indexPath];
    [cell configWithAuthorName:commit.owner.name avatarString:commit.owner.avatar_url messageString:commit.message sha:commit.sha];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presenter numberOfRows];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - Actions

- (void)pullToRefreshAction:(UIRefreshControl *)sender {
    [self.presenter commitsWithRepoFullName:self.repoFullName nextPage:NO];
}

- (void)setLoading:(BOOL)loading {
    if (!loading)
        [self.refreshControl endRefreshing];
    else
        if (!self.refreshControl.isRefreshing)
            [self.refreshControl beginRefreshing];
}

#pragma mark - Orientation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if ([self isViewLoaded])
        [self.tableView reloadData];
}

- (void)presenter:(YCPresenter *)presenter didChangeStateLoading:(BOOL)loading {
    [self setLoading:loading];
}

- (void)presenter:(YCPresenter *)presenter didItemsLoaded:(BOOL)successfully {
    [self setLoading:!successfully];
}

- (void)presenterWillChangeObjects:(YCPresenter *)presenter {
    if (![self isViewLoaded])
        return;
    [self.tableView beginUpdates];
}

- (void)presenterDidChangeObjects:(YCPresenter *)presenter {
    if (![self isViewLoaded])
        return;
    [self.tableView endUpdates];
}

- (void)presenter:(YCPresenter *)presenter didChangeObject:(id)object atIndex:(NSUInteger)index forChangeType:(NSFetchedResultsChangeType)type newIndex:(NSUInteger)newIndex {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:newIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        case NSFetchedResultsChangeUpdate: {
            CommitTableViewCell *cell = (CommitTableViewCell*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            if (cell) {
                Commit *commit = [self.presenter objectForIndex:[NSIndexPath indexPathForRow:index inSection:0]];
                [cell configWithAuthorName:commit.owner.name avatarString:commit.owner.avatar_url messageString:commit.message sha:commit.sha];
            }
        }
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:newIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            break;
    }
}

@end
