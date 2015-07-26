//
//  AnswerStudyViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "AnswerStudyViewController.h"
#import "Study.h"

//static CGFloat margin = 15;

@interface AnswerStudyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *question;

@property (strong, nonatomic) IBOutlet UILabel *explanation;

//@property (strong, nonatomic) IBOutlet UILabel *answerLabel;

@end

@implementation AnswerStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.explanation.lineBreakMode = NO;
    

    self.question.text = [Study questionTitleAtIndex:self.questionIndex];
    self.explanation.text = [Study explanationAtIndex:self.questionIndex];
    
    self.question.numberOfLines = 0;
    self.explanation.numberOfLines = 0;
    
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    
//    [[self explanation]addSubview:scrollview];
    [self.explanation addSubview:scrollview];

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answers"];
    cell.textLabel.text = [Study answerAtIndex:indexPath.row inQuestionAtIndex:self.questionIndex];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
//    [cell.textLabel sizeToFit];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Study answerCountAtIndex:self.questionIndex];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellText = [Study answerAtIndex:indexPath.row inQuestionAtIndex:self.questionIndex];
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
