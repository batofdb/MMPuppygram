//
//  MapViewController.m
//  FavoritePhotos
//
//  Created by Francis Bato on 10/18/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Post.h"

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (Post *post in self.posts) {

        MKPointAnnotation *annotation = [MKPointAnnotation new];
        annotation.coordinate = CLLocationCoordinate2DMake(post.latitude, post.longitude);
        [self.mapView addAnnotation:annotation];
    }


}
- (IBAction)onCloseButtonTapped:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{

    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];

    pin.image = [UIImage imageNamed:@"paw"];
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    return pin;
}

@end
