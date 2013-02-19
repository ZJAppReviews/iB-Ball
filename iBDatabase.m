//
//  iBDatabase.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/17/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBDatabase.h"
#import "iBDataCenterForHotzoneDoc.h"

@implementation iBDatabase

+ (NSString *)getPrivateDocsDir {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return documentsDirectory;
    
}

+ (NSString *)nextHotzoneDocPath {
    
    // Get private docs dir
    NSString *documentsDirectory = [iBDatabase getPrivateDocsDir];
    
//    // Get contents of documents directory
//    NSError *error;
//    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
//    if (files == nil) {
//        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
//        return nil;
//    }
//    
//    // Search for an available name
//    int maxNumber = 0;
//    for (NSString *file in files) {
//#warning todo
//        if ([file.pathExtension compare:@"scarybug" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
//            NSString *fileName = [file stringByDeletingPathExtension];
//            maxNumber = MAX(maxNumber, fileName.intValue);
//        }
//    }
//    
    // Get available name
#warning todo
    NSString *availableName = [NSString stringWithFormat:@"shoot.scarybug"];
    return [documentsDirectory stringByAppendingPathComponent:availableName];
    
}

+ (NSMutableArray *)loadHotzoneDocs {
    
    // Get private docs dir
    NSString *documentsDirectory = [iBDatabase getPrivateDocsDir];
    NSLog(@"Loading data from %@", documentsDirectory);
    
    // Get contents of documents directory
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (files == nil) {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    // Create ScaryBugDoc for each file
    NSMutableArray *retval = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files) {
#warning toDo
        if ([file.pathExtension compare:@"scarybug" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            iBDataCenterForHotzoneDoc *doc = [[iBDataCenterForHotzoneDoc alloc] initWithDocPath:fullPath];
            [retval addObject:doc];
        }
    }
    
    return retval;
    
}


@end
