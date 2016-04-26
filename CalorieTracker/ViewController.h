//
//  ViewController.h
//  CalorieTracker
//
//  Created by Anders Hafreager on 25/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *enableHealth;
@property (weak, nonatomic) IBOutlet UILabel *lblActiveEnergy;
@property (weak, nonatomic) IBOutlet UILabel *lblRestingEnergy;
@property (weak, nonatomic) IBOutlet UILabel *lblFoodEaten;
@property (weak, nonatomic) IBOutlet UILabel *lblFoodLeft;
- (IBAction)enableHealthChanged:(id)sender;

@end

