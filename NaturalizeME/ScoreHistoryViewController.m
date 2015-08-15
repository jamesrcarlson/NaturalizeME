//
//  ScoreHistoryViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "ScoreHistoryViewController.h"
#import "ScoreController.h"
#import "WrongAnswerViewController.h"
#import "Scores.h"

@interface ScoreHistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ScoreHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Score History";
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;//consider adding later. 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ScoreController sharedInstance].scores.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scores"];
    
    Scores *scores = [ScoreController sharedInstance].scores[indexPath.row];
    if (!scores) {
        cell.textLabel.text = @"You have no quiz scores";
    }else {
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    cell.textLabel.text = [NSString stringWithFormat:@"Score # %@ \nWith a score of %@ out of %@",@(indexPath.row +1),scores.quizScore, scores.answersCompleted];
    }
    return cell;
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    WrongAnswerViewController *wronganswerViewController = segue.destinationViewController;
    Scores *scores = [ScoreController sharedInstance].scores[indexPath.row];
    wronganswerViewController.scores = scores;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Scores *scores = [ScoreController sharedInstance].scores[indexPath.row];
        [[ScoreController sharedInstance]removeScore:scores];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}



@end
