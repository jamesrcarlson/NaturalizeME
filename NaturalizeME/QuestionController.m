//
//  StudyController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "QuestionController.h"
#import "QuestionTemplateController.h"

@interface QuestionController ()


@end

@implementation QuestionController

-(NSArray *)questions {
    
    NSMutableArray *questionsArray = [NSMutableArray new];
    
    for (NSDictionary *dictionary in [QuestionTemplateController storedAnswers]) {
        Question *question = [[Question alloc]initWithDictionary:dictionary];
        [questionsArray addObject:question];
        
    }
    
    return questionsArray;
}

-(NSArray *)fastQuizQuestions {
    
    NSMutableArray *fastQuestions = [NSMutableArray new];
    
    for (NSInteger i = 0; i<10; i++) {
        NSInteger question = arc4random_uniform((int)self.questions.count);
        [fastQuestions addObject:self.questions[question]];
    }
    return fastQuestions;
}
#warning handle civics data
@end
