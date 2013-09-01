//
//  iBSkill.m
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBSkill.h"

@implementation iBSkill


- (id)initWithName:(NSString *)name andTag:(iBSkillCategory)tag {
    self = [super init];
    if (self) {
        _skillName = name;
        _skillCategory = tag;
    }
    return self;

}

- (id)initWithName:(NSString *)name andDescrip:(NSString *)descrip andTag:(iBSkillCategory)tag
{
    self = [super init];
    if (self) {
        _skillName = name;
        _skillDescription = descrip;
        _skillCategory = tag;
    }
    return self;
}

- (float)getRatio {
    return self.successNumber / self.useNumber;
}

- (NSString *)description {
    NSString *prefix = @"Introducing Nango's description";
    return  [[prefix stringByAppendingString:[NSString stringWithFormat:@"%d, %d", self.useNumber, self.successNumber]] stringByAppendingString:self.skillName];
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.skillName forKey:P_1];
    [aCoder encodeInteger:self.useNumber forKey:P_2];
    [aCoder encodeInteger:self.successNumber forKey:P_3];
    [aCoder encodeInteger:self.skillCategory forKey:P_4];
    [aCoder encodeObject:self.skillDescription forKey:P_5];

}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self.skillName = [aDecoder decodeObjectForKey:P_1];
    self.useNumber = [aDecoder decodeIntegerForKey:P_2];
    self.successNumber = [aDecoder decodeIntegerForKey:P_3];
    self.skillCategory = [aDecoder decodeIntegerForKey:P_4];
    self.skillDescription = [aDecoder decodeObjectForKey:P_5];
    
    return self;
}

@end

