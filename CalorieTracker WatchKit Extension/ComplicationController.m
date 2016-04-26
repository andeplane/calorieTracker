//
//  ComplicationController.m
//  CalorieTracker WatchKit Extension
//
//  Created by Anders Hafreager on 25/04/16.
//  Copyright © 2016 Anders Hafreager. All rights reserved.
//

#import "ComplicationController.h"
#import "HKManager.h"

@interface ComplicationController ()

@end

@implementation ComplicationController

#pragma mark - Timeline Configuration

- (void)getSupportedTimeTravelDirectionsForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler {
    handler(CLKComplicationTimeTravelDirectionNone);
}

- (void)getTimelineStartDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler(nil);
}

- (void)getTimelineEndDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler(nil);
}

- (void)getPrivacyBehaviorForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationPrivacyBehavior privacyBehavior))handler {
    handler(CLKComplicationPrivacyBehaviorShowOnLockScreen);
}

#pragma mark - Timeline Population
- (void)getCurrentTimelineEntryForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimelineEntry * __nullable))handler {
    // Call the handler with the current timeline entry
    if(complication.family == CLKComplicationFamilyModularSmall) {
        CLKComplicationTemplateModularSmallStackText *template = [[CLKComplicationTemplateModularSmallStackText alloc] init];
        int foodLeft = [[HKManager sharedManager] foodLeft];
        template.line1TextProvider = [CLKSimpleTextProvider textProviderWithText:[NSString stringWithFormat:@"%d", foodLeft]];
        template.line2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"kcal"];
        
        CLKComplicationTimelineEntry *entry = [[CLKComplicationTimelineEntry alloc] init];
        entry.date = [NSDate date];
        entry.complicationTemplate = template;
        handler(entry);
    } else handler(nil);
}


- (void)getTimelineEntriesForComplication:(CLKComplication *)complication beforeDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    // Call the handler with the timeline entries prior to the given date
    handler(nil);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication afterDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    // Call the handler with the timeline entries after to the given date
    handler(nil);
}

#pragma mark Update Scheduling
- (void)getNextRequestedUpdateDateWithHandler:(void(^)(NSDate * __nullable updateDate))handler {
    // Call the handler with the date when you would next like to be given the opportunity to update your complication content
    handler([NSDate dateWithTimeIntervalSinceNow:1200]);
}

#pragma mark - Placeholder Templates

- (void)getPlaceholderTemplateForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTemplate * __nullable complicationTemplate))handler {
    if(complication.family == CLKComplicationFamilyModularSmall) {
        CLKComplicationTemplateModularSmallStackText *template = [[CLKComplicationTemplateModularSmallStackText alloc] init];
        template.line1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"A"];
        template.line2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"B"];
        handler(template);
    } else handler(nil);
}

@end
