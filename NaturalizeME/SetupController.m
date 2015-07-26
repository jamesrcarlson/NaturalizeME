//
//  SetupController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/25/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "SetupController.h"
#import "Stack.h"
#import "Study.h"

@implementation SetupController

+ (SetupController *)sharedInstance {
    static SetupController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [SetupController new];
    });
    return sharedInstance;
}

- (SetupInfo *)storeCivicsInfo:(NSString *)governor senatorOneName:(NSString *)senatorOne senatorTwoName:(NSString *)senatorTwo repName:(NSString *)representative stateCapitalName:(NSString *)stateCapital {
    
    SetupInfo *setupInfo = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([SetupInfo class]) inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    setupInfo.governnor = governor;
    setupInfo.senatorOne = senatorOne;
    setupInfo.senatorTwo = senatorTwo;
    setupInfo.stateCapital = stateCapital;
    
    [Study setAnswerAtIndex:0 forQuestionAtIndex:42 WithName:governor];
    [Study setAnswerAtIndex:0 forQuestionAtIndex:19 WithName:senatorOne];
    [Study setAnswerAtIndex:1 forQuestionAtIndex:19 WithName:senatorTwo];
    [Study setAnswerAtIndex:0 forQuestionAtIndex:22 WithName:representative];
    [Study setAnswerAtIndex:0 forQuestionAtIndex:43 WithName:stateCapital];
    
    [self saveToPersistentStorage];
    
    return setupInfo;
    
}

-(NSArray *)civicsInfo {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([SetupInfo class])];
    
    NSArray *fetchedObjects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:nil];
    return fetchedObjects;
}


-(void)saveToPersistentStorage {
    [[Stack sharedInstance].managedObjectContext save:nil];
}

-(void)removeInfo:(SetupInfo *)civicInfo {
    
    [civicInfo.managedObjectContext deleteObject:civicInfo];
}

-(void)save {
    [self saveToPersistentStorage];
}


@end
