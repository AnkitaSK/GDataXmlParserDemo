//
//  Player.m
//  GDataXmlParserDemo
//
//  Created by Ankita Kalangutkar on 06/03/14.
//  Copyright (c) 2014 creative capsule. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id) initWithName: (NSString *) name level:(int) level rpgClass: (RPGClass) class
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.level = level;
        self.rpgClass = class;
    }
    return self;
}
@end
