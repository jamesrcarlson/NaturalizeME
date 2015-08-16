//
//  Question.m
//  NaturalizeME
//
//  Created by James Carlson on 8/13/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "Question.h"
#import "QuestionTemplateController.h"

@implementation Question


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (self) {
        self.title = dictionary[QuestionTitleKey];
        self.questionNumber = dictionary[QuestionNumberKey];
        self.answersNeeded = dictionary[AnswersNeededKey];
        self.explanation = dictionary[ExplanationKey];
        self.correctAnswers = dictionary[AnswerKey];
        self.incorrectAnswers = dictionary[BadAnswerKey];
        self.didDisplay = dictionary[DidDisplayKey];
    }
    return self;

}

- (NSDictionary *)dictionaryRepresentation {
    NSDictionary *myDict = @{
                             QuestionTitleKey : self.title,
                             QuestionNumberKey : self.questionNumber,
                             AnswersNeededKey : self.answersNeeded,
                             ExplanationKey : self.explanation,
                             AnswersNeededKey : self.correctAnswers,
                             BadAnswerKey : self.incorrectAnswers,
                             DidDisplayKey : self.didDisplay
                             };
    return myDict;
}

- (NSArray *) randomSetOfAnswers {
    
    NSMutableArray *answerNumbers = [[NSMutableArray alloc]initWithObjects:@0, @1, @2, @3, @4, nil];
    NSMutableArray *multipleRightAnswers = [NSMutableArray new];
    
    
    for (NSInteger i = 0; i < self.correctAnswers.count; i++) {
        [multipleRightAnswers addObject:@(i)];
    }
    
    NSMutableArray *completeAnswerList = [NSMutableArray new];
    NSMutableArray *finalArray = [NSMutableArray new];
    
    if (self.answersNeeded.integerValue == 1) {
        for (int i = 0; i < 3; i++) {
            int answerArrayNumber = arc4random_uniform((int)answerNumbers.count);
            NSInteger answerNumber = [answerNumbers[answerArrayNumber]integerValue];
            NSString *answerText = self.incorrectAnswers[answerNumber];
            [completeAnswerList addObject:answerText];
            [answerNumbers removeObjectAtIndex:answerArrayNumber];
        }
        int answerArrayNumber = arc4random_uniform((int)multipleRightAnswers.count);
        NSInteger answerNumber = [multipleRightAnswers[answerArrayNumber]integerValue];
        NSString *answerText = self.correctAnswers[answerNumber];
        [completeAnswerList addObject:answerText];
    }else if (self.answersNeeded.integerValue == 2) {
        for (int i = 0; i < 2; i++) {
            int answerArrayNumber = arc4random_uniform((int)answerNumbers.count);
            NSInteger answerNumber = [answerNumbers[answerArrayNumber]integerValue];
            NSString *answerText = self.incorrectAnswers[answerNumber];
            [completeAnswerList addObject:answerText];
            [answerNumbers removeObjectAtIndex:answerArrayNumber];
        }
        for (int i = 0; i < 2; i++) {
            int answerArrayNumber = arc4random_uniform((int)multipleRightAnswers.count);
            NSInteger answerNumber = [multipleRightAnswers[answerArrayNumber]integerValue];
            NSString *answerText = self.correctAnswers[answerNumber];
            [completeAnswerList addObject:answerText];
            [multipleRightAnswers removeObjectAtIndex:answerArrayNumber];
        }
        
    }else if (self.answersNeeded.integerValue == 3) {
        for (int i = 0; i < 1; i++) {
            int answerArrayNumber = arc4random_uniform((int)answerNumbers.count);
            NSInteger answerNumber = [answerNumbers[answerArrayNumber]integerValue];
            NSString *answerText = self.incorrectAnswers[answerNumber];
            [completeAnswerList addObject:answerText];
            [answerNumbers removeObjectAtIndex:answerArrayNumber];
        }
        for (int i = 0; i < 3; i++) {
            int answerArrayNumber = arc4random_uniform((int)multipleRightAnswers.count);
            NSInteger answerNumber = [multipleRightAnswers[answerArrayNumber]integerValue];
            NSString *answerText = self.correctAnswers[answerNumber];
            [completeAnswerList addObject:answerText];
            [multipleRightAnswers removeObjectAtIndex:answerArrayNumber];
        }
        
    }

    for (int i = 0; i < 4; i++) {
        int myAnswer = arc4random_uniform((int)completeAnswerList.count);
        [finalArray addObject:completeAnswerList[myAnswer]];
        [completeAnswerList removeObjectAtIndex:myAnswer];
    }
    return finalArray;

}

@end
