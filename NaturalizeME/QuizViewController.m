//
//  QuizViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "QuizViewController.h"
#import "QuizController.h"
#import "Study.h"

//static int questionIndex;

@interface QuizViewController ()

@property (strong, nonatomic) IBOutlet UILabel *questionTitle;

@property (strong, nonatomic) IBOutlet UIButton *answerOne;

@property (strong, nonatomic) IBOutlet UIButton *answerTwo;

@property (strong, nonatomic) IBOutlet UIButton *answerThree;

@property (strong, nonatomic) IBOutlet UIButton *answerFour;

@property (assign)NSInteger scores;


@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionTitle.text = @"Question 1 test"; //[self randomQuestions];
    self.answerOne.titleLabel.text = @"Question 1"; //[Study answerAtIndex:0 inQuestionAtIndex:self.questionIndex];
    self.answerTwo.titleLabel.text = @"Question 2"; //[Study answerAtIndex:1 inQuestionAtIndex:self.questionIndex];
    self.answerThree.titleLabel.text = @"Question 3"; //[Study answerAtIndex:2 inQuestionAtIndex:self.questionIndex];
    self.answerFour.titleLabel.text = @"Question 4"; //[Study answerAtIndex:3 inQuestionAtIndex:self.questionIndex];
    
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)answerOneButton:(id)sender {
//    [self.view reloadInputViews];
}

- (IBAction)answerTwoButton:(id)sender {
}

- (IBAction)answerThreeButton:(id)sender {
}

- (IBAction)answerFourButton:(id)sender {
}


@end
