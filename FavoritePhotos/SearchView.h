//
//  SearchViewDelegate.h
//  FavoritePhotos
//
//  Created by Francis Bato on 10/16/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchTagsDelegate <NSObject>


- (void)searchView:(id)sender withString:(NSString *)string withOption:(NSString *)option;
- (void)removeBlur;

@end

@interface SearchView : UIView

@property (nonatomic, assign) id <SearchTagsDelegate> delegate;

@end
