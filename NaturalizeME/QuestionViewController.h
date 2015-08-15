//
//  QuizViewController.h
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scores.h"

typedef NS_ENUM(NSUInteger, StudyMode) {
    StudyModeFastQuiz,
    StudyModeAllQuestions,
};

@interface QuestionViewController : UIViewController

@property (assign, nonatomic) StudyMode studyMode;

@property (strong) Scores *scores;

@end
