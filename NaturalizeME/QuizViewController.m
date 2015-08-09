//
//  QuizViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "QuizViewController.h"
#import "TextLabelTableViewCell.h"
#import "StudyController.h"
#import "ScoreViewController.h"
#import "ScoreController.h"
#import "SetupController.h"

//static int questionIndex;

//static NSInteger currentScores = 0;

static NSString * const showScoreSegue = @"showScores";

@interface QuizViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong)NSMutableArray *holderArray;

@property (nonatomic, assign)NSInteger holderArrayNumber;

@property (nonatomic, assign)NSInteger questionNumber;

@property (assign)NSInteger currentScores;
@property (assign)NSInteger totalAnswersGiven;

@property (strong)UILabel *rightAnswer;
@property (strong)UILabel *wrongAnswer;
@property (strong)NSMutableArray *wrongAnswersChosen;
@property (strong)NSMutableArray *answerNumberArray;

@property (strong, nonatomic) NSString *questionTitle;
@property (strong, nonatomic) NSString *answerOne;
@property (strong, nonatomic) NSString *answerTwo;
@property (strong, nonatomic) NSString *answerThree;
@property (strong, nonatomic) NSString *answerFour;


@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wrongAnswersChosen = [NSMutableArray new];
    self.answerNumberArray = [NSMutableArray new];
    
    self.holderArray = [[NSMutableArray alloc]initWithArray:[self questionIndexNumbers]];
    
    [self setQuestionAndAnswers];
    self.currentScores = 0;
    self.totalAnswersGiven = 0;
    
    self.rightAnswer = [[UILabel alloc]initWithFrame:CGRectMake(20, -100, self.view.frame.size.width - 40, 75)];
    self.rightAnswer.backgroundColor = [UIColor greenColor];
    self.rightAnswer.textColor = [UIColor blackColor];
    self.rightAnswer.numberOfLines = 0;
    [self.view addSubview:self.rightAnswer];
    
    self.wrongAnswer = [[UILabel alloc]initWithFrame:CGRectMake(20, -100, self.view.frame.size.width - 40, 75)];
    self.wrongAnswer.backgroundColor = [UIColor redColor];
    self.wrongAnswer.textColor = [UIColor blackColor];
    self.wrongAnswer.numberOfLines = 0;
    [self.view addSubview:self.wrongAnswer];
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 250;
    }else {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questionCell" forIndexPath:indexPath];
    cell.myLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];//consider using dynamic sizing for font
    cell.myLabel.textAlignment = NSTextAlignmentCenter;
    cell.myLabel.numberOfLines = 0;
    if (indexPath.row == 0) {
        cell.myLabel.text = self.questionTitle;
        cell.myLabel.font = [UIFont boldSystemFontOfSize:30];
        cell.backgroundColor = [UIColor blueColor];
        cell.myLabel.textColor = [UIColor whiteColor];

    }
    if (indexPath.row == 1) {
        cell.myLabel.text = self.answerOne;
    }
    if (indexPath.row == 2) {
        cell.myLabel.text = self.answerTwo;
    }
    if (indexPath.row == 3) {
        cell.myLabel.text = self.answerThree;
    }
    if (indexPath.row == 4) {
        cell.myLabel.text = self.answerFour;
    }
    if (indexPath.row == 5) {
        cell.myLabel.text = @"Quit and see scores";
        cell.myLabel.backgroundColor = [UIColor lightGrayColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        int answerStatus = 0;
        
        if ([StudyController answerCountAtIndex:self.questionNumber] != 0) {
            
            
            for (int i = 0; i < [StudyController answerCountAtIndex:self.questionNumber]; i++) {
                if (self.answerOne == [StudyController answerAtIndex:i inQuestionAtIndex:self.questionNumber]) {
                    
                    [self gotTheRightAnswer:self.answerOne];
                    answerStatus = 1;
                }
            };
        }
        if (answerStatus == 0) {
            [self gotItWrong:self.answerOne];
        };
        if (self.holderArray.count == 0) {
            self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) answersAttemped:(NSNumber*)@(self.totalAnswersGiven) wrongAsnwers:self.wrongAnswersChosen answerNumber:self.answerNumberArray];
            [[ScoreController sharedInstance]save];
            ScoreViewController *scoreViewController = (ScoreViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ScoreViewController"];
            [self.navigationController pushViewController:scoreViewController animated:YES];
        }else {
            
            [self setQuestionAndAnswers];
            [tableView reloadData];
        }
    }
    if (indexPath.row == 2) {
        int answerStatus = 0;
        
        if ([StudyController answerCountAtIndex:self.questionNumber] != 0) {
            for (int i = 0; i < [StudyController answerCountAtIndex:self.questionNumber]; i++) {
                if (self.answerTwo == [StudyController answerAtIndex:i inQuestionAtIndex:self.questionNumber]) {
                    
                    [self gotTheRightAnswer:self.answerTwo];
                    answerStatus = 1;
                }
            };
        }
        
        if (answerStatus == 0) {
            [self gotItWrong:self.answerTwo];
        };
        
        
        if (self.holderArray.count == 0) {
            [NSThread sleepForTimeInterval:2];
            self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) answersAttemped:(NSNumber*)@(self.totalAnswersGiven) wrongAsnwers:self.wrongAnswersChosen answerNumber:self.answerNumberArray];
            [[ScoreController sharedInstance]save];
            ScoreViewController *scoreViewController = (ScoreViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ScoreViewController"];
            [self.navigationController pushViewController:scoreViewController animated:YES];
        }else {
            
            [self setQuestionAndAnswers];
            [tableView reloadData];

        }
    }
    if (indexPath.row == 3) {
        int answerStatus = 0;
        if ([StudyController answerCountAtIndex:self.questionNumber] != 0) {
            for (int i = 0; i < [StudyController answerCountAtIndex:self.questionNumber]; i++) {
                if (self.answerThree == [StudyController answerAtIndex:i inQuestionAtIndex:self.questionNumber]) {
                    
                    [self gotTheRightAnswer:self.answerThree];
                    answerStatus = 1;
                }
            };
        }
        if (answerStatus == 0) {
            [self gotItWrong:self.answerThree];
        };
        
        if (self.holderArray.count == 0) {
            self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) answersAttemped:(NSNumber*)@(self.totalAnswersGiven) wrongAsnwers:self.wrongAnswersChosen answerNumber:self.answerNumberArray];
            [[ScoreController sharedInstance]save];
            ScoreViewController *scoreViewController = (ScoreViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ScoreViewController"];
            [self.navigationController pushViewController:scoreViewController animated:YES];
        }else {
            [self setQuestionAndAnswers];
            [tableView reloadData];

        }

    }
    if (indexPath.row == 4) {
        int answerStatus = 0;
        if ([StudyController answerCountAtIndex:self.questionNumber] != 0) {
            for (int i = 0; i < [StudyController answerCountAtIndex:self.questionNumber]; i++) {
                if (self.answerFour == [StudyController answerAtIndex:i inQuestionAtIndex:self.questionNumber]) {
                    
                    [self gotTheRightAnswer:self.answerFour];
                    answerStatus = 1;
                }
            };
        }
        if (answerStatus == 0) {
            [self gotItWrong:self.answerFour];
        };
        
        
        if (self.holderArray.count == 0) {
            self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) answersAttemped:(NSNumber*)@(self.totalAnswersGiven) wrongAsnwers:self.wrongAnswersChosen answerNumber:self.answerNumberArray];
            [[ScoreController sharedInstance]save];
            ScoreViewController *scoreViewController = (ScoreViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ScoreViewController"];
            [self.navigationController pushViewController:scoreViewController animated:YES];
        }else {
            
            [self setQuestionAndAnswers];
            [tableView reloadData];

        }
    }
    if (indexPath.row == 5) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) answersAttemped:(NSNumber*)@(self.totalAnswersGiven) wrongAsnwers:self.wrongAnswersChosen answerNumber:self.answerNumberArray];
        [[ScoreController sharedInstance]save];
        
        ScoreViewController *scoreViewController = (ScoreViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ScoreViewController"];
        [self.navigationController pushViewController:scoreViewController animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)gotTheRightAnswer:(NSString *)buttonTitle {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.rightAnswer.text = [NSString stringWithFormat:@"%@ \n Is the correct answer",buttonTitle];
        CAKeyframeAnimation *keyFramAnimation = [CAKeyframeAnimation animation];
        keyFramAnimation.keyPath = @"position.y";
        keyFramAnimation.values = @[@140, @160, @140, @160, @140, @120];
        keyFramAnimation.keyTimes = @[@0, @(1/6.0), @(3/6.0), @(5/6.0), @1, @(7/6.0)];
        keyFramAnimation.duration = 2;
        keyFramAnimation.additive = NO;
        [self.rightAnswer.layer addAnimation:keyFramAnimation forKey:@"nod"];
    });
    self.currentScores++;
    self.totalAnswersGiven++;
}

-(void)gotItWrong:(NSString *)buttonTitle {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.wrongAnswer.text = [NSString stringWithFormat:@"The answer is NOT %@",buttonTitle];
        CAKeyframeAnimation *keyFramAnimation = [CAKeyframeAnimation animation];
        keyFramAnimation.keyPath = @"position.y";
        keyFramAnimation.values = @[@140, @160, @140, @160, @140, @120];
        keyFramAnimation.keyTimes = @[@0, @(1/6.0), @(3/6.0), @(5/6.0), @1, @(7/6.0)];
        keyFramAnimation.duration = 2;
        keyFramAnimation.additive = NO;
        [self.wrongAnswer.layer addAnimation:keyFramAnimation forKey:@"shake"];
        [self.wrongAnswersChosen addObject:[NSString stringWithFormat:@"%@",self.questionTitle]];
        [self.answerNumberArray addObject:[NSString stringWithFormat:@"%@",[StudyController questionNumberAtIndex:self.questionNumber]]];
    });
    self.totalAnswersGiven++;
    
}

-(void)setQuestionAndAnswers {
    
    self.questionTitle = [self getRandomQuestions];
    
    [self getAnswers];
    [self.view reloadInputViews];
    
}


-(NSString *)getRandomQuestions {
    
    
    if (self.holderArray.count  > 0) {
        self.holderArrayNumber = arc4random_uniform((int)self.holderArray.count);
        self.questionNumber = [self.holderArray[self.holderArrayNumber]integerValue];
        NSString *randomQuestion = [StudyController questionTitleAtIndex:self.questionNumber];
        
        return randomQuestion;
        
    } else {
        NSLog(@"no more questions");
        return @"no more questions";
    }
}

-(void)getAnswers {
    
    NSMutableArray *answerNumbers = [[NSMutableArray alloc]initWithObjects:@0, @1, @2, @3, @4, nil];
    
    int answerArrayNumber = arc4random_uniform((int)answerNumbers.count);
    NSInteger answerNumber = [answerNumbers[answerArrayNumber]integerValue];
    NSString *answerOne = [StudyController BadAnswerAtIndex:answerNumber inQuestionAtIndex:self.questionNumber];
    [answerNumbers removeObjectAtIndex:answerArrayNumber];
    
    int answerArrayNumberTwo = arc4random_uniform((int)answerNumbers.count);
    NSInteger answerTwoNumber = [answerNumbers[answerArrayNumberTwo]integerValue];
    NSString *answerTwo = [StudyController BadAnswerAtIndex:answerTwoNumber inQuestionAtIndex:self.questionNumber];
    [answerNumbers removeObjectAtIndex:answerArrayNumberTwo];
    
    int answerArrayNumberThree = arc4random_uniform((int)answerNumbers.count);
    NSInteger answerThreeNumber = [answerNumbers[answerArrayNumberThree]integerValue];
    NSString *answerThree  = [StudyController BadAnswerAtIndex:answerThreeNumber inQuestionAtIndex:self.questionNumber];
    [answerNumbers removeObjectAtIndex:answerArrayNumberThree];
    
    int answerFourNumber = arc4random_uniform((int)[StudyController answerCountAtIndex:self.questionNumber]);
    NSString *answerFour  = [StudyController answerAtIndex:answerFourNumber inQuestionAtIndex:self.questionNumber];
        
   
    NSMutableArray *completeAnswerList = [[NSMutableArray alloc]initWithObjects:answerOne, answerTwo, answerThree, answerFour, nil];
    
        
    int buttonOneTitle = arc4random_uniform((int)completeAnswerList.count);
    self.answerOne = completeAnswerList[buttonOneTitle];
    [completeAnswerList removeObjectAtIndex:buttonOneTitle];
    
    int buttonTwoTitle = arc4random_uniform((int)completeAnswerList.count);
    self.answerTwo = completeAnswerList[buttonTwoTitle];
    [completeAnswerList removeObjectAtIndex:buttonTwoTitle];
    
    int buttonThreeTitle = arc4random_uniform((int)completeAnswerList.count);
    self.answerThree = completeAnswerList[buttonThreeTitle];
    [completeAnswerList removeObjectAtIndex:buttonThreeTitle];
    
    int buttonFourTitle = arc4random_uniform((int)completeAnswerList.count);
    self.answerFour = completeAnswerList[buttonFourTitle];
    [completeAnswerList removeObjectAtIndex:buttonFourTitle];

        
    
    [self.holderArray removeObjectAtIndex:self.holderArrayNumber];
    
    


}
-(NSArray *)wrongAnswerArray {
    NSArray *myNewWrongAnswerArray = [[NSArray alloc]initWithArray:self.wrongAnswersChosen];
    return myNewWrongAnswerArray;
}


- (NSArray *)questionIndexNumbers {
    return @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21,@22,@23,@24,@25,@26,@27,@28,@29,@30,@31,@32,@33,@34,@35,@36,@37,@38,@39,@40,@41,@42,@43,@44,@45,@46,@47,@48,@49,@50,@51,@52,@53,@54,@55,@56,@57,@58,@59,@60,@61,@62,@63,@64,@65,@66,@67,@68,@69,@70,@71,@72,@73,@74,@75,@76,@77,@78,@79,@80,@81,@82,@83,@84,@85,@86,@87,@88,@89,@90,@91,@92,@93,@94,@95];//,@96,@97,@98,@99];
    
}


@end
