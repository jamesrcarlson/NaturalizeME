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

static NSString * const showScoreSegue = @"showScores";

@interface QuizViewController ()

@property (strong, nonatomic) IBOutlet UILabel *questionTitle;

@property (strong, nonatomic) IBOutlet UIButton *answerOne;

@property (strong, nonatomic) IBOutlet UIButton *answerTwo;

@property (strong, nonatomic) IBOutlet UIButton *answerThree;

@property (strong, nonatomic) IBOutlet UIButton *answerFour;

@property (nonatomic, strong)NSMutableArray *holderArray;

@property (nonatomic, assign)NSInteger questionNumber;

@property (assign)NSInteger currentScores;

@property (strong)UILabel *rightAnswer;
@property (strong)UILabel *wrongAnswer;
@property (strong)NSMutableArray *wrongAnswersChosen;


@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wrongAnswersChosen = [NSMutableArray new];
    
    self.answerOne.titleLabel.numberOfLines = 0;
    self.answerTwo.titleLabel.numberOfLines = 0;
    self.answerThree.titleLabel.numberOfLines = 0;
    self.answerFour.titleLabel.numberOfLines = 0;
    
    self.holderArray = [NSMutableArray new];
    [self.holderArray addObjectsFromArray:[self questionIndexNumbers]];
    
    [self setQuestionAndAnswers];
    self.currentScores = 0;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectAnswerOne:(id)sender {
    
    int answerStatus = 0;
    
    if ([Study answerCountAtIndex:self.questionNumber] != 0) {
        
        
        for (int i = 0; i < [Study answerCountAtIndex:self.questionNumber]; i++) {
            if (self.answerOne.titleLabel.text == [Study answerAtIndex:i inQuestionAtIndex:self.questionNumber]) {
                self.currentScores++;
                
                [self gotTheRightAnswer:self.answerOne.titleLabel.text];
                answerStatus = 1;
            }
        };
    }
    if (answerStatus == 0) {
        [self gotItWrong:self.answerOne.titleLabel.text];
    };
    
    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) wrongAsnwers:[self wrongAnswerArray]];
        [[ScoreController sharedInstance]save];
        [self performSegueWithIdentifier:showScoreSegue sender:self];
    }else {
        
        [self setQuestionAndAnswers];

    }
    
}

- (IBAction)selectAnswerTwo:(id)sender {
    int answerStatus = 0;
    
    if ([Study answerCountAtIndex:self.questionNumber] != 0) {
        for (int i = 0; i < [Study answerCountAtIndex:self.questionNumber]; i++) {
            if (self.answerTwo.titleLabel.text == [Study answerAtIndex:i inQuestionAtIndex:self.questionNumber]) {
                self.currentScores++;
                
                [self gotTheRightAnswer:self.answerTwo.titleLabel.text];
                answerStatus = 1;
            }
        };
    }

    if (answerStatus == 0) {
        [self gotItWrong:self.answerTwo.titleLabel.text];
    };

    
    if (self.holderArray.count == 0) {
        [NSThread sleepForTimeInterval:2];
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) wrongAsnwers:[self wrongAnswerArray]];
        [[ScoreController sharedInstance]save];
        [self performSegueWithIdentifier:showScoreSegue sender:self];
    }else {
        
        [self setQuestionAndAnswers];

    }
    
}


- (IBAction)selectAnswerThree:(id)sender {
    int answerStatus = 0;
    if ([Study answerCountAtIndex:self.questionNumber] != 0) {
        for (int i = 0; i < [Study answerCountAtIndex:self.questionNumber]; i++) {
            if (self.answerThree.titleLabel.text == [Study answerAtIndex:i inQuestionAtIndex:self.questionNumber]) {
                self.currentScores++;
                
                [self gotTheRightAnswer:self.answerThree.titleLabel.text];
                answerStatus = 1;
            }
        };
    }
    if (answerStatus == 0) {
        [self gotItWrong:self.answerThree.titleLabel.text];
    };
    
    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) wrongAsnwers:[self wrongAnswerArray]];
        [[ScoreController sharedInstance]save];
        [self performSegueWithIdentifier:showScoreSegue sender:self];
    }else {
        [self setQuestionAndAnswers];
        
    }
    
}

- (IBAction)selectAnswerFour:(id)sender {
    int answerStatus = 0;
    if ([Study answerCountAtIndex:self.questionNumber] != 0) {
        for (int i = 0; i < [Study answerCountAtIndex:self.questionNumber]; i++) {
            if (self.answerFour.titleLabel.text == [Study answerAtIndex:i inQuestionAtIndex:self.questionNumber]) {
                self.currentScores++;
                
                [self gotTheRightAnswer:self.answerFour.titleLabel.text];
                answerStatus = 1;
            }
        };
    }
    if (answerStatus == 0) {
        [self gotItWrong:self.answerFour.titleLabel.text];
    };
    

    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) wrongAsnwers:[self wrongAnswerArray]];
        [[ScoreController sharedInstance]save];
        [self performSegueWithIdentifier:showScoreSegue sender:self];
    }else {
        
        [self setQuestionAndAnswers];
        
    }
    
}
- (IBAction)quitAndSeeScore:(id)sender {
    self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:@(self.currentScores) wrongAsnwers:[self wrongAnswerArray]];
    [[ScoreController sharedInstance]save];
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
        [self.wrongAnswersChosen addObject:[NSString stringWithFormat:@"%@",buttonTitle]];
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
-(NSArray *)wrongAnswerArray {
    NSArray *myNewWrongAnswerArray = [[NSArray alloc]initWithArray:self.wrongAnswersChosen];
    return myNewWrongAnswerArray;
}


- (NSArray *)questionIndexNumbers {
    return @[@0,@1,@2,@3,@4,@5,@6]; //,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21,@22,@23,@24,@25,@26,@27,@28,@29,@30,@31,@32,@33,@34,@35,@36,@37,@38,@39,@40,@41,@42,@43,@44,@45,@46,@47,@48,@49,@50,@51,@52,@53,@54,@55,@56,@57,@58,@59,@60,@61,@62,@63,@64,@65,@66,@67,@68,@69,@70,@71,@72,@73,@74,@75,@76,@77,@78,@79,@80,@81,@82,@83,@84,@85,@86,@87,@88,@89,@90,@91,@92,@93,@94,@95,@96,@97,@98,@99];
    
}


@end
