//
//  RepositoryViewController.m
//  GithubClient
//
//  Created by qwerty on 24/03/2019.
//  Copyright © 2019 Yuriy Craft. All rights reserved.
//

#import "RepositoryViewController.h"
#import "RepoTableViewCell.h"
#import "RepoPresenter.h"
#import "CommitsViewController.h"


@interface RepositoryViewController () <UITableViewDelegate, UITableViewDataSource, YCPresenterDelegate>
@property (strong, nonatomic) RepoPresenter *presenter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation RepositoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[RepoPresenter alloc] init];
    [self configTableView];
    self.presenter.delegate = self;
    [self.presenter searchReposWithText:@"swift" nextPage:NO];
}

#pragma mark - TableView

- (void)configTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"RepoTableViewCell" bundle:nil] forCellReuseIdentifier:@"RepoTableViewCell"];
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
    RepoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepoTableViewCell" forIndexPath:indexPath];
    Repo *repo = [self.presenter objectForIndex:indexPath];
    [cell configWithName:repo.name description:repo.desc];
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
    Repo *repo = [self.presenter objectForIndex:indexPath];
    CommitsViewController *vc = [[UIStoryboard storyboardWithName:@"Main"
                                                           bundle:NULL] instantiateViewControllerWithIdentifier:@"CommitsViewController"];
    vc.repoFullName = repo.name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.presenter numberOfRows] > 1) {
        if (indexPath.row == [self.presenter numberOfRows] - 1) {
            [self.presenter searchReposWithText:@"swift" nextPage:YES];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Actions

- (void)pullToRefreshAction:(UIRefreshControl *)sender {
    [self.presenter searchReposWithText:@"swift" nextPage:NO];
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

#pragma mark - Presenter Delegate

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
            RepoTableViewCell *cell = (RepoTableViewCell*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            if (cell) {
                Repo *repo = [self.presenter objectForIndex:[NSIndexPath indexPathForRow:index inSection:0]];
                [cell configWithName:repo.name description:repo.desc];
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
