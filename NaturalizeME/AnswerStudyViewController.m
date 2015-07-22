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
//    self.explanation.autoresizingMask = YES;
    self.explanation.lineBreakMode = NO;
    
//    self.title = [Study questionNumberAtIndex:self.questionIndex];

//    CGFloat topMargin = 45;
    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:scrollView];
    
    
    
//    CGFloat heightForQuestion = [self heightForQuestion:[Study questionTitleAtIndex:self.questionIndex]];
    
//    UILabel *question = [[UILabel alloc] initWithFrame:CGRectMake(margin, topMargin, self.view.frame.size.width - 2 * margin, heightForQuestion)];
    self.question.text = [Study questionTitleAtIndex:self.questionIndex];
    self.explanation.text = [Study explanationAtIndex:self.questionIndex];
    
    self.question.numberOfLines = 0;
    self.explanation.numberOfLines = 0;
    
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    
    [[self explanation]addSubview:scrollview];
//    [scrollView addSubview:question];
    
//    CGFloat top = topMargin + heightForQuestion + margin * 2;
//    
//    NSString *answer = [Study answerAtIndex:0 inQuestionAtIndex:self.questionIndex];
//    
//    if ([Study answerCountAtIndex:self.questionIndex]>=1) {
//        for (int i = 1; i < [Study answerCountAtIndex:self.questionIndex]; i++) {
//            
//            
//            answer = [answer stringByAppendingString:[Study answerAtIndex:i inQuestionAtIndex:self.questionIndex]];
//            //        UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, top,self.view.frame.size.width - 2 * margin, 20)];
//            //        answerLabel.font = [UIFont boldSystemFontOfSize:17];
//            //        self.answerLabel.text = [Study answerAtIndex:i inQuestionAtIndex:self.questionIndex];
//            //        [scrollView addSubview:answerLabel];
//            
//            top += (20 + margin);
//        }
//    }
//    
//    
//    self.answerLabel.text = answer;
//    
//    top += margin;
//    
//    CGFloat heightForExplanation = [self heightForExplanation:[Study explanationAtIndex:self.questionIndex]];
//    
////    UILabel *explanation = [[UILabel alloc]initWithFrame:CGRectMake(margin, top, self.view.frame.size.width - 2 * margin, heightForExplanation)];
//    self.explanation.text = [Study explanationAtIndex:self.questionIndex];
////    [scrollView addSubview:explanation];
//    
//    top += heightForExplanation;
//    
////    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, top + margin);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answers"];
    cell.textLabel.text = [Study answerAtIndex:indexPath.row inQuestionAtIndex:self.questionIndex];
    cell.detailTextLabel.lineBreakMode =YES;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Study answerCountAtIndex:self.questionIndex];
}

//- (CGFloat)heightForQuestion:(NSString *)description {
//    
//    CGRect bounding = [description boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 2 * margin, CGFLOAT_MAX)
//                                                options:NSStringDrawingUsesLineFragmentOrigin
//                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
//                                                context:nil];
//    
//    return bounding.size.height;
//    
//}
//- (CGFloat)heightForExplanation:(NSString *)description {
//    
//    CGRect bounding = [description boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 2 * margin - 40, CGFLOAT_MAX)
//                                                options:NSStringDrawingUsesLineFragmentOrigin
//                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
//                                                context:nil];
//    
//    return bounding.size.height;
//    
//}

@end
