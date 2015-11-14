//
//  PhotoManager.h
//  FavoritePhotos
//
//  Created by Francis Bato on 10/16/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface PostManager : NSObject

@property (nonatomic) NSMutableArray *posts;
@property (nonatomic) NSMutableArray *favorites;

+ (instancetype)sharedInstance;
- (NSArray *)getAllFavorites;

@end
