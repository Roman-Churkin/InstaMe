//
//  RCIMPhotoDetailsTableViewController.m
//  InstaMe
//
//  Created by Roman Churkin on 04.03.14.
//  Copyright (c) 2014 Roman Churkin. All rights reserved.
//

#import "RCIMPhotoDetailsTableViewController.h"

#import "RCIMUserFeedViewController.h"

#import "RCIMUserInfoView+ConfigureForUser.h"
#import "RCIMPhotoCommentCell+ConfigureForPhotoComment.h"
#import "RCIMPhotoCommentCell+ConfigureForPhotoInfo.h"
#import "RCIMPhotoCell+ConfigureForPhoto.h"

#import "RCIMInstaPhotoInfo+Network.h"
#import "RCIMInstaUser.h"
#import "RCIMPhotoComment.h"

typedef NS_ENUM(NSUInteger, RCIMPhotoDetailsTableViewControllerSections) {
    RCIMPhotoDetailsTableViewControllerSection_UserInfo = 0,
    RCIMPhotoDetailsTableViewControllerSection_Photo,
    RCIMPhotoDetailsTableViewControllerSection_Text,
    RCIMPhotoDetailsTableViewControllerSection_Comments,
    RCIMPhotoDetailsTableViewControllerSection_Count
};

@interface RCIMPhotoDetailsTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) RCIMUserInfoView *userInfoViewForSectionHeader;

@property (strong, nonatomic) NSArray *comments;

@property (strong, nonatomic) NSCache *commentsStringsCache;

@end

@implementation RCIMPhotoDetailsTableViewController

+ (instancetype)photoDetailsTableViewController {
    return [[RCIMPhotoDetailsTableViewController alloc] initWithStyle:UITableViewStylePlain];
}

#pragma mark - UITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _commentsStringsCache = [[NSCache alloc] init];
    
    [self prepareTableView];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIBarButtonItem *likeButton =
    [[UIBarButtonItem alloc] initWithImage:[self likeButtonImageForState:_photoInfo.userHasLikedValue]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(likePhoto:)];
    likeButton.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = likeButton;
    
    [self prepareComments];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    typeof(self) __weak wSelf = self;
    [_photoInfo getFullInfoCompletion:^{
        [wSelf prepareComments];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_commentsStringsCache removeAllObjects];
}

- (UIImage *)likeButtonImageForState:(BOOL)liked {
    if (liked) {
        return [UIImage imageNamed:@"like_button_img_fill"];
    } else {
        return [UIImage imageNamed:@"like_button_img"];
    }
}

- (void)prepareTableView {
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
    imageView.contentMode = UIViewContentModeCenter;
    self.tableView.backgroundView = imageView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RCIMPhotoCell class]) bundle:nil]
         forCellReuseIdentifier:@"PhotoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RCIMPhotoCommentCell class]) bundle:nil]
         forCellReuseIdentifier:@"CommentCell"];
}

- (void)prepareComments {
    typeof(self) __weak wSelf = self;
    NSSet *comments = self.photoInfo.comments;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSSortDescriptor *sdByDate =
        [NSSortDescriptor sortDescriptorWithKey:RCIMPhotoCommentAttributes.createDate
                                      ascending:YES];
        
        NSArray *sortedComments = [comments sortedArrayUsingDescriptors:@[sdByDate]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            wSelf.comments = sortedComments;
            [wSelf.tableView reloadData];
        });
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return RCIMPhotoDetailsTableViewControllerSection_Count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch ((RCIMPhotoDetailsTableViewControllerSections)section) {
        case RCIMPhotoDetailsTableViewControllerSection_Comments:
            return [self.comments count];
            
        case RCIMPhotoDetailsTableViewControllerSection_UserInfo:
            return 0;
            
        case RCIMPhotoDetailsTableViewControllerSection_Text:
            return _photoInfo.text? 1 :0;

        case RCIMPhotoDetailsTableViewControllerSection_Photo:
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ((RCIMPhotoDetailsTableViewControllerSections)indexPath.section) {
        case RCIMPhotoDetailsTableViewControllerSection_Photo: {
            RCIMPhotoCell *photoCell =
            (RCIMPhotoCell *)[tableView dequeueReusableCellWithIdentifier:@"PhotoCell"
                                                             forIndexPath:indexPath];
            [photoCell configureForPhoto:self.photoInfo];
            photoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return photoCell;
        }
            
        case RCIMPhotoDetailsTableViewControllerSection_Text: {
            RCIMPhotoCommentCell *commentCell =
            (RCIMPhotoCommentCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentCell"
                                                                    forIndexPath:indexPath];
            [commentCell configureForPhotoInfo:_photoInfo
                                     withCache:_commentsStringsCache];
            return commentCell;
        }
            
        case RCIMPhotoDetailsTableViewControllerSection_Comments: {
            RCIMPhotoCommentCell *commentCell =
            (RCIMPhotoCommentCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentCell"
                                                                    forIndexPath:indexPath];
            [commentCell configureForPhotoComment:_comments[indexPath.row]
                                        withCache:_commentsStringsCache];
            commentCell.iconImageView.hidden = _photoInfo.text || (BOOL)indexPath.row;
            return commentCell;
        }
            
        default:
            return nil;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ((RCIMPhotoDetailsTableViewControllerSections)indexPath.section) {
        case RCIMPhotoDetailsTableViewControllerSection_Photo:
            return kRCIMPhotoCell_DEFAULT_HEIGHT;
            
        case RCIMPhotoDetailsTableViewControllerSection_Text: {
            NSAttributedString *string =
            [RCIMPhotoCommentCell textForPhotoInfo:_photoInfo
                                         withCache:_commentsStringsCache];
            return [RCIMPhotoCommentCell calculateRequiredHeightForString:string];
        }
        case RCIMPhotoDetailsTableViewControllerSection_Comments: {
            RCIMPhotoComment *comment = _comments[indexPath.row];
            NSAttributedString *string =
            [RCIMPhotoCommentCell textForPhotoComment:comment
                                            withCache:_commentsStringsCache];
            return [RCIMPhotoCommentCell calculateRequiredHeightForString:string];
        }
            
        default:
            return 0.f;
    }

    return kRCIMPhotoCell_DEFAULT_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch ((RCIMPhotoDetailsTableViewControllerSections)section) {
        case RCIMPhotoDetailsTableViewControllerSection_UserInfo:
            return kRCIMUserInfoView_DEFAULT_HEIGHT;
            
        default:
            return 0.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch ((RCIMPhotoDetailsTableViewControllerSections)section) {
        case RCIMPhotoDetailsTableViewControllerSection_UserInfo: {
            if (self.userInfoViewForSectionHeader)
                return self.userInfoViewForSectionHeader;
            else {
                RCIMUserInfoView *userInfoView = [RCIMUserInfoView RC_loadFromNib];
                [userInfoView configureForUser:self.photoInfo.user];
                [userInfoView.showUserProfileButton addTarget:self
                                                       action:@selector(showUserProfile:)
                                             forControlEvents:UIControlEventTouchUpInside];
                self.userInfoViewForSectionHeader = userInfoView;
                return userInfoView;
            }
        }
            
        default:
            return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch ((RCIMPhotoDetailsTableViewControllerSections)indexPath.section) {
        case RCIMPhotoDetailsTableViewControllerSection_Comments: {
            RCIMPhotoComment *comment = _comments[indexPath.row];
            RCIMUserFeedViewController *userFeedVC =
            [RCIMUserFeedViewController userFeedViewControllerwithUser:comment.user];
            [self.navigationController pushViewController:userFeedVC animated:YES];
        }
            
            default:
            break;
    }
}

#pragma mark - Actions

- (void)showUserProfile:(id)sender {
    NSString *userProfileURLString =
    [@"instagram://user?username=" stringByAppendingString:self.photoInfo.user.userName];
    NSURL *instagramURL = [NSURL URLWithString:userProfileURLString];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
        [[UIApplication sharedApplication] openURL:instagramURL];
}

- (void)likePhoto:(UIBarButtonItem *)sender {
    
    sender.image = [self likeButtonImageForState:!_photoInfo.userHasLikedValue];
    
    typeof(self) __weak wSelf = self;
    typeof(sender) __weak wSender = sender;
    void(^likeCompletion)() = ^() {
        wSender.image = [wSelf likeButtonImageForState:_photoInfo.userHasLikedValue];
    };
    
    if (_photoInfo.userHasLikedValue) {
        [_photoInfo unLike:likeCompletion];
    } else {
        [_photoInfo like:likeCompletion];
    }
    
}

@end
