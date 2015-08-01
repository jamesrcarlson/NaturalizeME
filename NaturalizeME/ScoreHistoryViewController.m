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

@interface ScoreHistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ScoreHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

//-(void)viewWillAppear:(BOOL)animated {
//    [self.tableView reloadData];
//}

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
    cell.textLabel.text = [NSString stringWithFormat:@"%@, on %@",scores.quizScore, scores.timestamp];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",[ScoreController sharedInstance].practiceScores[indexPath.row]];
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    WrongAnswerViewController *wronganswerViewController = segue.destinationViewController;
    Scores *scores = [ScoreController sharedInstance].scores[indexPath.row];
    wronganswerViewController.scores = scores;
}



@end
