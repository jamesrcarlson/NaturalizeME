//
//  StudyController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "StudyController.h"
#import "Study.h"

@interface StudyController ()

@property (strong, nonatomic)NSArray *localAnswersArray;

@end

@implementation StudyController

+ (StudyController *)sharedInstance {
    static StudyController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [StudyController new];
        [sharedInstance loadFromPersistentStorage];
    });
    return sharedInstance;
}

- (Study *)createFullArrayWithCivicsInfoGvernor:(NSString *)governor senatorOneName:(NSString *)senatorOne senatorTwoName:(NSString *)senatorTwo repName:(NSString *)representative stateCapitalName:(NSString *)stateCapital {
    Study *study = [Study new];
    study.answers = [[NSMutableArray alloc]initWithArray:[Study storedAnswers]];
    study.answers[42][@"AnswerKey"][0] = governor;
    study.answers[0][@"AnswerKey"][19] = governor;
    study.answers[1][@"AnswerKey"][19] = governor;
    study.answers[0][@"AnswerKey"][22] = governor;
    study.answers[0][@"AnswerKey"][43] = governor;
    
    [self addArray:study];
    return study;
}

- (void)addArray:(Study *)study {
    if (!study) {
        return;
    }
    
    NSMutableArray *mutableEntries = self.localAnswersArray.mutableCopy;
    [mutableEntries addObject:study];
    
    self.localAnswersArray = mutableEntries;
    [self saveToPersistentStorage];
}

#pragma mark - Read

- (void)saveToPersistentStorage {
    NSMutableArray *entryDictionaries = [NSMutableArray new];
    for (Study *study in self.localAnswersArray) {
        [entryDictionaries addObject:[study dictionaryRepresentation]];
    }
    
    [entryDictionaries writeToFile:self.pathToFile atomically:YES];
}

- (void)loadFromPersistentStorage {
    
    NSArray *answersDictionaries = [NSArray arrayWithContentsOfFile:self.pathToFile];
    
    NSMutableArray *answersArray = [NSMutableArray new];
    for (NSDictionary *answer in answersDictionaries) {
        [answersArray addObject:[[Study alloc] initWithDictionary:answer]];
    }
    
    self.localAnswersArray = answersArray;
    
}

#pragma mark - Update

- (void)save {
    [self saveToPersistentStorage];
}


- (NSString *)pathToFile {
    //Creating a file path:
    //1) Search for the app's documents directory (copy+paste from Documentation)
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //2) Create the full file path by appending the desired file name
    NSString *pathToFile = [documentsDirectory stringByAppendingPathComponent:@"entries.plist"];
    
    return pathToFile;
}



@end
