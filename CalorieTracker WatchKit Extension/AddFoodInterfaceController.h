//
//  AddFoodInterfaceController.h
//  CalorieTracker
//
//  Created by Anders Hafreager on 26/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <WatchKit/WKInterfaceSlider.h>
#import <WatchKit/WKInterfacePicker.h>
#import <WatchKit/WKInterfaceLabel.h>
#import <Foundation/Foundation.h>

@interface AddFoodInterfaceController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblCalories;
@property (nonatomic) NSInteger calories;
- (IBAction)pickerChanged:(NSInteger)value;
- (IBAction)addClicked;

@end
