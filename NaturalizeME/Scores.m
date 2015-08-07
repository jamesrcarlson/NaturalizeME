//
//  Scores.m
//  NaturalizeME
//
//  Created by James Carlson on 7/29/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "Scores.h"


static NSString * const QuizScoreKey = @"quizScore";
static NSString * const AnswersCompletedKey = @"answersCompelted";
static NSString * const TimeStampKey = @"timeStamp";
static NSString * const WrongAnswerKey = @"wrongAnswer";
static NSString * const AnswerNumberKey = @"answerNumber";

@implementation Scores


-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.quizScore = dictionary[QuizScoreKey];
        self.answersCompleted = dictionary[AnswersCompletedKey];
        self.timestamp = dictionary[TimeStampKey];
        self.wrongAnswer = dictionary[WrongAnswerKey];
        self.answerNumber = dictionary[AnswerNumberKey];
        
    };
    
    return self;
}

-(NSDictionary *)scoreDictionary {
    NSDictionary *dictionary = @{ QuizScoreKey : self.quizScore,
                                  AnswersCompletedKey : self.answersCompleted,
                                  TimeStampKey : self.timestamp,
                                  WrongAnswerKey :self.wrongAnswer,
                                  AnswerNumberKey : self.answerNumber};
    return dictionary;
}

@end

