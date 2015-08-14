//
//  FirstViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "WelcomeViewController.h"
#import "FastQuizViewController.h"
#import "QuizViewController.h"
#import "StudyViewController.h"
#import "ScoreHistoryViewController.h"
#import "SetupViewController.h"
#import "SetupController.h"
#import "QuestionController.h"

@interface WelcomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger initialSetup = [SetupController sharedInstance].civicsInfo.count;
    if (initialSetup == 0) {
        SetupViewController *setupviewController = (SetupViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SetupViewController"];
        [self.navigationController pushViewController:setupviewController animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.frame.size.height / 2.5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    tableView.sectionHeaderHeight = self.view.frame.size.height / 2.5;
    UIImage *myImage = [UIImage imageNamed:@"flag.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
    imageView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height / 2.5);
    
    return imageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.view.frame.size.height / 9);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainMenu" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:40];//consider using dynamic sizing for font
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Fast Quiz";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"Full Quiz";
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"Study";
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"My Scores";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        FastQuizViewController *fastQuizviewController = (FastQuizViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"FastQuizViewController"];
        [self.navigationController pushViewController:fastQuizviewController animated:YES];

    }
    if (indexPath.row == 1) {
        QuizViewController *quizviewController = (QuizViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"QuizViewController"];
        [self.navigationController pushViewController:quizviewController animated:YES];
    }
    if (indexPath.row == 2) {
        StudyViewController *studyViewController = (StudyViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"StudyViewController"];
        [self.navigationController pushViewController:studyViewController animated:YES];
    }
    if (indexPath.row == 3) {
        ScoreHistoryViewController *scoreHistoryViewController = (ScoreHistoryViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ScoreHistoryViewController"];
        [self.navigationController pushViewController:scoreHistoryViewController animated:YES];
    }
}

@end
