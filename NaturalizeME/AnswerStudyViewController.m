//
//  AnswerStudyViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "AnswerStudyViewController.h"
#import "StudyController.h"
#import "TextLabelTableViewCell.h"

//static CGFloat margin = 15;

@interface AnswerStudyViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation AnswerStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];


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


//-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
//    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
//    footer.textLabel.frame = footer.frame;//CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2.5);
//    footer.textLabel.font = [UIFont boldSystemFontOfSize:20];
//    footer.textLabel.numberOfLines = 0;
//    //    header.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    footer.textLabel.textAlignment = NSTextAlignmentCenter;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [UITableViewHeaderFooterView new];
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    if (section == 0) {
        header.textLabel.text = [NSString stringWithFormat:@"Question #%@",[StudyController questionNumberAtIndex:self.questionIndex]];
    }
    if (section == 1) {
        header.textLabel.text = @"The possible Answers";
    }
    if (section == 2) {
        header.textLabel.text = @"Brief Explanation";
    }
    return header.textLabel.text;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answerCell"];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.answerStudyLabel.numberOfLines = 0;
    if (indexPath.section == 0) {
        cell.answerStudyLabel.text = [StudyController questionTitleAtIndex:self.questionIndex];
        cell.answerStudyLabel.font = [UIFont boldSystemFontOfSize:30];
        cell.backgroundColor = [UIColor blueColor];
        cell.answerStudyLabel.textColor = [UIColor whiteColor];
    }
    if (indexPath.section == 1) {
        cell.answerStudyLabel.text = [StudyController answerAtIndex:indexPath.row inQuestionAtIndex:self.questionIndex];
    }
    if (indexPath.section == 2) {
        cell.answerStudyLabel.textAlignment = NSTextAlignmentLeft;
        cell.answerStudyLabel.text = [StudyController explanationAtIndex:self.questionIndex];
        cell.answerStudyLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 200;
        }else {
            return 200;
        }
        
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
        NSString *cellText = [StudyController explanationAtIndex:self.questionIndex];
        UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:22.0];
        
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:cellText
                                                                             attributes:@{NSFontAttributeName: cellFont}];
        
        CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        return rect.size.height + 20;
        } else {
            return 200;
        }

    }
    else {
        return 50;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return [StudyController answerCountAtIndex:self.questionIndex];
    }
    if (section == 2) {
        return 1;
    }else {
        return 0;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
