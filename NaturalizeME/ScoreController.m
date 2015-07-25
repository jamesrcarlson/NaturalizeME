//
//  ScoreController.m
//  NaturalizeMe
//
//  Created by James Carlson on 7/21/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "ScoreController.h"
#import "Stack.h"


@implementation ScoreController

+ (ScoreController *)sharedInstance {
    static ScoreController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [ScoreController new];
    });
    return sharedInstance;
}

-(void)saveToPersistentStorage {
    [[Stack sharedInstance].managedObjectContext save:nil];
}

-(NSArray *)scores {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Scores class])];
    NSArray *fetchedObjects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:nil];
    
    return fetchedObjects;
}

-(Scores *)createScoreWithDate:(NSDate *)date score:(NSInteger)score {
    Scores *scores = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Scores class]) inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    scores.timestamp = [NSDate date];
    scores.quizScore = score;
    
    [self saveToPersistentStorage];
    
    return scores;
}

-(void)save {
    [self saveToPersistentStorage];
}

-(void)removeScore: (Scores *)score {
    [score.managedObjectContext deleteObject:score];
}

@end
