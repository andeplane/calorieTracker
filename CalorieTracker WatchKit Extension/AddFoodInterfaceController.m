//
//  AddFoodInterfaceController.m
//  CalorieTracker
//
//  Created by Anders Hafreager on 26/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import "AddFoodInterfaceController.h"
#import "HKManager.h"
@interface AddFoodInterfaceController ()

@end

@implementation AddFoodInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void) createPickerItems {
    NSMutableArray *items = [NSMutableArray array];
    for(int i=0; i<200; i++) {
        [items addObject:[[WKPickerItem alloc] init]];
    }
    [self.picker setItems:items];
    [self.picker setSelectedItemIndex:20];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self createPickerItems];
    [self.picker focus];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)pickerChanged:(NSInteger)value {
    self.calories = 10*value;
    self.lblCalories.text = [NSString stringWithFormat:@"%d kCal", self.calories];
}

- (IBAction)addClicked {
    [[HKManager sharedManager] addFoodWithCalories:self.calories];
    [self popController];
}
@end



