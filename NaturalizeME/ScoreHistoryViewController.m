//
//  ScoreHistoryViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "ScoreHistoryViewController.h"
#import "ScoreController.h"
#import "Scores.h"

@interface ScoreHistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ScoreHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ScoreController sharedInstance].scores.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Scores *scores = [ScoreController sharedInstance].scores[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scoreCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)scores.quizScore];
    return cell;
}



@end
