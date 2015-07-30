//
//  QuizViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "QuizViewController.h"
#import "Study.h"
#import "ScoreViewController.h"
#import "ScoreController.h"

//static int questionIndex;

//static NSInteger currentScores = 0;

@interface QuizViewController ()

@property (strong, nonatomic) IBOutlet UILabel *questionTitle;

@property (strong, nonatomic) IBOutlet UIButton *answerOne;

@property (strong, nonatomic) IBOutlet UIButton *answerTwo;

@property (strong, nonatomic) IBOutlet UIButton *answerThree;

@property (strong, nonatomic) IBOutlet UIButton *answerFour;

@property (nonatomic, strong)NSMutableArray *holderArray;

@property (nonatomic, assign)NSInteger questionNumber;

@property (assign)NSInteger currentScores;



@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.answerOne.titleLabel.numberOfLines = 0;
    self.answerTwo.titleLabel.numberOfLines = 0;
    self.answerThree.titleLabel.numberOfLines = 0;
    self.answerFour.titleLabel.numberOfLines = 0;
    
    self.holderArray = [NSMutableArray new];
    [self.holderArray addObjectsFromArray:[self questionIndexNumbers]];
    
    [self setQuestionAndAnswers];
    self.currentScores = 0;
        
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectAnswerOne:(id)sender {
    
    int answerStatus = 0;
    
    if ([Study answerCountAtIndex:self.questionNumber] != 0) {
        
        
        for (int n = 0; n < [Study answerCountAtIndex:self.questionNumber]-1; n++) {
            if (self.answerOne.titleLabel.text == [Study answerAtIndex:n inQuestionAtIndex:self.questionNumber]) {
                self.currentScores++;
                
                [self gotTheRightAnswer:self.answerOne.titleLabel.text];
                answerStatus = 1;
            }
        };
    }
    if (answerStatus == 0) {
        [self gotItWrong:self.answerOne.titleLabel.text];
    };
    
    [NSThread sleepForTimeInterval:2.0];

    
    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores)];
        ScoreViewController *scoreViewController =[ScoreViewController new];
        [self.navigationController pushViewController:scoreViewController animated:YES];
    } else {
        [self setQuestionAndAnswers];
    }
    
}

- (IBAction)selectAnswerTwo:(id)sender {
    
    if ([Study answerCountAtIndex:self.questionNumber] != 0) {
        for (int n = 0; n < [Study answerCountAtIndex:self.questionNumber]-1; n++) {
            if (self.answerTwo.titleLabel.text == [Study answerAtIndex:n inQuestionAtIndex:self.questionNumber]) {
                self.currentScores++;
                
                [self gotTheRightAnswer:self.answerTwo.titleLabel.text];
            }
        };
    }
    
    [NSThread sleepForTimeInterval:2.0];
    
    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores)];
        ScoreViewController *scoreViewController =[ScoreViewController new];
        [self.navigationController pushViewController:scoreViewController animated:YES];
    } else {
        [self setQuestionAndAnswers];
    }
    
}


- (IBAction)selectAnswerThree:(id)sender {
    
    if ([Study answerCountAtIndex:self.questionNumber] != 0) {
        for (int n = 0; n < [Study answerCountAtIndex:self.questionNumber]-1; n++) {
            if (self.answerThree.titleLabel.text == [Study answerAtIndex:n inQuestionAtIndex:self.questionNumber]) {
                self.currentScores++;
                
                [self gotTheRightAnswer:self.answerThree.titleLabel.text];
            }
        };
    }
    
    [NSThread sleepForTimeInterval:2.0];

    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores)];
        ScoreViewController *scoreViewController =[ScoreViewController new];
        [self.navigationController pushViewController:scoreViewController animated:YES];
    } else {
        [self setQuestionAndAnswers];
    }
    
}

- (IBAction)selectAnswerFour:(id)sender {
    
    if ([Study answerCountAtIndex:self.questionNumber] != 0) {
        for (int n = 0; n < [Study answerCountAtIndex:self.questionNumber]-1; n++) {
            if (self.answerFour.titleLabel.text == [Study answerAtIndex:n inQuestionAtIndex:self.questionNumber]) {
                self.currentScores++;
                
                [self gotTheRightAnswer:self.answerFour.titleLabel.text];
            }
        };
    }
    
    [NSThread sleepForTimeInterval:2.0];

    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores)];
        ScoreViewController *scoreViewController =[ScoreViewController new];
        [self.navigationController pushViewController:scoreViewController animated:YES];
    } else {
        [self setQuestionAndAnswers];
    }
    
}

-(void)gotTheRightAnswer:(NSString *)buttonTitle {
    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *answerRight = [[UILabel alloc]initWithFrame:CGRectMake(75, 100, 200, 75)];
        answerRight.backgroundColor = [UIColor greenColor];
        answerRight.text = buttonTitle;
        answerRight.textColor = [UIColor blackColor];
        answerRight.numberOfLines = 0;
        [self.view addSubview:answerRight];
        CAKeyframeAnimation *keyFramAnimation = [CAKeyframeAnimation animation];
        keyFramAnimation.keyPath = @"position.y";
        keyFramAnimation.values = @[@0, @(-20), @20, @(-20), @20, @0];
        keyFramAnimation.keyTimes = @[@0, @(1/6.0), @(3/6.0), @(5/6.0), @1, @(7/6.0)];
        keyFramAnimation.duration = 2;
        keyFramAnimation.additive = YES;
        [answerRight.layer addAnimation:keyFramAnimation forKey:@"nod"];
        [NSThread sleepForTimeInterval:2];
        [answerRight removeFromSuperview];
    });
    
}

-(void)gotItWrong:(NSString *)buttonTitle {
    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *wrongAnswer = [[UILabel alloc]initWithFrame:CGRectMake(75, 100, 200, 75)];
        wrongAnswer.backgroundColor = [UIColor redColor];
        wrongAnswer.text = buttonTitle;
        wrongAnswer.textColor = [UIColor blackColor];
        wrongAnswer.numberOfLines = 0;
        [self.view addSubview:wrongAnswer];
        CAKeyframeAnimation *keyFramAnimation = [CAKeyframeAnimation animation];
        keyFramAnimation.keyPath = @"position.y";
        keyFramAnimation.values = @[@0, @(-20), @20, @(-20), @20, @0];
        keyFramAnimation.keyTimes = @[@0, @(1/6.0), @(3/6.0), @(5/6.0), @1, @(7/6.0)];
        keyFramAnimation.duration = 2;
        keyFramAnimation.additive = YES;
        [wrongAnswer.layer addAnimation:keyFramAnimation forKey:@"nod"];
        [NSThread sleepForTimeInterval:2];
        [wrongAnswer removeFromSuperview];
    });
    
}

-(void)setQuestionAndAnswers {
    
    self.questionTitle.text = [self getRandomQuestions];
    
    [self getAnswers];
    [self.view reloadInputViews];
    
}


-(NSString *)getRandomQuestions {
    
    
    if (self.holderArray.count  > 0) {
        self.questionNumber = arc4random_uniform((int)self.holderArray.count);
        NSString *randomQuestion = [Study questionTitleAtIndex:self.questionNumber];
        
        return randomQuestion;
        
    } else {
        NSLog(@"no more questions");
        return @"no more questions";
    }
}

-(void)getAnswers {
    
    NSMutableArray *answerNumbers = [[NSMutableArray alloc]initWithObjects:@0, @1, @2, @3, @4, nil];
    
    int answerNumber = arc4random_uniform((int)answerNumbers.count);
    NSString *answerOne = [Study BadAnswerAtIndex:answerNumber inQuestionAtIndex:self.questionNumber];
    [answerNumbers removeObjectAtIndex:answerNumber];
    
    int answerTwoNumber = arc4random_uniform((int)answerNumbers.count);
    NSString *answerTwo = [Study BadAnswerAtIndex:answerTwoNumber inQuestionAtIndex:self.questionNumber];
    [answerNumbers removeObjectAtIndex:answerTwoNumber];
    
    int answerThreeNumber = arc4random_uniform((int)answerNumbers.count);
    NSString *answerThree  = [Study BadAnswerAtIndex:answerThreeNumber inQuestionAtIndex:self.questionNumber];
    [answerNumbers removeObjectAtIndex:answerThreeNumber];
    
    int answerFourNumber = arc4random_uniform((int)[Study answerCountAtIndex:self.questionNumber]);
    NSString *answerFour  = [Study answerAtIndex:answerFourNumber inQuestionAtIndex:self.questionNumber];
        
   
    NSMutableArray *completeAnswerList = [[NSMutableArray alloc]initWithObjects:answerOne, answerTwo, answerThree, answerFour, nil];
    
        
    int buttonOneTitle = arc4random_uniform((int)completeAnswerList.count);
    [self.answerOne setTitle:completeAnswerList[buttonOneTitle] forState:UIControlStateNormal];
    [completeAnswerList removeObjectAtIndex:buttonOneTitle];
    
    int buttonTwoTitle = arc4random_uniform((int)completeAnswerList.count);
    [self.answerTwo setTitle:completeAnswerList[buttonTwoTitle] forState:UIControlStateNormal];
    [completeAnswerList removeObjectAtIndex:buttonTwoTitle];
    
    int buttonThreeTitle = arc4random_uniform((int)completeAnswerList.count);
    [self.answerThree setTitle:completeAnswerList[buttonThreeTitle] forState:UIControlStateNormal];
    [completeAnswerList removeObjectAtIndex:buttonThreeTitle];
    
    int buttonFourTitle = arc4random_uniform((int)completeAnswerList.count);
    [self.answerFour setTitle:completeAnswerList[buttonFourTitle] forState:UIControlStateNormal];
    [completeAnswerList removeObjectAtIndex:buttonFourTitle];

        
    
    [self.holderArray removeObjectAtIndex:self.questionNumber];
    
    


}


- (NSArray *)questionIndexNumbers {
    return @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20]; //,@21,@22,@23,@24,@25,@26,@27,@28,@29,@30,@31,@32,@33,@34,@35,@36,@37,@38,@39,@40,@41,@42,@43,@44,@45,@46,@47,@48,@49,@50,@51,@52,@53,@54,@55,@56,@57,@58,@59,@60,@61,@62,@63,@64,@65,@66,@67,@68,@69,@70,@71,@72,@73,@74,@75,@76,@77,@78,@79,@80,@81,@82,@83,@84,@85,@86,@87,@88,@89,@90,@91,@92,@93,@94,@95,@96,@97,@98,@99];
    
}


@end
