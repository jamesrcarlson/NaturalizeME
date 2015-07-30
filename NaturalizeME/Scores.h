//
//  Scores.h
//  NaturalizeME
//
//  Created by James Carlson on 7/29/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scores : NSObject

@property (assign) NSNumber * quizScore;
@property (nonatomic, retain) NSDate * timestamp;

-(id) initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)scoreDictionary;

@end
