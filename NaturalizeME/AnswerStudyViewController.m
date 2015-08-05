//
//  AnswerStudyViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "AnswerStudyViewController.h"
#import "AnswersController.h"

//static CGFloat margin = 15;

@interface AnswerStudyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *question;

@property (strong, nonatomic) IBOutlet UITextView *explanation;


//@property (strong, nonatomic) IBOutlet UILabel *answerLabel;

@end

@implementation AnswerStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.question.text = [AnswersController questionTitleAtIndex:self.questionIndex];
    self.explanation.text = [AnswersController explanationAtIndex:self.questionIndex];
    
    self.question.numberOfLines = 0;
    self.explanation.scrollEnabled = YES;

}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answers"];
    cell.textLabel.text = [AnswersController answerAtIndex:indexPath.row inQuestionAtIndex:self.questionIndex];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [AnswersController answerCountAtIndex:self.questionIndex];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellText = [AnswersController answerAtIndex:indexPath.row inQuestionAtIndex:self.questionIndex];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:cellText
                                                                         attributes:@{NSFontAttributeName: cellFont}];
    
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size.height + 20;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
