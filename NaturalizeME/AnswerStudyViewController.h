//
//  AnswerStudyViewController.h
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Study.h"

@interface AnswerStudyViewController : UIViewController

@property (strong, nonatomic) Study *answer;
@property (assign) NSInteger questionIndex;

@end
