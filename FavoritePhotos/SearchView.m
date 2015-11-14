//
//  SearchViewDelegate.m
//  FavoritePhotos
//
//  Created by Francis Bato on 10/16/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "SearchView.h"

@interface SearchView () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchOption;

@end


@implementation SearchView

- (IBAction)onCloseSearchViewTapped:(UITapGestureRecognizer *)sender {
    [self removeFromSuperview];
    [self.delegate removeBlur];

}

- (void)awakeFromNib {
    [self.searchBarView setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    [self.searchBarView becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSString *str = @"tag";

    if (self.searchOption.selectedSegmentIndex == 1)
        str = @"user";

    [self.delegate searchView:nil withString:textField.text withOption:str];
    [self removeFromSuperview];
    return YES;
}

@end
