//
//  Partyparser.m
//  GDataXmlParserDemo
//
//  Created by Ankita Kalangutkar on 06/03/14.
//  Copyright (c) 2014 creative capsule. All rights reserved.
//

#import "Partyparser.h"
#import "GDataXMLNode.h"
#import "Player.h"

@implementation Partyparser


+(NSString *) dataFilePath: (BOOL) forSave
{
    // inorder to write to the xml, get xml file from document directory
    NSString *documentDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *documentsPath = [documentDirectoryPath stringByAppendingString:@"Party.xml"];
    if (forSave || [[NSFileManager defaultManager] fileExistsAtPath:documentsPath])
    {
        return documentsPath;
    }
    else
    {
        return [[NSBundle mainBundle] pathForResource:@"Player" ofType:@"xml"];
    }
}

+(Party *) loadParty
{
    NSString * filePath = [self dataFilePath:FALSE];
    // get NSData from a file
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    //parse data
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    if (nil == document)
    {
        return nil;
    }
    Party *party = [[Party alloc] init];
    NSLog(@"%@", document.rootElement);
   // NSArray *partymembers = [document nodesForXPath:@"//Party/Player" error:nil];
//    or
    NSArray *partyMembers = [document.rootElement elementsForName:@"Player"];
    for (GDataXMLElement *player in partyMembers)
    {
        NSString *name;
        int level;
        
        NSArray *nameArray = [player elementsForName:@"Name"];
        if (nameArray.count >0)
        {
            GDataXMLElement *n = (GDataXMLElement*)[nameArray objectAtIndex:0];
            name = n.stringValue;
        }else continue;
        
        NSArray *levelArray = [player elementsForName:@"Level"];
        if (levelArray.count>0)
        {
            GDataXMLElement *l = (GDataXMLElement*)[levelArray objectAtIndex:0];
            level = l.stringValue.intValue;
        }
        else continue;
        Player *playerObject = [[Player alloc] initWithName:name level:level rpgClass:0];
        [party.playerArray addObject:playerObject];
        NSLog(@"party.playerArray %@", party.playerArray);
    }
    return party;
}

+(void) saveParty: (Party *)party
{
    // create a root element
    GDataXMLElement * partyElement = [GDataXMLNode elementWithName:@"Party"];
    
    for(Player *player in party.playerArray) {
        
        GDataXMLElement * playerElement = [GDataXMLNode elementWithName:@"Player"];
        GDataXMLElement * nameElement = [GDataXMLNode elementWithName:@"Name" stringValue:player.name];
        GDataXMLElement * levelElement = [GDataXMLNode elementWithName:@"Level" stringValue:
                                          
                                          [NSString stringWithFormat:@"%d", player.level]];
        
        [playerElement addChild:nameElement];
        [playerElement addChild:levelElement];
        //        [playerElement addChild:classElement];
        [partyElement addChild:playerElement]; //
        
    }
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:partyElement];
    NSData *xmlData = document.XMLData;
    
    // save to xml
    NSString *saveToFile = [self dataFilePath:TRUE];
    NSLog(@"Saving xml data to %@...", saveToFile);
    [xmlData writeToFile:saveToFile atomically:YES];
}

//+(void)saveParty:(Party *)party {
//    
//    GDataXMLElement * partyElement = [GDataXMLNode elementWithName:@"Party"];
//    
//    for(Player *player in party.playerArray) {
//        
//        GDataXMLElement * playerElement = [GDataXMLNode elementWithName:@"Player"];
//        GDataXMLElement * nameElement = [GDataXMLNode elementWithName:@"Name" stringValue:player.name];
//        GDataXMLElement * levelElement = [GDataXMLNode elementWithName:@"Level" stringValue:
//                                          
//                                          [NSString stringWithFormat:@"%d", player.level]];
//        
////        NSString *classString;
////        if (player.rpgClass == RPGClassFighter) {
////            classString = @"Fighter";
////        } else if (player.rpgClass == RPGClassShadow) {
////            classString = @"Rogue";
////        } else if (player.rpgClass == RPGClassWizard) {
////            classString = @"Wizard";
////        }
////        GDataXMLElement * classElement = [GDataXMLNode elementWithName:@"Class" stringValue:classString];
//        
//        [playerElement addChild:nameElement];
//        [playerElement addChild:levelElement];
////        [playerElement addChild:classElement];
//        [partyElement addChild:playerElement];
//    }
//    
//    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:partyElement];
//    NSData *xmlData = document.XMLData;
//    
//    NSString *filePath = [self dataFilePath:TRUE];
//    NSLog(@"Saving xml data to %@...", filePath);
//    [xmlData writeToFile:filePath atomically:YES];
//}

@end
