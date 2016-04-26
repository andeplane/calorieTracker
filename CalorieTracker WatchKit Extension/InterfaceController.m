//
//  InterfaceController.m
//  CalorieTracker WatchKit Extension
//
//  Created by Anders Hafreager on 25/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import <ClockKit/ClockKit.h>
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.lblFoodLeft.text = [NSString stringWithFormat:@"Food left: %d", [[HKManager sharedManager] foodLeft]];
    });
}

- (void) createPickerItems {
    NSMutableArray *items = [NSMutableArray array];
    for(int i=0; i<200; i++) {
        [items addObject:[[WKPickerItem alloc] init]];
    }
    [self.picker setItems:items];
    [self.picker setSelectedItemIndex:0];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.didAddCalories = false;
    [[HKManager sharedManager] update];
    [self createPickerItems];
    [self.picker focus];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    CLKComplicationServer *complicationServer = [CLKComplicationServer sharedInstance];
    for(CLKComplication *complication in complicationServer.activeComplications) {
        [complicationServer reloadTimelineForComplication:complication];
    }
    
    [super didDeactivate];
}

- (IBAction)pickerChanged:(NSInteger)value {
    NSLog(@"Picker changed value: %d", value);
    self.calories = 10*value;
    self.btnAdd.title = [NSString stringWithFormat:@"I ate %d kCal", self.calories];
}
- (IBAction)addFoodClicked {
    if(self.calories > 0) {
        [[HKManager sharedManager] addFoodWithCalories:self.calories];
        [self.picker setSelectedItemIndex:0];
        [[HKManager sharedManager] update];
        self.didAddCalories = true;
    }
}
@end



