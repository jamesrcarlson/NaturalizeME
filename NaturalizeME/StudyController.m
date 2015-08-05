//
//  StudyController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "StudyController.h"



@interface StudyController ()

@property (strong, nonatomic)NSArray *answersHolderArray;

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


- (Answers *)createFullArrayWithCivicsInfoGvernor:(NSString *)governor senatorOneName:(NSString *)senatorOne senatorTwoName:(NSString *)senatorTwo repName:(NSString *)representative stateCapitalName:(NSString *)stateCapital {
    Answers *answers = [Answers new];
    answers.storedAnswers = [[NSMutableArray alloc]initWithArray:[Study storedAnswers]];
    
    
//    self.answersHolderArray = [[NSMutableArray alloc]initWithArray:[Study storedAnswers]];
//    self.answersHolderArray[42][@"AnswerKey"][0] = [NSString stringWithFormat:@"%@",governor];
//    self.answersHolderArray[19][@"AnswerKey"][0] = [NSString stringWithFormat:@"%@",senatorOne];
//    self.answersHolderArray[19][@"AnswerKey"][1] = [NSString stringWithFormat:@"%@",senatorTwo];
//    self.answersHolderArray[22][@"AnswerKey"][0] = [NSString stringWithFormat:@"%@",representative];
//    self.answersHolderArray[43][@"AnswerKey"][0] = [NSString stringWithFormat:@"%@",stateCapital];
    
    [self addArray:answers];
    return answers;
}

- (void)addArray:(Answers *)answers {
    if (!answers) {
        return;
    }
    
    NSMutableArray *mutableEntries = self.answersHolderArray.mutableCopy;
    [mutableEntries addObject:answers];
    
    self.answersHolderArray = mutableEntries;
    [self saveToPersistentStorage];
}


- (void)saveToPersistentStorage {
    NSMutableArray *entryDictionaries = [NSMutableArray new];
    for (Answers *answers in self.answersHolderArray) {
        [entryDictionaries addObject:[answers dictionaryRepresentation]];
    }
    
    [entryDictionaries writeToFile:self.pathToFile atomically:YES];
}

- (void)loadFromPersistentStorage {
    
    NSArray *answersDictionaries = [NSArray arrayWithContentsOfFile:self.pathToFile];
    
    NSMutableArray *answersArray = [NSMutableArray new];
    for (NSDictionary *answer in answersDictionaries) {
        [answersArray addObject:[[Answers alloc] initWithDictionary:answer]];
    }
    
    self.answersHolderArray = answersArray;
//    self.answers = [[NSMutableArray alloc]initWithArray:answersArray];
    
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
    NSString *pathToFile = [documentsDirectory stringByAppendingPathComponent:@"answers.plist"];
    
    return pathToFile;
}



@end
