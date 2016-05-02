//
//  GlanceController.m
//  CalorieTracker WatchKit Extension
//
//  Created by Anders Hafreager on 25/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import "GlanceController.h"
#import "HKManager.h"

@interface GlanceController()

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"Glance awakeWIthContext");
    [[HKManager sharedManager] addObserver:self forKeyPath:@"restingEnergy" options:NSKeyValueObservingOptionNew context:nil];
    [[HKManager sharedManager] addObserver:self forKeyPath:@"activeEnergy" options:NSKeyValueObservingOptionNew context:nil];
    [[HKManager sharedManager] addObserver:self forKeyPath:@"foodEaten" options:NSKeyValueObservingOptionNew context:nil];
    [[HKManager sharedManager] requestAuthorization];
    
    // Configure interface objects here.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.lblFoodLeft.text = [NSString stringWithFormat:@"Food left: %d", [[HKManager sharedManager] foodLeft]];
    });
}

- (void)willActivate {
    NSLog(@"Glance willActivate");
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    NSLog(@"Glance didDeactivate");
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



