//
//  HKManager.h
//  CalorieTracker
//
//  Created by Anders Hafreager on 25/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKManager : NSObject

+ (HKManager *)sharedManager;
@property(nonatomic) float restingEnergy;
@property(nonatomic) float activeEnergy;
@property(nonatomic) float foodEaten;
- (void) requestRestingEnergy;
- (void) requestActiveEnergy;
- (void) requestFoodEaten;
- (void) requestAuthorization;
- (void) update;
- (void) addFoodWithCalories:(NSInteger) calories;
- (NSArray*) authorizationsNeeded;
- (bool) isAuthorized;
- (int) foodLeft;

@end
