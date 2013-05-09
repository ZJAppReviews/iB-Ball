//
//  iBPlayCourtViewController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 5/9/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface iBPlayCourtViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)hereItIsButtonClicked:(id)sender;

- (IBAction)helpMeFindOneButtonClicked:(id)sender;

@end
