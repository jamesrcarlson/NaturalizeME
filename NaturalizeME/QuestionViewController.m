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

@property (assign) NSInteger currentScores;
@property (assign) NSInteger totalAnswersGiven;
@property (strong) NSMutableArray *wrongAnswersChosen;
@property (strong) NSMutableArray *answerNumberArray;

@property (strong) NSArray *answers;

@property (assign) NSInteger answerStatus;
@property (assign) NSInteger answersAttempted;


@end

@implementation QuestionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.answerStatus = 0;
    self.answersAttempted = 0;
    self.controller = [QuestionController new];
    self.wrongAnswersChosen = [NSMutableArray new];
    self.answerNumberArray = [NSMutableArray new];
    
    if (self.quizType == 1) {
        [self updateWithQuestion:self.controller.questions[arc4random_uniform(10)]];
    }else if (self.quizType == 2) {
        [self updateWithQuestion:self.controller.questions[arc4random_uniform(100)]];
    }
    
    
    self.answers = [[NSArray alloc]initWithArray: self.question.randomSetOfAnswers];
    
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
    
    // check to see if they have the correct set of answers
    
    if (indexPath.section == TableViewSectionAnswers) {
        self.answersAttempted++;
        for (NSString *correctAnswer in self.question.correctAnswers) {
            if (self.answers[indexPath.row] == correctAnswer) {
                self.answerStatus++;
                
                if ([self.question.answersNeeded isEqual: @(1)]) {
                    [self gotTheRightAnswer:correctAnswer];
                }else if ([self.question.answersNeeded isEqual: @(2)]) {
                    if ([self.question.answersNeeded isEqual: @(2)] && self.answerStatus == 2) {
                        [self gotTheRightAnswer:correctAnswer];
                    }
                }
                
            }
        }
        if (self.answerStatus == 0) {
            [self gotItWrong:self.answers[indexPath.row]];
        }
    }
    
    if (indexPath.section == TableViewSectionQuit) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) answersAttemped:(NSNumber*)@(self.totalAnswersGiven) wrongAsnwers:self.wrongAnswersChosen answerNumber:self.answerNumberArray];
        [[ScoreController sharedInstance]save];
        
        ScoreViewController *scoreViewController = (ScoreViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ScoreViewController"];
        [self.navigationController pushViewController:scoreViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotTheRightAnswer:(NSString *)buttonTitle {
    
    self.answerStatus = 0;
    self.answersAttempted = 0;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.rightAnswer.text = [NSString stringWithFormat:@"%@ \n Is the correct answer",buttonTitle];
        CAKeyframeAnimation *keyFramAnimation = [CAKeyframeAnimation animation];
        keyFramAnimation.keyPath = @"position.y";
        keyFramAnimation.values = @[@140, @160, @140, @160, @140, @120];
        keyFramAnimation.keyTimes = @[@0, @(1/6.0), @(3/6.0), @(5/6.0), @1, @(7/6.0)];
        keyFramAnimation.duration = 2;
        keyFramAnimation.additive = NO;
        [self.rightAnswer.layer addAnimation:keyFramAnimation forKey:@"nod"];
    });
    self.currentScores++;
    self.totalAnswersGiven++;
    
    if (self.quizType == 1) {
        [self updateWithQuestion:self.controller.questions[arc4random_uniform(10)]];
    }else if (self.quizType == 2) {
        [self updateWithQuestion:self.controller.questions[arc4random_uniform(100)]];
    }
    
    self.answers = self.question.randomSetOfAnswers;

    [self.tableView reloadData];
    [self updateTitle];

}

-(void)gotItWrong:(NSString *)buttonTitle {
    
    self.answerStatus = 0;
    self.answersAttempted = 0;
    self.totalAnswersGiven++;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.wrongAnswer.text = [NSString stringWithFormat:@"The answer is NOT %@",buttonTitle];
        CAKeyframeAnimation *keyFramAnimation = [CAKeyframeAnimation animation];
        keyFramAnimation.keyPath = @"position.y";
        keyFramAnimation.values = @[@140, @160, @140, @160, @140, @120];
        keyFramAnimation.keyTimes = @[@0, @(1/6.0), @(3/6.0), @(5/6.0), @1, @(7/6.0)];
        keyFramAnimation.duration = 2;
        keyFramAnimation.additive = NO;
        [self.wrongAnswer.layer addAnimation:keyFramAnimation forKey:@"shake"];
        [self.wrongAnswersChosen addObject:[NSString stringWithFormat:@"%@",self.question.title]];
        [self.answerNumberArray addObject:[NSString stringWithFormat:@"%@",self.question.questionNumber]];
    });
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You got it wrong" message:@"Would you like to see the answer?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        AnswerStudyViewController *answerStudyViewController = (AnswerStudyViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AnswerStudyViewController"];
        answerStudyViewController.question = self.question;
        
        [self.navigationController pushViewController:answerStudyViewController animated:YES];
        if (self.quizType == 1) {
            [self updateWithQuestion:self.controller.questions[arc4random_uniform(10)]];
        }else if (self.quizType == 2) {
            [self updateWithQuestion:self.controller.questions[arc4random_uniform(100)]];
        }
        
        self.answers = self.question.randomSetOfAnswers;
        [self.tableView reloadData];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Not now" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        if (self.quizType == 1) {
            [self updateWithQuestion:self.controller.questions[arc4random_uniform(10)]];
        }else if (self.quizType == 2) {
            [self updateWithQuestion:self.controller.questions[arc4random_uniform(100)]];
        }
        
        self.answers = self.question.randomSetOfAnswers;

        [self.tableView reloadData];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    [self updateTitle];
    
}

-(void)updateWithQuestion:(Question *)question {
    
    self.question = question;
    
    // when you move the question to header view, you set the label for that header view here to the question's .title
}


@end
