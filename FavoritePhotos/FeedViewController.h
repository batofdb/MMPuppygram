//
//  FeedViewController.h
//  FavoritePhotos
//
//  Created by Francis Bato on 10/15/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoritesManager.h"


@interface FeedViewController : UIViewController

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@property NSMutableArray *favorites;
@property FavoritesManager *favoritesManager;
@end
