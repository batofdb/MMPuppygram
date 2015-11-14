//
//  PostTableViewCell.h
//  FavoritePhotos
//
//  Created by Francis Bato on 10/15/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"
#import "Post.h"

@protocol TapFavoriteDelegate <NSObject>

- (void)reloadFavoriteTap:(Post *)post;

@end

@interface PostTableViewCell : UITableViewCell
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property Post *post;
@property (nonatomic, assign) id <TapFavoriteDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@end
