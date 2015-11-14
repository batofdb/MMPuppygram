//
//  PhotoManager.m
//  FavoritePhotos
//
//  Created by Francis Bato on 10/16/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "PostManager.h"
#import "Post.h"


@implementation PostManager

+ (instancetype)sharedInstance {
    static PostManager *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[PostManager alloc] init];

    });

    return sharedInstance;
}

- (NSMutableArray *)posts {
    if (!self) {
        self.posts = [NSMutableArray new];
    }

    return self;
}

- (NSArray *)getAllFavorites {
    NSMutableArray *array = [NSMutableArray new];
    for (Post *post in self.posts) {
        if (post.isLiked)
            [array addObject:post];
    }

    if (!self.favorites)
        self.favorites = [[NSMutableArray alloc] initWithArray:array];
    else
        self.favorites = [NSMutableArray arrayWithArray:array];

    return array;
}

@end
