//
//  RCIMUserFeedViewController.m
//  InstaMe
//
//  Created by Roman Churkin on 03.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMUserFeedViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "RCIMInstaUser+Network.h"
#import "RCIMInstaPhotoInfo.h"
#import "RCIMFeedPhotoManager.h"
#import "RCIMInstagramClient.h"

#import "RCIMUserInfoView+ConfigureForUser.h"
#import "RCIMPhotoCell+ConfigureForPhoto.h"

#import "RCIMPhotoDetailsTableViewController.h"
#import "RCIMLoginScreenViewController.h"

@interface RCIMUserFeedViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) RCIMFeedPhotoManager *feedPhotoManager;

@property (strong, nonatomic) RCIMUserInfoView *userInfoViewForSectionHeader;

@end

@implementation RCIMUserFeedViewController

#pragma mark - Properties

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController)
        return _fetchedResultsController;
    
    NSFetchRequest *request =
    [NSFetchRequest fetchRequestWithEntityName:[RCIMInstaPhotoInfo entityName]];
    
    request.predicate =
    [NSPredicate predicateWithFormat:@"%K == %@", RCIMInstaPhotoInfoRelationships.user, self.instaUser];
    
    NSSortDescriptor *dateSortDescriptor =
    [NSSortDescriptor sortDescriptorWithKey:RCIMInstaPhotoInfoAttributes.createDate
                                  ascending:NO];
    request.sortDescriptors = @[dateSortDescriptor];
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    NSFetchedResultsController *fetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                        managedObjectContext:context
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    fetchedResultsController.delegate = self;
    self.fetchedResultsController = fetchedResultsController;
    
    NSError *error = nil;
    if(![fetchedResultsController performFetch:&error]) {
        NSLog(@"%@ %@ \n%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription]);
    }
    return _fetchedResultsController;
}

#pragma mark - Initialization

+ (instancetype)userFeedViewControllerwithUser:(RCIMInstaUser *)user {
    RCIMUserFeedViewController *feedVC =
    [[RCIMUserFeedViewController alloc] initWithStyle:UITableViewStyleGrouped];
    feedVC.instaUser = user;
    return feedVC;
}

#pragma mark - UITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.tintColor = [UIColor whiteColor];
    [refresh addTarget:self action:@selector(refreshFeed:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    self.refreshControl.layer.zPosition +=1;
    
    [self prepareTableView];
    
    if (self.instaUser) {
        self.title = [_instaUser.userName uppercaseString];
        self.feedPhotoManager = [[RCIMFeedPhotoManager alloc] initWithUser:self.instaUser];
        [self getMorePhotos];
    } else {
        [self getUserCompletion:nil];
    }
    
    UIBarButtonItem *logOutButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(logOut:)];
    self.navigationItem.rightBarButtonItem = logOutButton;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    typeof(self) __weak wSelf = self;
    [_instaUser refreshUserInfoCompletion:^{
        [_userInfoViewForSectionHeader configureForUser:wSelf.instaUser];
    }];
}

#pragma mark -

- (void)prepareTableView {
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
    imageView.contentMode = UIViewContentModeCenter;
    self.tableView.backgroundView = imageView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RCIMPhotoCell class]) bundle:nil]
         forCellReuseIdentifier:@"PhotoCell"];
}

- (void)getMorePhotos {
    [self.feedPhotoManager getPhotos:nil];
}

- (void)getUserCompletion:(void(^)())completion {
    typeof(self) __weak wSelf = self;
    [RCIMInstaUser getSelfCompletion:^(RCIMInstaUser *user, BOOL success) {
        wSelf.instaUser = user;
        wSelf.title = [user.userName uppercaseString];
        wSelf.feedPhotoManager = [[RCIMFeedPhotoManager alloc] initWithUser:wSelf.instaUser];
        [wSelf.tableView reloadData];
        [wSelf getMorePhotos];
        if (completion) {
            completion();
        }
    }];
}

- (void)refreshFeed:(id)sender {
    typeof(self) __weak wSelf = self;
    if (!_instaUser) {
        [self getUserCompletion:^{
            [wSelf.refreshControl endRefreshing];
        }];
        return;
    }
    [self.feedPhotoManager refreshPhotos:^(BOOL canceled) {
        if (!canceled)
            [wSelf.refreshControl endRefreshing];
    }];
}

- (void)showUserProfile:(id)sender {
    NSString *userProfileURLString =
    [@"instagram://user?username=" stringByAppendingString:self.instaUser.userName];
    NSURL *instagramURL = [NSURL URLWithString:userProfileURLString];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
        [[UIApplication sharedApplication] openURL:instagramURL];
}

- (void)logOut:(id)sender {
    [[RCIMInstagramClient sharedInstagramClient] logOut];
    
    RCIMLoginScreenViewController *loginVC = [RCIMLoginScreenViewController loginScreenViewController];
    
    [UIView transitionFromView:self.navigationController.view
                        toView:loginVC.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished) {
                        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
                        window.rootViewController = loginVC;
                    }];

}

#pragma mark - Cells logic

- (void)configurePhotoCell:(RCIMPhotoCell *)photoCell
              forIndexPath:(NSIndexPath *)indexPath {
    [photoCell configureForPhoto:[self.fetchedResultsController objectAtIndexPath:indexPath]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _instaUser ? [self.fetchedResultsController.sections count] : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo =
    [[self.fetchedResultsController sections] objectAtIndex:(NSUInteger)section];
    
    NSInteger rowsNumber = (NSInteger)[sectionInfo numberOfObjects];
    return rowsNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCIMPhotoCell *photoCell =
    (RCIMPhotoCell *)[tableView dequeueReusableCellWithIdentifier:@"PhotoCell"
                                                     forIndexPath:indexPath];
    [self configurePhotoCell:photoCell
                forIndexPath:indexPath];
    
    return photoCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger numberOfRows = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    if (numberOfRows - indexPath.row == 2)
        [self getMorePhotos];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRCIMPhotoCell_DEFAULT_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!_instaUser)
        return nil;
    else if (self.userInfoViewForSectionHeader)
        return self.userInfoViewForSectionHeader;
    else {
        RCIMUserInfoView *userInfoView = [RCIMUserInfoView RC_loadFromNib];
        [userInfoView configureForUser:self.instaUser];
        [userInfoView.showUserProfileButton addTarget:self
                                               action:@selector(showUserProfile:)
                                     forControlEvents:UIControlEventTouchUpInside];
        self.userInfoViewForSectionHeader = userInfoView;
        return userInfoView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kRCIMUserInfoView_DEFAULT_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RCIMPhotoDetailsTableViewController *photoDetailsVC =
    [RCIMPhotoDetailsTableViewController photoDetailsTableViewController];
    photoDetailsVC.photoInfo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self.navigationController pushViewController:photoDetailsVC
                                         animated:YES];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configurePhotoCell:(RCIMPhotoCell *)[tableView cellForRowAtIndexPath:indexPath]
                        forIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
