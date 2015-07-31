//
//  ScoreController.m
//  NaturalizeMe
//
//  Created by James Carlson on 7/21/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "ScoreController.h"

static NSString * const AllScoresKey = @"allScores";


@interface ScoreController ()

@property (strong, nonatomic) NSArray *scores;

@end

@implementation ScoreController

+ (ScoreController *)sharedInstance {
    static ScoreController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [ScoreController new];
        [sharedInstance loadFromStorage];
    });
    return sharedInstance;
}



-(Scores *)createScoreWithDate:(NSDate *)date score:(NSNumber *)score wrongAsnwers:(NSArray *)wrongAnswer {
    Scores *scores = [Scores new];
    scores.timestamp = [NSDate date];
    self.latestQuizScore = score;
    scores.quizScore = score;
    scores.wrongAnswer = wrongAnswer;
    
    [self addScoreToArray:scores];
    
    return scores;
}

-(void)addScoreToArray:(Scores *)scores {
    
    if (!scores) {
        return;
    }
    NSMutableArray *mutableScores = self.scores.mutableCopy;
    [mutableScores addObject:scores];
    
    self.scores = mutableScores;
    [self storeScoresInFile];
}

-(void)save {
    [self storeScoresInFile];
}

-(void)removeScore: (Scores *)score {
    if (!score) {
        return;
    }
    NSMutableArray *mutableEntries = self.scores.mutableCopy;
    [mutableEntries removeObject:score];
    
    self.scores = mutableEntries;
    [self storeScoresInFile];
}

-(void)storeScoresInFile {
    NSMutableArray *scoresDictionary = [NSMutableArray new];
    
    for (Scores *scores in self.scores) {
        [scoresDictionary addObject:[scores scoreDictionary]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:scoresDictionary forKey:AllScoresKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)loadFromStorage {
    NSArray *scoresDictionaries = [[NSUserDefaults standardUserDefaults]objectForKey:AllScoresKey];
    
    NSMutableArray *scores = [NSMutableArray new];
    for (NSDictionary *score in scoresDictionaries) {
        [scores addObject:[[Scores alloc]initWithDictionary:score]];
    }
    self.scores = scores;
}

-(NSArray *)practiceScores {
    return @[@25,@32,@42,@53];
}

//- (NSString *)pathToFile {
//    
//    // Search for the app's documents directory (copy+paste from Documentation)
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    
//    //Create the full path by appending the file name to the string
//    NSString *pathToFile = [documentsDirectory stringByAppendingString:@"scores.plist"];
//    
//    return pathToFile;
//    
//}


@end
