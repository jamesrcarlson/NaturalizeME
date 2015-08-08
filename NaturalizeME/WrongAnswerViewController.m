//
//  WrongAnswerViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/31/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "WrongAnswerViewController.h"
#import "AnswerStudyViewController.h"
#import "ScoreController.h"
#import "TextLabelTableViewCell.h"

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
    [super viewDidAppear:YES];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.scores.wrongAnswer.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellText = self.scores.wrongAnswer[indexPath.row];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:25.0];
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:cellText
                                                                         attributes:@{NSFontAttributeName: cellFont}];
    
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size.height + 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wrongAnswer"];
    cell.wrongAnswerLabel.text = [NSString stringWithFormat:@"Question number %@ \n%@",self.scores.answerNumber[indexPath.row],self.scores.wrongAnswer[indexPath.row]];
    cell.wrongAnswerLabel.numberOfLines = 0;
    cell.wrongAnswerLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)indexPath {
    if ([segue.identifier isEqualToString:@"wrongAnswerStudy"]) {
        
        AnswerStudyViewController *answerViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSInteger quesitonNumber = [self.scores.answerNumber[indexPath.row]integerValue]-1;
        
        answerViewController.questionIndex = quesitonNumber;
    }
}

@end
