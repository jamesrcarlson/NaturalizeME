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

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (assign) NSInteger currentScores;
@property (assign) NSInteger totalAnswersGiven;

@property (strong) UILabel *rightAnswer; //animated label
@property (strong) UILabel *wrongAnswer; //animated label
@property (strong) NSMutableArray *wrongAnswersChosen;
@property (strong) NSMutableArray *answerNumberArray;


@end

@implementation QuestionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    QuestionController *controller = [QuestionController new];
    
    [self updateWithQuestion:controller.questions[5]];
    
    self.title = [NSString stringWithFormat:@"Question %ld of 100", (long)self.totalAnswersGiven + 1];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TableViewSection tableViewSection = section;
    
    switch (tableViewSection) {
        case TableViewSectionQuestion:
            
            return 1;
        
        case TableViewSectionAnswers:
            
            return self.question.randomSetOfAnswers.count;
            
        case TableViewSectionQuit:
            
            return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewSection tableViewSection = indexPath.section;
    
    switch (tableViewSection) {
        case TableViewSectionQuestion:
            
            return 70;
            
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
    if (indexPath.row == 0) {
        cell.myLabel.text = self.question.title;
        cell.myLabel.font = [UIFont boldSystemFontOfSize:30];
        cell.backgroundColor = [UIColor blueColor];
        cell.myLabel.textColor = [UIColor whiteColor];
        
    }
    
    if (indexPath.section == TableViewSectionAnswers) {
        cell.myLabel.text = self.question.randomSetOfAnswers[indexPath.row];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.myLabel.text = @"Quit and see scores";
            cell.backgroundColor = [UIColor lightGrayColor];
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // check to see if they have the correct set of answers
    
    if (indexPath.section == TableViewSectionAnswers) {
        
        for (NSString *correctAnswer in self.question.correctAnswers) {
            if ([self.question.randomSetOfAnswers[indexPath.row] isEqualToString:correctAnswer] ) {
                [self gotTheRightAnswer:correctAnswer];
            }
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //save and conduct a transition
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotTheRightAnswer:(NSString *)buttonTitle {
    
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
}

-(void)gotItWrong:(NSString *)buttonTitle {
    
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
    self.totalAnswersGiven++;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You got it wrong" message:@"Would you like to see the answer?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        AnswerStudyViewController *answerStudyViewController = (AnswerStudyViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AnswerStudyViewController"];
        [self.navigationController pushViewController:answerStudyViewController animated:YES];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Not now" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

        [self.tableView reloadData];
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)updateWithQuestion:(Question *)question {
    
    self.question = question;
    
    
    // when you move the question to header view, you set the label for that header view here to the question's .title
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    AnswerStudyViewController *answerViewController = segue.destinationViewController;
    
    answerViewController.questionIndex = self.question.questionNumber;
    
}
@end
