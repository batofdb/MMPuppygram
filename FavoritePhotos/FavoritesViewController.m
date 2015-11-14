//
//  FavoritesViewController.m
//  FavoritePhotos
//
//  Created by Francis Bato on 10/16/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "FavoritesViewController.h"
#import "Post.h"
#import "FileManager.h"
#import "FavoriteCollectionViewCell.h"
#import "FeedViewController.h"
#import "FavoritesManager.h"
#import "MapViewController.h"


@interface FavoritesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, TapFavoriteCellDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property FavoritesManager *favoritesManager;
@property FileManager *fileManager;


@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.onFirstLoad = YES;
    self.fileManager = [FileManager new];

    if (!self.favoritesManager) {
        self.favoritesManager = [FavoritesManager new];
        self.favoritesManager.favoritesArray = [NSMutableArray new];
    }

    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.sectionInset = UIEdgeInsetsMake( 20,  0,  10,  0);
    layout.itemSize = CGSizeMake(self.view.frame.size.height/3,self.view.frame.size.width/3);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;

    self.favoritesManager.favoritesArray = [self.fileManager loadArrayTo];

    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (!self.onFirstLoad) {
       // FeedViewController *vc = [self.tabBarController.viewControllers objectAtIndex:1];
       // self.favoritesManager = vc.favoritesManager;
        self.favoritesManager.favoritesArray = [self.fileManager loadArrayTo];
    }

    [self.collectionView reloadData];

}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.favoritesManager.favoritesArray.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    Post *post = [self.favoritesManager.favoritesArray objectAtIndex:indexPath.row];
    cell.post = post;
    cell.delegate = self;
    cell.postImageView.image = post.image;

    return cell;
}
- (IBAction)onBackButtonPressed:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"log");
    }];
}


- (void)reloadFavoriteTapCollection:(UIGestureRecognizer *)gestureRecognizer{

    NSArray *copy = [self.favoritesManager.favoritesArray copy];

    for (Post *favoritePost in copy) {
        if (!favoritePost.isLiked) {
            [self.favoritesManager.favoritesArray removeObject:favoritePost];
        }
    }

    [self.collectionView reloadData];
    [self.fileManager saveArray:self.favoritesManager.favoritesArray];
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5; // This is the minimum inter item spacing, can be more
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MapViewController *vc = [segue destinationViewController];
    vc.posts = self.favoritesManager.favoritesArray;
}

@end
