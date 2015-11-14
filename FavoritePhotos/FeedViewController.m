//
//  FeedViewController.m
//  FavoritePhotos
//
//  Created by Francis Bato on 10/15/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "FeedViewController.h"
#import "Post.h"
#import "PostTableViewCell.h"
#import "SearchView.h"
#import "FavoritesViewController.h"
#import "FileManager.h"
#import "FavoriteCollectionViewCell.h"
#import "FavoritesManager.h"

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate, SearchTagsDelegate, UIGestureRecognizerDelegate, TapFavoriteDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property SearchView *searchView;
@property NSMutableArray *posts;
@property FileManager *fileManager;


@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FavoritesViewController *vc = (FavoritesViewController *)[self.tabBarController.viewControllers objectAtIndex:0];
    vc.onFirstLoad = NO;

    self.favoritesManager = [FavoritesManager new];

    self.fileManager = [FileManager new];
    self.favorites = [NSMutableArray new];

    self.tableView.sectionHeaderHeight = 0.0;
    [self.tableView reloadData];

    self.searchView = [[[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:self options:nil] objectAtIndex:0];
    self.searchView.delegate = self;
    self.searchView.frame = self.view.frame;

    [self searchTagWithString:@"" withOption:@"tag"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];


    self.favoritesManager.favoritesArray = [self.fileManager loadArrayTo];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PostTableViewCell" owner:self options:nil];
        cell = (PostTableViewCell *)[nib objectAtIndex:0];
    }


    Post *post = [self.posts objectAtIndex:indexPath.row];
    cell.post = post;
    cell.delegate = self;
    cell.postImageView.image = post.image;
    cell.likeImageView.hidden = YES;
    cell.userLabel.text = post.author[@"username"];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.likeImageView.hidden = NO;
    cell.likeImageView.image = [UIImage imageNamed:@"unlike"];

    for (Post *favoritePost in self.favoritesManager.favoritesArray) {
        if ([post.photoID isEqualToString:favoritePost.photoID])
            cell.likeImageView.image = [UIImage imageNamed:@"like"];


    }

    return cell;
}

- (IBAction)onSearchButtonTapped:(UIButton *)sender {
    [self addBlur];
    [self.view addSubview:self.searchView];
}

- (void)searchTagWithString:(NSString *)str withOption:(NSString *)option{
    [self.spinner startAnimating];

    NSURL *url;
    if ([option isEqualToString: @"user"]) {
        url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/search?q=%@&access_token=1439663.ab103e5.0df60365c0974a709af43ee0c963aaf4",str]];

    } else  {

        url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@puppy/media/recent?access_token=1439663.ab103e5.0df60365c0974a709af43ee0c963aaf4",str]];
    }



    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        self.posts = [[NSMutableArray alloc] initWithArray:[Post postsFromArray:results[@"data"]]];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.spinner stopAnimating];

            [self.tableView reloadData];

            if (results) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        });
    }];
    
    [task resume];
}

#pragma mark - custom delegation
- (void)searchView:(id)sender withString:(NSString *)string withOption:(NSString *)option{

    [self hideBlur];

    
    [self searchTagWithString:string withOption:option];
    self.titleLabel.text = string;
}

- (void)removeBlur {
    [self hideBlur];
}

- (void)hideBlur {
    for (UIView *subview in [self.view subviews]) {
        if (subview.tag == 10) {
            [subview removeFromSuperview];
        }
    }
}

- (void)reloadFavoriteTap:(Post *)post{

    if (post.isLiked) {
        BOOL isDuplicate = NO;
        NSArray *copy = [self.favoritesManager.favoritesArray copy];
        for (Post *favoritePost in copy) {
            if ([favoritePost.photoID isEqualToString:post.photoID]) {
                isDuplicate = YES;
            }
        }
        if (!isDuplicate)
            [self.favoritesManager.favoritesArray addObject:post];

    } else {
        NSArray *copy = [self.favoritesManager.favoritesArray copy];
        for (Post *favoritePost in copy) {
            if ([favoritePost.photoID isEqualToString:post.photoID]) {
                [self.favoritesManager.favoritesArray removeObject:post];
            }
        }
    }

    [self.tableView reloadData];
    [self.fileManager saveArray:self.favoritesManager.favoritesArray];
}

#pragma mark - shake gesture methods
//Add to first VC

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        NSLog(@"shake");
        [self.fileManager clearFavorites];
    } 
}


- (void)addBlur {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    blurEffectView.tag = 10;
    [self.view addSubview:blurEffectView];
}

@end
