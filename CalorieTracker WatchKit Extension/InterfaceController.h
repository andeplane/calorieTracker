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
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblActiveEnergy;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblTotalEnergy;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblFoodEaten;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblFoodLeft;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *picker;

@end
