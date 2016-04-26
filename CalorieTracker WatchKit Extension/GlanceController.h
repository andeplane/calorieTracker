//
//  GlanceController.h
//  CalorieTracker WatchKit Extension
//
//  Created by Anders Hafreager on 25/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface GlanceController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblFoodLeft;

@end
