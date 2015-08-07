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

@end

@implementation AnswerStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.frame.size.height / 2.5;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [Study questionTitleAtIndex:self.questionIndex];
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.frame = header.frame;//CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2.5);
    header.textLabel.font = [UIFont boldSystemFontOfSize:20];
    header.textLabel.numberOfLines = 0;
    header.textLabel.backgroundColor = [UIColor lightGrayColor];
    //    header.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    header.textLabel.textAlignment = NSTextAlignmentCenter;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [Study explanationAtIndex:self.questionIndex];
}

//-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
//    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
//    footer.textLabel.frame = footer.frame;//CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2.5);
//    footer.textLabel.font = [UIFont boldSystemFontOfSize:20];
//    footer.textLabel.numberOfLines = 0;
//    //    header.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    footer.textLabel.textAlignment = NSTextAlignmentCenter;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
        NSString *cellText = [Study explanationAtIndex:self.questionIndex];
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:cellText
                                                                             attributes:@{NSFontAttributeName: cellFont}];
    
        CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        return rect.size.height + 20;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answerCell"];
    cell.textLabel.text = [Study answerAtIndex:indexPath.row inQuestionAtIndex:self.questionIndex];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Study answerCountAtIndex:self.questionIndex];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSString *cellText = [Study answerAtIndex:indexPath.row inQuestionAtIndex:self.questionIndex];
//    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
//    
//    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:cellText
//                                                                         attributes:@{NSFontAttributeName: cellFont}];
//    
//    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX)
//                                               options:NSStringDrawingUsesLineFragmentOrigin
//                                               context:nil];
//    return rect.size.height + 20;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
