//
//  StudyController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "StudyController.h"
#import "AnswerList.h"
#import "Study.h"

static NSString *const QuestionNumberKey = @"questionNumber";
static NSString *const QuestionTitleKey = @"questionTitle";
static NSString *const AnswerKey = @"answer";
static NSString *const AnswersNeededKey = @"answersNeeded";
static NSString *const BadAnswerKey = @"badAnswer";
static NSString *const ExplanationKey = @"explanationTitle";

@interface StudyController ()

@property (strong, nonatomic)NSArray *localAnswersArray;
@property (strong, nonatomic)NSMutableArray *answers;

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


+(NSInteger)questionCount {
    return [[self answers]count];
}

+(NSDictionary *)questionAtIndex:(NSInteger)index {
    return [self answers][index];
}

+(NSString *)questionNumberAtIndex:(NSInteger)index {
    return [self answers][index][QuestionNumberKey];
}

+(NSString *)questionTitleAtIndex:(NSInteger)index {
    return [self answers][index][QuestionTitleKey];
}

+(NSNumber *)answersNeededAtIndex:(NSInteger)index {
    return [self answers][index][AnswersNeededKey];
}

+(NSInteger)answerCountAtIndex:(NSInteger)index {
    return [[self answers][index][AnswerKey]count];
}

+(NSString *)answerAtIndex:(NSInteger)ingIndex inQuestionAtIndex:(NSInteger)ansIndex {
    return [self answers][ansIndex][AnswerKey][ingIndex];
}

+(NSString *)BadAnswerAtIndex:(NSInteger)ingIndex inQuestionAtIndex:(NSInteger)ansIndex {
    return [self answers][ansIndex][BadAnswerKey][ingIndex];
}

+(NSString *)explanationAtIndex:(NSInteger)index {
    return [self answers][index][ExplanationKey];
}

- (void)setAnswerAtIndex:(NSInteger)anIndex forQuestionAtIndex:(NSInteger)index WithName:(NSString *)setName  {
    self.answers[index][@"AnswerKey"][anIndex] = setName;
}
+(NSMutableArray *)answers {
    AnswerList *answerList = [AnswerList new];
    NSInteger answersCount = answerList.answers.count -1;
    NSMutableArray *newAnswers = answerList.answers[answersCount];
    
    return newAnswers;
}

- (void)createFullArrayWithCivicsInfoGvernor:(NSString *)governor senatorOneName:(NSString *)senatorOne senatorTwoName:(NSString *)senatorTwo repName:(NSString *)representative stateCapitalName:(NSString *)stateCapital {
    
    AnswerList *answerList = [AnswerList new];
    NSArray * initialAnswersArray = [[NSMutableArray alloc]initWithArray:[Study storedAnswers]];
   
    NSArray *prepData = [[NSArray alloc]initWithObjects:
                                @{QuestionNumberKey: @"97", //need the Senator info from storage
                                  QuestionTitleKey: @"Who is one of your state’s U.S. Senators now?",
                                  AnswersNeededKey: @1,
                                  AnswerKey : @[senatorOne, senatorTwo],
                                  BadAnswerKey: @[@"Joe Biden",
                                                  @"Hilary Clinton",
                                                  @"John Kerry",
                                                  @"Bill Clinton",
                                                  @"George Bush"],
                                  ExplanationKey: @"Each State has 2 Senators."
                                  },
                                @{QuestionNumberKey: @"98",
                                  QuestionTitleKey: @"Name your U.S. Representative",
                                  AnswersNeededKey: @1,
                                  AnswerKey : @[representative],
                                  BadAnswerKey: @[@"John Kerry",
                                                  @"Hillary Clinton",
                                                  @"Bill Clinton",
                                                  @"Joseph Biden",
                                                  @"George Bush"],
                                  ExplanationKey: @"Your representative represents you and your local community and is elected every 2 years."
                                  },
                                @{QuestionNumberKey: @"99",
                                  QuestionTitleKey: @"Who is the Governor of your state now?",
                                  AnswersNeededKey: @1,
                                  AnswerKey : @[governor],
                                  BadAnswerKey: @[@"John Kerry",
                                                  @"Hillary Clinton",
                                                  @"Paul Vanduren",
                                                  @"William J. Todd",
                                                  @"Thomas Jefferson"],
                                  ExplanationKey: @"Your Governor is elected to be the chief executive of the state in which you live."
                                  },
                                @{QuestionNumberKey: @"100",
                                  QuestionTitleKey: @"What is the capital of your state?",
                                  AnswersNeededKey: @1,
                                  AnswerKey : @[stateCapital],
                                  BadAnswerKey: @[@"texas",
                                                  @"washington",
                                                  @"Always the city with the most people",
                                                  @"the moon",
                                                  @"hollywood"],
                                  ExplanationKey: @"The state capital is where the leaders of your state conduct business."
                                  }, nil];
    self.answers = [initialAnswersArray mutableCopy];
    [self.answers replaceObjectsInRange:NSMakeRange(96,99) withObjectsFromArray:prepData];
//    self.answers[98][@"AnswerKey"][0] = [NSString stringWithFormat:@"%@",governor];
//    self.answers[96][@"AnswerKey"][0] = [NSString stringWithFormat:@"%@",senatorOne];
//    self.answers[96][@"AnswerKey"][1] = [NSString stringWithFormat:@"%@",senatorTwo];
//    self.answers[97][@"AnswerKey"][0] = [NSString stringWithFormat:@"%@",representative];
//    self.answers[99][@"AnswerKey"][0] = [NSString stringWithFormat:@"%@",stateCapital];
    answerList.answers = self.answers;
    [self addArray:answerList];
    
}

- (void)addArray:(AnswerList *)answerList {
    if (!answerList) {
        return;
    }
    
    NSMutableArray *mutableEntries = self.localAnswersArray.mutableCopy;
    [mutableEntries addObject:answerList];
    
    self.localAnswersArray = mutableEntries;
    [self saveToPersistentStorage];
}
- (void)removeArray: (AnswerList *)answerList {
    if (!answerList) {
        return;
    }
    NSMutableArray *mutableEntries = self.answers.mutableCopy;
    [mutableEntries removeObject:answerList];
    
    self.answers = mutableEntries;
    [self saveToPersistentStorage];
}

#pragma mark - Read

- (void)saveToPersistentStorage {
    NSMutableArray *entryDictionaries = [NSMutableArray new];
    for (AnswerList *answerList in self.localAnswersArray) {
        [entryDictionaries addObject:[answerList dictionaryRepresentation]];
    }
    
    [entryDictionaries writeToFile:self.pathToFile atomically:YES];
}

- (void)loadFromPersistentStorage {
    
    NSArray *answersDictionaries = [NSArray arrayWithContentsOfFile:self.pathToFile];
    
    NSMutableArray *answersArray = [NSMutableArray new];
    for (NSDictionary *answer in answersDictionaries) {
        [answersArray addObject:[[AnswerList alloc] initWithDictionary:answer]];
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
