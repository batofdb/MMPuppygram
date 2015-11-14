//
//  FavoritesManager.m
//  FavoritePhotos
//
//  Created by Francis Bato on 10/18/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "FavoritesManager.h"

@implementation FavoritesManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.favoritesArray = [[NSMutableArray alloc] init];
    }

    return self;
}

@end
