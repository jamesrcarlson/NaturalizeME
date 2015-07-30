//
//  ScoreController.h
//  NaturalizeMe
//
//  Created by James Carlson on 7/21/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scores.h"

@interface ScoreController : NSObject

@property (strong, readonly, nonatomic) NSArray *scores;

@property (strong)NSNumber *latestQuizScore;

+ (ScoreController *)sharedInstance;

-(Scores *)createScoreWithDate:(NSDate *)date score:(NSNumber *)score;

-(void)save;

-(void)removeScore: (Scores *)score;

@end
