//
//  AnswerStudyViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "AnswerStudyViewController.h"
#import "QuestionController.h"
#import "TextLabelTableViewCell.h"


typedef NS_ENUM(NSUInteger, TableViewSection) {
    TableViewSectionQuestion,
    TableViewSectionAnswers,
    TableViewSectionExplanation,
    TableViewSectionGoBack
};


@interface AnswerStudyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong) QuestionController *controller;

@end

@implementation AnswerStudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.controller = [QuestionController new];
    
}



//-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    header.textLabel.frame = header.frame;//CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2.5);
//    header.textLabel.font = [UIFont boldSystemFontOfSize:20];
//    header.textLabel.numberOfLines = 0;
//    header.textLabel.backgroundColor = [UIColor lightGrayColor];
//    //    header.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    header.textLabel.textAlignment = NSTextAlignmentCenter;
//}


//-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
//    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
//    footer.textLabel.frame = footer.frame;//CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2.5);
//    footer.textLabel.font = [UIFont boldSystemFontOfSize:20];
//    footer.textLabel.numberOfLines = 0;
//    //    header.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    footer.textLabel.textAlignment = NSTextAlignmentCenter;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    UITableViewHeaderFooterView *header = [UITableViewHeaderFooterView new];
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    if (section == TableViewSectionQuestion) {
        header.textLabel.text = @"Your question";
        
    }
    if (section == TableViewSectionAnswers) {
        header.contentView.backgroundColor = [UIColor lightGrayColor];
        header.textLabel.text = @"The correct Answers";
    }
    if (section == TableViewSectionExplanation) {
        header.textLabel.text = @"A brief explanation";
    }
    return header.textLabel.text;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answerCell"];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.myLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    cell.answerStudyLabel.numberOfLines = 0;
    if (indexPath.section == TableViewSectionQuestion) {
        cell.answerStudyLabel.text = self.question.title;
        cell.answerStudyLabel.font = [UIFont boldSystemFontOfSize:30];
        cell.backgroundColor = [UIColor blueColor];
        cell.answerStudyLabel.textColor = [UIColor whiteColor];
    }
    if (indexPath.section == TableViewSectionAnswers) {
//        cell.answerStudyLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
        cell.answerStudyLabel.text = self.question.correctAnswers[indexPath.row];
    }
    if (indexPath.section == TableViewSectionExplanation) {
        cell.answerStudyLabel.textAlignment = NSTextAlignmentLeft;
        cell.answerStudyLabel.text = self.question.explanation;
        cell.answerStudyLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    }
    if (indexPath.section == TableViewSectionGoBack) {
        cell.answerStudyLabel.text = @"Go Back";
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == TableViewSectionGoBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == TableViewSectionQuestion) {
            return 200;
    }
    if (indexPath.section == TableViewSectionAnswers) {
        NSString *cellText = self.question.correctAnswers[indexPath.row];
        UIFont *cellFont = [UIFont fontWithName:@"Arial-BoldItalicMT" size:22.0];
        
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:cellText
                                                                             attributes:@{NSFontAttributeName: cellFont}];
        
        CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        return rect.size.height + 20;
    }
    if (indexPath.section == TableViewSectionExplanation) {
        
        NSString *cellText = self.question.explanation;
        UIFont *cellFont = [UIFont fontWithName:@"Arial-BoldItalicMT" size:22.0];
        
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:cellText
                                                                             attributes:@{NSFontAttributeName: cellFont}];
        
        CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        return rect.size.height + 20;

    }
    else {
        return 50;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TableViewSection tableViewSection = section;
    
    switch (tableViewSection) {
        case TableViewSectionQuestion:
            
            return 1;
            
        case TableViewSectionAnswers:
            
            return self.question.correctAnswers.count;
            
        case TableViewSectionExplanation:
            
            return 1;
            
        case TableViewSectionGoBack:
            
            return 1;
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
