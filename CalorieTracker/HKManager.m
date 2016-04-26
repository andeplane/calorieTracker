//
//  HKManager.m
//  CalorieTracker
//
//  Created by Anders Hafreager on 25/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import "HKManager.h"
#import <HealthKit/HealthKit.h>

@interface HKManager ()

@property (nonatomic, retain) HKHealthStore *healthStore;

@end

@implementation HKManager

+ (HKManager *)sharedManager {
    static dispatch_once_t pred = 0;
    static HKManager *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[HKManager alloc] init];
        instance.healthStore = [[HKHealthStore alloc] init];
        instance.foodEaten = 0;
        instance.activeEnergy = 0;
        instance.restingEnergy = 0;
    });
    return instance;
}

-(NSArray*) authorizationsNeeded {
    return @[[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned],
             [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned],
             [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
             [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed]];
}
- (bool) isAuthorized {
    NSArray *types = [self authorizationsNeeded];
    for(HKObjectType *type in types) {
        if(![self.healthStore authorizationStatusForType:type]) {
            return false;
        }
    }
    
    return true;
}

-(void) requestRestingEnergy {
    NSDate *now = [NSDate date];
    NSDate *oneWeekAgo = [NSDate dateWithTimeIntervalSinceNow:-7*86400];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:oneWeekAgo endDate:now options:HKQueryOptionStrictStartDate];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned] quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
        HKQuantity *quantity = result.sumQuantity;
        double energy = [quantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
        double energyPerDay = energy / 7;
        self.restingEnergy = energyPerDay;
        NSLog(@"Energy: %f", energyPerDay);
    }];
    
    [self.healthStore executeQuery:query];
}

-(void) requestFoodEaten {
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *todaysDate;
    NSDate *tomorrowsDate;
    NSTimeInterval interval;
    // [NSPredicate predicateWithFormat:@"(date >= %@) AND (date < %@)", todaysDate, tomorrowsDate]
    [cal rangeOfUnit:NSCalendarUnitDay startDate:&todaysDate interval:&interval forDate:now];
    tomorrowsDate = [todaysDate dateByAddingTimeInterval:interval];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:todaysDate endDate:now options:HKQueryOptionStrictStartDate];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed] quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
        HKQuantity *quantity = result.sumQuantity;
        double energy = [quantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
        self.foodEaten = energy;
        NSLog(@"Food eaten: %f", energy);
    }];
    
    [self.healthStore executeQuery:query];
}

-(void) requestActiveEnergy {
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *todaysDate;
    NSDate *tomorrowsDate;
    NSTimeInterval interval;
    // [NSPredicate predicateWithFormat:@"(date >= %@) AND (date < %@)", todaysDate, tomorrowsDate]
    [cal rangeOfUnit:NSCalendarUnitDay startDate:&todaysDate interval:&interval forDate:now];
    tomorrowsDate = [todaysDate dateByAddingTimeInterval:interval];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:todaysDate endDate:now options:HKQueryOptionStrictStartDate];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned] quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery * _Nonnull query, HKStatistics * _Nullable result, NSError * _Nullable error) {
        HKQuantity *quantity = result.sumQuantity;
        double energy = [quantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
        self.activeEnergy = energy;
        NSLog(@"Active energy: %f", energy);
    }];
    
    [self.healthStore executeQuery:query];
}

- (void)requestAuthorization {
    
    if ([HKHealthStore isHealthDataAvailable] == NO) {
        // If our device doesn't support HealthKit -> return.
        return;
    }
    
    /*
     HKQuantityTypeIdentifierBasalEnergyBurned NS_AVAILABLE_IOS(8_0);         // Energy,                      Cumulative
     HKQuantityTypeIdentifierActiveEnergyBurned NS_AVAILABLE_IOS(8_0);        // Energy,
     HKQuantityTypeIdentifierBodyMass NS_AVAILABLE_IOS(8_0);                  // Mass,
     HKQuantityTypeIdentifierDietaryEnergyConsumed NS_AVAILABLE_IOS(8_0);     // Energy, Cumulative
     */
    
    NSArray *readTypes = [self authorizationsNeeded];
    NSArray *writeTypes = [self authorizationsNeeded];
    
    [self.healthStore requestAuthorizationToShareTypes:[NSSet setWithArray:writeTypes]
                                             readTypes:[NSSet setWithArray:readTypes] completion:nil];
}



@end
