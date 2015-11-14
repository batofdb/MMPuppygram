//
//  FileManager.h
//  FavoritePhotos
//
//  Created by Francis Bato on 10/17/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

- (void)saveArray:(NSMutableArray *)array;
- (NSMutableArray *)loadArrayTo;
- (void)clearFavorites;
@end
