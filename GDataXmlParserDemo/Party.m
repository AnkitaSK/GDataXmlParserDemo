//
//  Party.m
//  GDataXmlParserDemo
//
//  Created by Ankita Kalangutkar on 06/03/14.
//  Copyright (c) 2014 creative capsule. All rights reserved.
//

#import "Party.h"

@implementation Party
-(id)init
{
    self = [super init];
    if (self)
    {
        self.playerArray = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
