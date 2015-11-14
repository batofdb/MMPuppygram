//
//  FavoriteCollectionViewCell.m
//  FavoritePhotos
//
//  Created by Francis Bato on 10/17/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "FavoriteCollectionViewCell.h"

@implementation FavoriteCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    UITapGestureRecognizer* doubleTapToLike = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToLike)];
    [doubleTapToLike setNumberOfTapsRequired:2];
    [self addGestureRecognizer:doubleTapToLike];

    return self;
}

- (void)tapToLike {

    self.post.isLiked ^= YES;
    [self.delegate reloadFavoriteTapCollection:self.gestureRecognizers[0]];
}



@end
