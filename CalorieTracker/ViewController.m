//
//  ViewController.m
//  CalorieTracker
//
//  Created by Anders Hafreager on 25/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import "ViewController.h"
#import "HKManager.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface ViewController () <WCSessionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[HKManager sharedManager] addObserver:self forKeyPath:@"restingEnergy" options:NSKeyValueObservingOptionNew context:nil];
    [[HKManager sharedManager] addObserver:self forKeyPath:@"activeEnergy" options:NSKeyValueObservingOptionNew context:nil];
    [[HKManager sharedManager] addObserver:self forKeyPath:@"foodEaten" options:NSKeyValueObservingOptionNew context:nil];
    
    self.enableHealth.on = [[HKManager sharedManager] isAuthorized];
    [[HKManager sharedManager] update];
}

- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler {
//    NSString *counterValue = [message objectForKey:@"counterValue"];
    
//    if (!self.counterData) {
//        self.counterData = [[NSMutableArray alloc] init];
//    }
//    
//    //Use this to update the UI instantaneously (otherwise, takes a little while)
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        [self.counterData addObject:counterValue];
//        [self.mainTableView reloadData];
//    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"restingEnergy"]) {
        int value = round([[change valueForKey:@"new"] floatValue]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lblRestingEnergy.text = [NSString stringWithFormat:@"%d", value];
        });
    }
    
    if([keyPath isEqualToString:@"activeEnergy"]) {
        int value = round([[change valueForKey:@"new"] floatValue]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lblActiveEnergy.text = [NSString stringWithFormat:@"%d", value];
        });
    }
    
    if([keyPath isEqualToString:@"foodEaten"]) {
        int value = round([[change valueForKey:@"new"] floatValue]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lblFoodEaten.text = [NSString stringWithFormat:@"%d", value];
        });
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.lblFoodLeft.text = [NSString stringWithFormat:@"%d", [[HKManager sharedManager] foodLeft]];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enableHealthChanged:(id)sender {
    [[HKManager sharedManager] requestAuthorization];
}

@end
