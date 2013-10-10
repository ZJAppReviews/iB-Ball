//
//  GameKitHelper.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-10-9.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <GameKit/GameKit.h>
// Protocol to notify external
// objects when Game Center events occur or
// when Game Center async tasks are completed
@protocol GameKitHelperProtocol<NSObject>
-(void) onAchievementsLoaded:(NSDictionary*)achievements;
@end

@interface GameKitHelper : NSObject
@property (nonatomic, assign) id<GameKitHelperProtocol> delegate;
// This property holds the last known error
// that occured while using the Game Center API's
@property (nonatomic, readonly) NSError* lastError;
// This property holds Game Center achievements
@property (nonatomic, readonly) NSMutableDictionary* achievements;
+ (id) sharedGameKitHelper;
// Player authentication, info
-(void) authenticateLocalPlayer;
@end