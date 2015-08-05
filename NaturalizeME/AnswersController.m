//
//  AnswersController.m
//  NaturalizeME
//
//  Created by James Carlson on 8/5/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "AnswersController.h"
#import "StudyController.h"

static NSString *const QuestionNumberKey = @"questionNumber";
static NSString *const QuestionTitleKey = @"questionTitle";
static NSString *const AnswerKey = @"answer";
//static NSString *const AnswersKey = @"answers";
static NSString *const AnswersNeededKey = @"answersNeeded";
static NSString *const BadAnswerKey = @"badAnswer";
static NSString *const ExplanationKey = @"explanationTitle";


@implementation AnswersController

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

+(void)setAnswerAtIndex:(NSInteger)anIndex forQuestionAtIndex:(NSInteger)index WithName:(NSString *)setName  {
    self.answers[index][@"AnswerKey"][anIndex] = setName;
}
+(NSMutableArray *)answers {
//    [[StudyController sharedInstance].answersHolderArray;
//    Answers *answers = [Answers new];
    NSMutableArray *newAnswers = [[NSMutableArray alloc]initWithArray:[StudyController sharedInstance].answersHolderArray];
    
    return newAnswers;
}




@end
