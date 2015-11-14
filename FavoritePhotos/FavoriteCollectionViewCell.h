//
//  FavoriteCollectionViewCell.h
//  FavoritePhotos
//
//  Created by Francis Bato on 10/17/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@protocol TapFavoriteCellDelegate <NSObject>

- (void)reloadFavoriteTapCollection:(UIGestureRecognizer *)gestureRecognizer;

@end

@interface FavoriteCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property Post *post;
@property (nonatomic, assign) id <TapFavoriteCellDelegate> delegate;


@end
