//
//  SecondViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "StudyViewController.h"
#import "AnswerStudyViewController.h"
#import "QuestionController.h"

@interface StudyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) QuestionController *questionController;

@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QuestionController *questionController = [QuestionController new];
    
    self.questionController = questionController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.view reloadInputViews];
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    AnswerStudyViewController *answerStudyViewController =[AnswerStudyViewController new];
//    answerStudyViewController.questionIndex = indexPath.row; //tableView.indexPathForSelectedRow.row;
//    
//}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 3;
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questionController.questions.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    Study *answer = [StudyController sharedInstance].questions[indexPath.row];
    
    Question *question = self.questionController.questions[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questions"];
    cell.textLabel.numberOfLines = 0;

    cell.textLabel.text = [NSString stringWithFormat:@"Question # %@ \n%@",@(indexPath.row +1),question.title];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    AnswerStudyViewController *answerViewController = segue.destinationViewController;
    
    answerViewController.question = self.questionController.questions[indexPath.row];
    
}


@end
