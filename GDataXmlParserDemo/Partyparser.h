//
//  Partyparser.h
//  GDataXmlParserDemo
//
//  Created by Ankita Kalangutkar on 06/03/14.
//  Copyright (c) 2014 creative capsule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Party.h"

@interface Partyparser : NSObject
+(Party *) loadParty;
+(void) saveParty: (Party *)party;
@end
