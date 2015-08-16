//
//  StudyController.h
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionTemplateController.h"
#import "Question.h"

@interface QuestionController : NSObject

@property (strong, nonatomic) NSMutableArray *questions;
@property (strong, nonatomic) NSMutableArray *fastQuizQuestions;


@end
