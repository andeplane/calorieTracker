//
//  InterfaceController.m
//  CalorieTracker WatchKit Extension
//
//  Created by Anders Hafreager on 25/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "HKManager.h"

@interface InterfaceController() <WCSessionDelegate>

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    [[HKManager sharedManager] addObserver:self forKeyPath:@"restingEnergy" options:NSKeyValueObservingOptionNew context:nil];
    [[HKManager sharedManager] addObserver:self forKeyPath:@"activeEnergy" options:NSKeyValueObservingOptionNew context:nil];
    [[HKManager sharedManager] addObserver:self forKeyPath:@"foodEaten" options:NSKeyValueObservingOptionNew context:nil];
    [[HKManager sharedManager] requestAuthorization];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"restingEnergy"]) {
        int value = round([[change valueForKey:@"new"] floatValue]);
        dispatch_async(dispatch_get_main_queue(), ^{
            float totalEnergy = [HKManager sharedManager].activeEnergy + value;
            
            self.lblTotalEnergy.text = [NSString stringWithFormat:@"Total energy: %d", (int) totalEnergy];
        });
    }
    
    if([keyPath isEqualToString:@"activeEnergy"]) {
        int value = round([[change valueForKey:@"new"] floatValue]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lblActiveEnergy.text = [NSString stringWithFormat:@"Active energy: %d", value];
        });
    }
    
    if([keyPath isEqualToString:@"foodEaten"]) {
        int value = round([[change valueForKey:@"new"] floatValue]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lblFoodEaten.text = [NSString stringWithFormat:@"Food eaten: %d", value];
        });
    }
    
    int foodLeft = (int) (([HKManager sharedManager].activeEnergy + [HKManager sharedManager].restingEnergy) - [HKManager sharedManager].foodEaten);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.lblFoodLeft.text = [NSString stringWithFormat:@"Food left: %d", foodLeft];
    });
}

- (void) sendData {
//    NSString *counterString = [NSString stringWithFormat:@"%d", self.counter];
//    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[counterString] forKeys:@[@"counterValue"]];
//    
//    [[WCSession defaultSession] sendMessage:applicationData
//                               replyHandler:^(NSDictionary *reply) {
//                                   //handle reply from iPhone app here
//                               }
//                               errorHandler:^(NSError *error) {
//                                   //catch any errors here
//                               }
//     ];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [[HKManager sharedManager] update];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



