//
//  ScoreViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "ScoreViewController.h"
#import "ScoreController.h"
#import "WelcomeViewController.h"
#import "TextLabelTableViewCell.h"

typedef NS_ENUM(NSUInteger, TableViewSection) {
    TableViewSectionScoreTitle,
    TableViewSectionScoreContent,
    TableViewSectionQuit
};

@interface ScoreViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *numberOfQuestionsRight;

@property (strong, nonatomic) NSString *percentage;

@property (strong)NSNumber *scoreHolder;
@property (strong)NSNumber *totalAnswerHolder;

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateScore];
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)updateScore {
    self.scoreHolder = [ScoreController sharedInstance].latestQuizScore;
    self.totalAnswerHolder = [ScoreController sharedInstance].answersCompleted;
    float score = ((float)self.scoreHolder.integerValue/(float)self.totalAnswerHolder.integerValue) *100;
    self.numberOfQuestionsRight = [NSString stringWithFormat:@"%@ out of %@", self.scoreHolder, self.totalAnswerHolder];
    self.percentage = [NSString stringWithFormat:@"%ld %%", (long)score];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TableViewSection tableViewSection = section;
    
    switch (tableViewSection) {
        case TableViewSectionScoreTitle:
            return 1;
            break;
        case TableViewSectionScoreContent:
            return 3;
            break;
        case TableViewSectionQuit:
            return 1;
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    switch (indexPath.section) {
        case TableViewSectionScoreTitle:
            return 200;
            break;
        case TableViewSectionScoreContent:
            return 50;
            break;
        case TableViewSectionQuit:
            return 50;
            break;
            
        default:
            return 50;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scoreView" forIndexPath:indexPath];
    cell.scoreViewLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];//consider using dynamic sizing for font
    cell.scoreViewLabel.textAlignment = NSTextAlignmentCenter;
    cell.scoreViewLabel.numberOfLines = 0;
    
    if (indexPath.section == TableViewSectionScoreTitle) {
            cell.scoreViewLabel.text = @"You obtained a score of";
            cell.scoreViewLabel.font = [UIFont boldSystemFontOfSize:30];
            cell.backgroundColor = [UIColor blueColor];
            cell.scoreViewLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = NO;
    }
    if (indexPath.section == TableViewSectionScoreContent) {
        if (indexPath.row == 0) {
            cell.scoreViewLabel.text = self.numberOfQuestionsRight;
            cell.selectionStyle = NO;
        }
        if (indexPath.row == 1) {
            cell.scoreViewLabel.text = @"Your percentage is";
            cell.selectionStyle = NO;
        }
        if (indexPath.row == 2) {
            if (self.scoreHolder.integerValue == 0) {
                cell.scoreViewLabel.text = @"0%";
                cell.selectionStyle = NO;
            }else {
                cell.scoreViewLabel.text = self.percentage;
                cell.selectionStyle = NO;
            }
        }
    }
    if (indexPath.section == TableViewSectionQuit) {
        cell.scoreViewLabel.text = @"Okay";
        cell.backgroundColor = [UIColor greenColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == TableViewSectionQuit) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
