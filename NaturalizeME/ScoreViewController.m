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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.frame.size.height / 2.5;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"You obtained a score of";
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.frame = header.frame;//CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2.5);
    header.textLabel.font = [UIFont boldSystemFontOfSize:40];
    header.textLabel.backgroundColor = [UIColor lightGrayColor];
    //    header.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questionCell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];//consider using dynamic sizing for font
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.numberOfLines = 0;
    if (indexPath.row == 0) {
        cell.textLabel.text = self.numberOfQuestionsRight;
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"Your percentage is";
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = self.percentage;
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"Okay";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        
        WelcomeViewController *welcomViewController = (WelcomeViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
        [self.navigationController pushViewController:welcomViewController animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
