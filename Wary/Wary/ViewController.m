//
//  ViewController.m
//  Wary
//
//  Created by Sherchan, Himal on 5/22/16.
//  Copyright © 2016 Sherchan, Himal. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CMMotionManager *motionManager;;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 10;
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.motionManager = [[CMMotionManager alloc] init];
    BOOL canUseMotion = self.motionManager.deviceMotionAvailable;
    
    if (canUseMotion)
    {
        [self.motionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            NSLog(@"New Device datat: %@", motion);
        }];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CLLocation *location = [locations lastObject];
        self.labelLocation.text = [NSString stringWithFormat:@"%f", location.speed];
    });
}
@end
