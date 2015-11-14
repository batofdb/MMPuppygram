//
//  PostTableViewCell.m
//  FavoritePhotos
//
//  Created by Francis Bato on 10/15/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "PostTableViewCell.h"
#import "FeedViewController.h"

@interface PostTableViewCell ()

@end

@implementation PostTableViewCell

- (void)viewDidLoad {
    [self viewDidLoad];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    UITapGestureRecognizer* doubleTapToLike = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToLike)];
    [doubleTapToLike setNumberOfTapsRequired:2];
    [self addGestureRecognizer:doubleTapToLike];

    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)tapToLike {


    //add index to cell
    

    self.post.isLiked ^= YES;
    [self.delegate reloadFavoriteTap:self.post];
}




@end
