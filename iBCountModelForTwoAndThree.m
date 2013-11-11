//
//  iBDataCenter.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/17/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBCountModelForTwoAndThree.h"
#import <Foundation/Foundation.h>
#import "iBAppDelegate.h"
#import "TwoPoint.h"
#import "Player.h"


#define kTST @"TST"
#define kTGT @"TGT"

@implementation iBCountModelForTwoAndThree
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeInt:self.totalShootingTimes forKey:kTST];
//    [aCoder encodeInt:self.totalGoalTimes forKey:kTGT];
//}

- (id)initWithShooting:(int)shoot goal:(int)goal {
    self = [super init];
    if (self) {
        // Initialize self.
        _shootingTimes = shoot;
        _goalTimes = goal;
        iBAppDelegate *ibad = (iBAppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = ibad.managedObjectContext;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithShooting:0 goal:0];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    int totalShootingTimes = [aDecoder decodeIntegerForKey:kTST];
    int totalGoalTimes = [aDecoder decodeIntegerForKey:kTGT];
    return [self initWithShooting:totalShootingTimes goal:totalGoalTimes];
}

- (float)getRatioForThisTime {
    return (float)_goalTimes / (float)_shootingTimes * 100;
}

- (float)getRatioForOverall {
    return (float)self.totalGoalTimes / (float)self.totalShootingTimes * 100;
}

- (NSString *)currentContentFilePath {
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentDirectories objectAtIndex:0];
    return [documentsDirectory
            stringByAppendingPathComponent:@"shoot"];
}

- (void)saveData {
    if (self.whatTypeOfCountingAreWeIn == CountForTwo) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        
        NSDate *today = [NSDate date];
        
        
        // deal the situation where the TwoPoint Already Exist
        NSManagedObjectContext *context = self.managedObjectContext;
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"TwoPoint"
                                                  inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        NSError *error;
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects == nil) {
            // Handle the error.
            NSLog(@"wori");
        }
        
        if (fetchedObjects.count > 0) {
            
            // get the day
            NSString *dayWeAreIn = [dateFormatter stringFromDate:today];
            // fileter the day & crap***
            BOOL exist = NO;
            for (TwoPoint *tp in fetchedObjects) {
                if ([tp.twoPointDay isEqualToString:dayWeAreIn]) {
                    exist = YES;
                    int theOriginal = [tp.twoPointGoal intValue];
                    int theOriginal2 = [tp.twoPointTotal intValue];
                    theOriginal += self.goalTimes;
                    theOriginal2 += self.shootingTimes;
                    NSNumber *a1 = [NSNumber numberWithInt:theOriginal];
                    NSNumber *a2 = [NSNumber numberWithInt:theOriginal2];
                    
                    tp.twoPointGoal = a1;
                    tp.twoPointTotal = a2;
                    
                    NSError *err;
                    [self.managedObjectContext save:&err];
                }
            }
            if (!exist) {
                TwoPoint *a = (TwoPoint *)[NSEntityDescription insertNewObjectForEntityForName:@"TwoPoint" inManagedObjectContext:_managedObjectContext];
                
                a.twoPointDay = [dateFormatter stringFromDate:today];
                int theOriginal = [a.twoPointGoal intValue];
                int theOriginal2 = [a.twoPointTotal intValue];
                NSNumber *a1 = [NSNumber numberWithInt:++theOriginal];
                NSNumber *a2 = [NSNumber numberWithInt:++theOriginal2];
                
                a.twoPointGoal = a1;
                a.twoPointTotal = a2;
                
                NSError *err;
                [self.managedObjectContext save:&err];

            }
        } else {
            //TODO no twopoint
            // TODO
        }
        
        
        // 2.get the People model right, add stuff to it
        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Player"
                                                   inManagedObjectContext:context];
        NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
        
        [fetchRequest2 setEntity:entity2];
        
        NSError *error2;
        NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error2];
        if (fetchedObjects2 == nil) {
            // Handle the error.
            NSLog(@"wori");
        }
        Player *player;
        NSLog(@"%d", fetchedObjects2.count);
        
        if (fetchedObjects2.count == 0) {
            player = (Player *)[NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:_managedObjectContext];
            
            NSError *err;
            [self.managedObjectContext save:&err];
            
        } else if (fetchedObjects2.count > 1) {
            NSLog(@"fetched player more than 1");
        } else {
            player = fetchedObjects2[0];
        }
        
        
        
        if (self.whatTypeOfCountingAreWeIn == CountForTwo) {
            int i = [player.twoPointScore integerValue];
            i = i + self.goalTimes;
            int j = [player.twoPointTry integerValue];
            j += self.shootingTimes;
            player.twoPointScore = [NSNumber numberWithInt:i];
            player.twoPointTry = [NSNumber numberWithInt:j];
            
            [self.managedObjectContext save:&error2];
        }
    } else {
        
    }

}

- (void)loadData {
    NSString *filePath = [self currentContentFilePath];
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    NSNumber *n1 = [data objectAtIndex:0];
    NSNumber *n2 = [data objectAtIndex:1];
    self.totalShootingTimes = n2.intValue;
    self.shootingTimes = n2.intValue;
    self.totalGoalTimes = n1.intValue;
    self.goalTimes = n1.intValue;
    NSLog(@"%@", self);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%d %d  --- %d %d", self.shootingTimes, self.totalShootingTimes, self.goalTimes, self.totalGoalTimes];
}

@end
