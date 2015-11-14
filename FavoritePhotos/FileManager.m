//
//  FileManager.m
//  FavoritePhotos
//
//  Created by Francis Bato on 10/17/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "FileManager.h"
#import "Post.h"
#import "FavoritesManager.h"

@implementation FileManager


- (void)saveArray:(NSMutableArray *)array {

    NSMutableArray *uniqueArray = [NSMutableArray array];
    [uniqueArray addObjectsFromArray:[[NSSet setWithArray:array] allObjects]];


    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:uniqueArray];
    [userDefaults setObject:myEncodedObject forKey:@"favorites"];

    [userDefaults synchronize];
}

- (NSMutableArray *)loadArrayTo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefaults objectForKey:@"favorites"];
    NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    [userDefaults synchronize];

    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:decodedArray];

    return array;
}

- (NSURL *)documentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

- (void)clearFavorites {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

@end
