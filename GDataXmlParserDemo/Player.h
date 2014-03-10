//
//  Player.h
//  GDataXmlParserDemo
//
//  Created by Ankita Kalangutkar on 06/03/14.
//  Copyright (c) 2014 creative capsule. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RPGClassFighter,
    RPGClassShadow,
    RPGClassWizard
}RPGClass;

@interface Player : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,readwrite) int level;
@property (nonatomic, readwrite) RPGClass rpgClass;

-(id) initWithName: (NSString *) name level:(int) level rpgClass: (RPGClass) rpgClass;
@end
