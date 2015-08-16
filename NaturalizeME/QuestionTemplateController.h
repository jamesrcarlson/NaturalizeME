//
//  Study.h
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const QuestionNumberKey = @"questionNumber";
static NSString *const QuestionTitleKey = @"questionTitle";
static NSString *const AnswerKey = @"answer";
static NSString *const AnswersNeededKey = @"answersNeeded";
static NSString *const BadAnswerKey = @"badAnswer";
static NSString *const ExplanationKey = @"explanationTitle";
static NSString *const DidDisplayKey = @"didDisplay";

@interface QuestionTemplateController : NSObject


+(NSArray *)storedAnswers;


@end
