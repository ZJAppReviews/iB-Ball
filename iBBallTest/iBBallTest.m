//
//  iBBallTest.m
//  iBBallTest
//
//  Created by Snowmanzzz on 13-9-1.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBBallTest.h"
#import "iBSkillDataModel.h"
#import "iBSkill.h"

@implementation iBBallTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
//    STFail(@"Unit tests are not implemented yet in iBBallTest");
//    iBSkillDataModel *test = [[iBSkillDataModel alloc] init];
    iBSkillDataModel *test = [[iBSkillDataModel alloc] init];
    iBSkill *testSkill = [[iBSkill alloc] init];
    [test addSkill:testSkill];

    
    
    STAssertTrue(test.otherSkills.count == 1, nil);
}

- (void)test2 {
}

@end
