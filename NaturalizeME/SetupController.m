//
//  SetupController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/25/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "SetupController.h"
#import "Stack.h"
#import "QuestionTemplateController.h"
#import "QuestionController.h"

@interface SetupController ()

//@property (strong, nonatomic)NSArray *civicsInfo;

@end

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
    
    SetupInfo *civicsInfo = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([SetupInfo class]) inManagedObjectContext:[Stack sharedInstance].managedObjectContext];

    civicsInfo.governnor = governor;
    civicsInfo.senatorOne = senatorOne;
    civicsInfo.senatorTwo = senatorTwo;
    civicsInfo.representative = representative;
    civicsInfo.stateCapital = stateCapital;
    
    
    [self saveToPersistentStorage];

    
    return civicsInfo;
  
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
