//
//  Post.h
//  FavoritePhotos
//
//  Created by Francis Bato on 10/15/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Post : NSObject

// Instagram props
@property NSArray *tags;
@property MKMapItem *mapItem;
@property UIImage *image;
@property NSDictionary *author;
@property NSString *photoID;
@property double latitude;
@property double longitude;

// Local props
@property BOOL isLiked;
@property MKPointAnnotation *annotation;

+ (NSArray *)postsFromArray:(NSArray *)array;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
