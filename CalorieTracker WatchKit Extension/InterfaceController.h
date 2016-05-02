//
//  InterfaceController.h
//  CalorieTracker WatchKit Extension
//
//  Created by Anders Hafreager on 25/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property(nonatomic) NSInteger calories;
@property(nonatomic) bool didAddCalories;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *btnAdd;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *imgProgress;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *caloriesLeftIcon;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblCaloriesLeft;
- (IBAction)pickerChanged:(NSInteger)value;
- (IBAction)addFoodClicked;

@end
