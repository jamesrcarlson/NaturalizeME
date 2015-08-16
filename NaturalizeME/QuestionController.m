//
//  StudyController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "QuestionController.h"
#import "QuestionTemplateController.h"
#import "SetupController.h"
#import "SetupInfo.h"

@interface QuestionController ()

@property (strong) SetupInfo *setupInfo;

@end

@implementation QuestionController

- (NSMutableArray *)questions {
    
    NSMutableArray *questionsArray = [NSMutableArray new];
    
    for (NSDictionary *dictionary in [QuestionTemplateController storedAnswers]) {
        Question *question = [[Question alloc]initWithDictionary:dictionary];
        question.didDisplay = @(1);
        [questionsArray addObject:question];
    }
    
    NSInteger latest = [SetupController sharedInstance].civicsInfo.count - 1;
    self.setupInfo = [SetupController sharedInstance].civicsInfo[latest];
    
    NSArray *prepData = [[NSArray alloc]initWithObjects: @{QuestionNumberKey: @"97",
                                                           QuestionTitleKey: @"Who is one of your state’s U.S. Senators now?",
                                                           AnswersNeededKey: @(1),
                                                           DidDisplayKey : @(1),
                                                           AnswerKey : @[self.setupInfo.senatorOne, self.setupInfo.senatorTwo],
                                                           BadAnswerKey: @[@"Joe Biden",
                                                                           @"Hilary Clinton",
                                                                           @"John Kerry",
                                                                           @"Bill Clinton",
                                                                           @"George Bush"],
                                                           ExplanationKey: @"Each State has 2 Senators."
                                                           },
                         @{QuestionNumberKey: @"98",
                           QuestionTitleKey: @"Name your U.S. Representative",
                           AnswersNeededKey: @(1),
                           DidDisplayKey : @(1),
                           AnswerKey : @[self.setupInfo.representative],
                           BadAnswerKey: @[@"John Kerry",
                                           @"Hillary Clinton",
                                           @"Bill Clinton",
                                           @"Joseph Biden",
                                           @"George Bush"],
                           ExplanationKey: @"Your representative represents you and your local community and is elected every 2 years."
                           },
                         @{QuestionNumberKey: @"99",
                           QuestionTitleKey: @"Who is the Governor of your state now?",
                           AnswersNeededKey: @(1),
                           DidDisplayKey : @(1),
                           AnswerKey : @[self.setupInfo.governnor],
                           BadAnswerKey: @[@"John Kerry",
                                           @"Hillary Clinton",
                                           @"Paul Vanduren",
                                           @"William J. Todd",
                                           @"Thomas Jefferson"],
                           ExplanationKey: @"Your Governor is elected to be the chief executive of the state in which you live."
                           },
                         @{QuestionNumberKey: @"100",
                           QuestionTitleKey: @"What is the capital of your state?",
                           AnswersNeededKey: @(1),
                           DidDisplayKey : @(1),
                           AnswerKey : @[self.setupInfo.stateCapital],
                           BadAnswerKey: @[@"texas",
                                           @"washington",
                                           @"Always the city with the most people",
                                           @"the moon",
                                           @"hollywood"],
                           ExplanationKey: @"The state capital is where the leaders of your state conduct business."
                           }, nil];
    [questionsArray addObjectsFromArray:prepData];
    
    return questionsArray;
}

- (NSMutableArray *)fastQuizQuestions {
    
    NSMutableArray *fastQuestions = [NSMutableArray new];
    
    for (NSInteger i = 0; i<10; i++) {
        NSInteger question = arc4random_uniform((int)self.questions.count);
        [fastQuestions addObject:self.questions[question]];
    }
    return fastQuestions;
}

@end
