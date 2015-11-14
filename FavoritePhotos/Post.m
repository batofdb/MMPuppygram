//
//  Post.m
//  FavoritePhotos
//
//  Created by Francis Bato on 10/15/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "Post.h"

@implementation Post

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.tags = dict[@"tags"];


        if (dict[@"location"] != [NSNull null]) {
/*
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(,[dict[@"location"][@"longitude"] doubleValue]) addressDictionary:nil];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
            mapItem.name = dict[@"location"][@"name"];
            self.mapItem = mapItem;
*/
            self.latitude = [dict[@"location"][@"latitude"] doubleValue];
            self.longitude = [dict[@"location"][@"longitude"] doubleValue];
/*
            MKPointAnnotation *annotation = [MKPointAnnotation new];
            annotation.title = mapItem.name;
            annotation.coordinate = self.mapItem.placemark.location.coordinate;
            self.annotation = annotation;
 */
        } else {
            self.mapItem = nil;
            self.annotation = nil;
        }




        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dict[@"images"][@"standard_resolution"][@"url"]]]];
        self.image = [UIImage imageWithData:imageData];
        self.author = dict[@"user"];
        self.photoID = dict[@"id"];
        self.isLiked = NO;

    }
    
    return self;
}

+ (NSArray *)postsFromArray:(NSArray *)incomingArray{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:incomingArray.count];

    for (NSDictionary *rawPost in incomingArray) {
        Post *post = [[Post alloc] initWithDictionary:rawPost];
        [array addObject:post];
    }

    return array;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.tags forKey:@"tags"];
    //[encoder encodeObject:self.mapItem forKey:@"mapItem"];
    //[encoder encodeObject:self.annotation forKey:@"annotation"];
    [encoder encodeObject:self.image forKey:@"image"];
    [encoder encodeObject:self.author forKey:@"author"];
    [encoder encodeObject:self.photoID forKey:@"photoID"];
    [encoder encodeBool:self.isLiked forKey:@"isLiked"];
    [encoder encodeDouble:self.latitude forKey:@"latitude"];
    [encoder encodeDouble:self.longitude forKey:@"longitude"];
    


}
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if( self != nil )
    {
        self.tags = [decoder decodeObjectForKey:@"tags"];
        //self.mapItem = [decoder decodeObjectForKey:@"mapItem"];
        self.image = [decoder decodeObjectForKey:@"image"];
        self.author = [decoder decodeObjectForKey:@"author"];
        self.photoID = [decoder decodeObjectForKey:@"photoID"];

        self.isLiked = [decoder decodeBoolForKey:@"isLiked"];
        self.latitude = [decoder decodeDoubleForKey:@"latitude"];
        self.longitude = [decoder decodeDoubleForKey:@"longitude"];
        //self.annotation = [decoder decodeObjectForKey:@"annotation"];

    }
    return self;
}

@end
