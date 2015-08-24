//
//  QuizViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "QuestionViewController.h"
#import "TextLabelTableViewCell.h"
#import "QuestionController.h"
#import "ScoreViewController.h"
#import "ScoreController.h"
#import "SetupController.h"
#import "AnswerStudyViewController.h"
#import "Question.h"

typedef NS_ENUM(NSUInteger, TableViewSection) {
    TableViewSectionQuestion,
    TableViewSectionAnswers,
    TableViewSectionQuit,
};




static NSString * const showScoreSegue = @"showScores";

@interface QuestionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong) Question *question;
@property (strong) QuestionController *controller;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong) UILabel *rightAnswer; //animated label
@property (strong) UILabel *wrongAnswer; //animated label

@property (assign, nonatomic) NSInteger currentScores;
@property (assign, nonatomic) NSInteger totalAnswersGiven;
@property (strong, nonatomic) NSMutableArray *wrongAnswersChosen;
@property (strong, nonatomic) NSMutableArray *answerNumberArray;

@property (strong, nonatomic) NSArray *answers;

@property (assign, nonatomic) NSInteger answerStatus;
@property (assign, nonatomic) NSInteger answersAttempted;

@property (assign, nonatomic) NSInteger newQuestion;

@property (strong, nonatomic) NSMutableArray *questionsArray;


@end

@implementation QuestionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.navigationItem backBarButtonItem]setAction:@selector(popViewController)];
    
    self.answerStatus = 0;
    self.answersAttempted = 0;
    self.currentScores = 0;
    self.totalAnswersGiven = 0;
    self.controller = [QuestionController new];
    self.wrongAnswersChosen = [NSMutableArray new];
    self.answerNumberArray = [NSMutableArray new];
    
    if (self.quizType == 1) {
        [self updateWithQuestion:self.controller.fastQuizQuestions[arc4random_uniform(10)]];
        self.questionsArray = self.controller.fastQuizQuestions;
    }else if (self.quizType == 2) {
        [self updateWithQuestion:self.controller.questions[arc4random_uniform(100)]];
        self.questionsArray = self.controller.questions;
    }
    
    self.answers = [[NSMutableArray alloc]initWithArray: self.question.randomSetOfAnswers];
    [self updateTitle];
    
}

-(void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)updateTitle {
    if (self.quizType == 1) {
        self.title = [NSString stringWithFormat:@"Question %ld of 10", (long)self.totalAnswersGiven + 1];
    }else if (self.quizType == 2) {
        self.title = [NSString stringWithFormat:@"Question %ld of 100", (long)self.totalAnswersGiven + 1];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TableViewSection tableViewSection = section;
    
    switch (tableViewSection) {
        case TableViewSectionQuestion:
            
            return 1;
        
        case TableViewSectionAnswers:
            
            return self.answers.count;
            
        case TableViewSectionQuit:
            
            return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewSection tableViewSection = indexPath.section;
    
    switch (tableViewSection) {
        case TableViewSectionQuestion:
            
            return 200;
            
        case TableViewSectionAnswers:
            
            return 70;
            
        case TableViewSectionQuit:
            
            return 70;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questionCell" forIndexPath:indexPath];
    cell.myLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    cell.myLabel.textAlignment = NSTextAlignmentCenter;
    cell.myLabel.numberOfLines = 0;
    if (indexPath.section == TableViewSectionQuestion) {
        cell.myLabel.text = self.question.title;
        cell.myLabel.font = [UIFont boldSystemFontOfSize:30];
        cell.backgroundColor = [UIColor blueColor];
        cell.myLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = NO;
        
    }
    
    if (indexPath.section == TableViewSectionAnswers) {
        cell.myLabel.text = self.answers[indexPath.row];
    }
    
    if (indexPath.section == TableViewSectionQuit) {
            cell.myLabel.text = @"Quit and see scores";
            cell.backgroundColor = [UIColor lightGrayColor];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == TableViewSectionAnswers) {
            self.answersAttempted+=1;
        
            for (NSString *correctAnswer in self.question.correctAnswers) {
                if ([self.answers[indexPath.row] isEqualToString:correctAnswer]) {
                    self.answerStatus+=1;
                }
            }
        
        if (self.question.answersNeeded.integerValue == 1 && self.answerStatus == 1) {
            [self gotTheRightAnswer:self.answers[indexPath.row]];
        }else if (self.question.answersNeeded.integerValue == 2 && self.answerStatus == 2) {
            [self gotTheRightAnswer:self.answers[indexPath.row]];
        }
        else if (self.question.answersNeeded.integerValue == 3 && self.answerStatus == 3) {
            [self gotTheRightAnswer:self.answers[indexPath.row]];
        }
        if (self.answersAttempted == self.question.answersNeeded.integerValue) {
            
            if (self.question.answersNeeded.integerValue > 1 ) {
                if (self.answerStatus < self.question.answersNeeded.integerValue || self.answerStatus == 0) {
                    [self gotItWrong:self.answers[indexPath.row]];
                }
            }else {
                [self gotItWrong:self.answers[indexPath.row]];
            }
        }
    }
    
    if (indexPath.section == TableViewSectionQuit) {
        
        [self quit];
    }
}

- (void)quit{
    self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) answersAttemped:(NSNumber*)@(self.totalAnswersGiven) wrongAsnwers:self.wrongAnswersChosen answerNumber:self.answerNumberArray];
    //        [[ScoreController sharedInstance]save];
    
    ScoreViewController *scoreViewController = (ScoreViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ScoreViewController"];
    [self.navigationController pushViewController:scoreViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotTheRightAnswer:(NSString *)buttonTitle {
    self.answerStatus = 0;
    self.answersAttempted = 0;
    self.currentScores+=1;
    self.totalAnswersGiven+=1;
    
    [self updateQuestion];
    
    self.answers = self.question.randomSetOfAnswers;
    [self.tableView reloadData];
    [self updateTitle];

}

-(void)gotItWrong:(NSString *)buttonTitle {
    self.answerStatus = 0;
    self.answersAttempted = 0;
    self.totalAnswersGiven+=1;
    
    [self.wrongAnswersChosen addObject:[NSString stringWithFormat:@"%@",self.question.title]];
    [self.answerNumberArray addObject:[NSString stringWithFormat:@"%@",self.question.questionNumber]];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You got it wrong" message:@"Would you like to see the answer?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        AnswerStudyViewController *answerStudyViewController = (AnswerStudyViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AnswerStudyViewController"];
        answerStudyViewController.question = self.question;
        
        [self.navigationController pushViewController:answerStudyViewController animated:YES];
        
        if (!self.lastQuestion) {
            [self updateQuestion];
            
            self.answers = self.question.randomSetOfAnswers;
            [self updateTitle];
            [self.tableView reloadData];
        } else {
            NSMutableArray *mutableViewControllers = self.navigationController.viewControllers.mutableCopy;
            self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) answersAttemped:(NSNumber*)@(self.totalAnswersGiven) wrongAsnwers:self.wrongAnswersChosen answerNumber:self.answerNumberArray];
            ScoreViewController * scoreViewController = (ScoreViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ScoreViewController"];
            scoreViewController.navigationItem.hidesBackButton = YES;

            [mutableViewControllers insertObject:scoreViewController atIndex:2];
            [self.navigationController setViewControllers:mutableViewControllers animated:NO];
        }
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Not now" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self updateQuestion];
        self.answers = self.question.randomSetOfAnswers;
        [self updateTitle];
        [self.tableView reloadData];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (BOOL)lastQuestion {
    if (self.quizType == 1) {
        if (self.totalAnswersGiven >= 10) {
            return YES;
        }
    } else if (self.quizType == 2) {
        if (self.totalAnswersGiven >= 100) {
            return YES;
        }
    }
    return NO;
}

- (void) updateQuestion {
    [self.questionsArray removeObjectAtIndex:self.newQuestion];
    self.newQuestion = arc4random_uniform((int)self.questionsArray.count);
    
    if (self.lastQuestion) {
        [self quit];
    } else {
            [self updateWithQuestion:self.questionsArray[self.newQuestion]];
        }    
}


-(void)updateWithQuestion:(Question *)question {
    
        self.question = question;

    // when you move the question to header view, you set the label for that header view here to the question's .title
}


@end
