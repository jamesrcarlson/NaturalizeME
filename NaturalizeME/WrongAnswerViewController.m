//
//  WrongAnswerViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "WrongAnswerViewController.h"

@interface WrongAnswerViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WrongAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    self.title = @"Questions answered wrong";
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.scores.wrongAnswer.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wrongAnswer"];
    cell.textLabel.text = self.scores.wrongAnswer[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

@end
