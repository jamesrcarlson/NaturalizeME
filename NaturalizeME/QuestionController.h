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

@property (strong, readonly) NSArray *questions;
@property (strong, readonly) NSArray *fastQuizQuestions;


@end