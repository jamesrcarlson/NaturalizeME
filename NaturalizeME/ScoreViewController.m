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
    
}
-(void)updateScore {
    self.scoreHolder = [ScoreController sharedInstance].latestQuizScore;
    self.totalAnswerHolder = [ScoreController sharedInstance].answersCompleted;
    float score = ((float)self.scoreHolder.integerValue/(float)self.totalAnswerHolder.integerValue) *100;
    
    self.numberOfQuestionsRight = [NSString stringWithFormat:@"%@ out of %@", self.scoreHolder, self.totalAnswerHolder];
    self.percentage = [NSString stringWithFormat:@"%ld %%", (long)score];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scoreView" forIndexPath:indexPath];
    cell.scoreViewLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];//consider using dynamic sizing for font
    cell.scoreViewLabel.textAlignment = NSTextAlignmentCenter;
    cell.scoreViewLabel.numberOfLines = 0;
    if (indexPath.row == 0) {
        cell.scoreViewLabel.text = @"You obtained a score of";
        cell.scoreViewLabel.font = [UIFont boldSystemFontOfSize:30];
        cell.backgroundColor = [UIColor blueColor];
        cell.scoreViewLabel.textColor = [UIColor whiteColor];
    }
    if (indexPath.row == 1) {
        cell.scoreViewLabel.text = self.numberOfQuestionsRight;
    }
    if (indexPath.row == 2) {
        cell.scoreViewLabel.text = @"Your percentage is";
    }
    if (indexPath.row == 3) {
        cell.scoreViewLabel.text = self.percentage;
    }
    if (indexPath.row == 4) {
        cell.scoreViewLabel.text = @"Okay";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        
        WelcomeViewController *welcomViewController = (WelcomeViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
        [self.navigationController pushViewController:welcomViewController animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
