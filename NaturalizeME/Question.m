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
                             BadAnswerKey : self.incorrectAnswers
                             };
    return myDict;
}

@end
