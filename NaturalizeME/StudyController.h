//
//  StudyController.h
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Study.h"
#import "AnswerList.h"

@interface StudyController : NSObject

+ (StudyController *)sharedInstance;

@property (nonatomic, retain) NSString * question;
@property (nonatomic, strong, readonly) NSMutableArray * answers;
@property (strong, nonatomic, readonly) NSArray *localAnswersArray;

//@property (nonatomic, strong)NSArray *anotherAnswersArray;

+(NSInteger)questionCount;

+(NSDictionary *)questionAtIndex:(NSInteger)index;

+(NSString *)questionNumberAtIndex:(NSInteger)index;

+(NSString *)questionTitleAtIndex:(NSInteger)index;

+(NSNumber *)answersNeededAtIndex:(NSInteger)index;

+(NSInteger)answerCountAtIndex:(NSInteger)index;

+(NSString *)answerAtIndex:(NSInteger)ingIndex inQuestionAtIndex:(NSInteger)ansIndex;

+(NSString *)BadAnswerAtIndex:(NSInteger)ingIndex inQuestionAtIndex:(NSInteger)ansIndex;

+(NSString *)explanationAtIndex:(NSInteger)index;

- (void)createFullArrayWithCivicsInfoGvernor:(NSString *)governor senatorOneName:(NSString *)senatorOne senatorTwoName:(NSString *)senatorTwo repName:(NSString *)representative stateCapitalName:(NSString *)stateCapital;

- (void)addArray:(AnswerList *)answerList;

- (void)save;

@end
