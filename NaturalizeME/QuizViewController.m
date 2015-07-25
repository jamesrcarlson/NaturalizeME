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

static NSInteger currentScores = 0;

@interface QuizViewController ()

@property (strong, nonatomic) IBOutlet UILabel *questionTitle;

@property (strong, nonatomic) IBOutlet UIButton *answerOne;

@property (strong, nonatomic) IBOutlet UIButton *answerTwo;

@property (strong, nonatomic) IBOutlet UIButton *answerThree;

@property (strong, nonatomic) IBOutlet UIButton *answerFour;

@property (nonatomic, strong)NSMutableArray *holderArray;

@property (nonatomic, assign)NSInteger questionNumber;




@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.holderArray = [NSMutableArray new];
    [self.holderArray addObjectsFromArray:[self questionIndexNumbers]];
    
    [self setQuestionAndAnswers];
        
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectAnswerOne:(id)sender {
    
    if ([Study answerCountAtIndex:self.questionNumber] != 0) {
        for (int n = 0; n < [Study answerCountAtIndex:self.questionNumber]-1; n++) {
            if (self.answerOne.titleLabel.text == [Study answerAtIndex:n inQuestionAtIndex:self.questionNumber]) {
                currentScores++;
            }
        };
    } else {
        if (self.answerOne.titleLabel.text == [Study answerAtIndex:0 inQuestionAtIndex:self.questionNumber]) {
            currentScores++;
        }
    };
    
    
    
    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:currentScores];
        ScoreViewController *scoreViewController =[ScoreViewController new];
        [self.navigationController pushViewController:scoreViewController animated:YES];
    } else {
        [self setQuestionAndAnswers];
    }
    
}

- (IBAction)selectAnswerTwo:(id)sender {
    for (int n = 0; n < [Study answerCountAtIndex:self.questionNumber]-1; n++) {
        if (self.answerTwo.titleLabel.text == [Study answerAtIndex:n inQuestionAtIndex:self.questionNumber]) {
            currentScores++;
        }
    };
    
    
    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:currentScores];
        ScoreViewController *scoreViewController =[ScoreViewController new];
        [self.navigationController pushViewController:scoreViewController animated:YES];
    } else {
        [self setQuestionAndAnswers];
    }
}

- (IBAction)selectAnswerThree:(id)sender {
    
    for (int n = 0; n < [Study answerCountAtIndex:self.questionNumber]-1; n++) {
        if (self.answerThree.titleLabel.text == [Study answerAtIndex:n inQuestionAtIndex:self.questionNumber]) {
            currentScores++;
        }
    };
    
    
    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:currentScores];
        ScoreViewController *scoreViewController =[ScoreViewController new];
        [self.navigationController pushViewController:scoreViewController animated:YES];
    } else {
        [self setQuestionAndAnswers];
    }
}

- (IBAction)selectAnswerFour:(id)sender {
    
    for (int n = 0; n < [Study answerCountAtIndex:self.questionNumber]-1; n++) {
        if (self.answerFour.titleLabel.text == [Study answerAtIndex:n inQuestionAtIndex:self.questionNumber]) {
            currentScores++;
        }
    };
    
    
    if (self.holderArray.count == 0) {
        self.scores = [[ScoreController sharedInstance]createScoreWithDate:[NSDate date] score:currentScores];
        ScoreViewController *scoreViewController =[ScoreViewController new];
        [self.navigationController pushViewController:scoreViewController animated:YES];
    } else {
        [self setQuestionAndAnswers];
    }
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
    self.answerOne.titleLabel.text = completeAnswerList[buttonOneTitle];
    [completeAnswerList removeObjectAtIndex:buttonOneTitle];
    
    int buttonTwoTitle = arc4random_uniform((int)completeAnswerList.count);
    self.answerTwo.titleLabel.text = completeAnswerList[buttonTwoTitle];
    [completeAnswerList removeObjectAtIndex:buttonTwoTitle];
    
    int buttonThreeTitle = arc4random_uniform((int)completeAnswerList.count);
    self.answerThree.titleLabel.text = completeAnswerList[buttonThreeTitle];
    [completeAnswerList removeObjectAtIndex:buttonThreeTitle];
    
    int buttonFourTitle = arc4random_uniform((int)completeAnswerList.count);
    self.answerFour.titleLabel.text = completeAnswerList[buttonFourTitle];
    [completeAnswerList removeObjectAtIndex:buttonFourTitle];
    
    [self.holderArray removeObjectAtIndex:self.questionNumber];


}


- (NSArray *)questionIndexNumbers {
    return @[@0,@1,@2]; //,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21,@22,@23,@24,@25,@26,@27,@28,@29,@30,@31,@32,@33,@34,@35,@36,@37,@38,@39,@40,@41,@42,@43,@44,@45,@46,@47,@48,@49,@50,@51,@52,@53,@54,@55,@56,@57,@58,@59,@60,@61,@62,@63,@64,@65,@66,@67,@68,@69,@70,@71,@72,@73,@74,@75,@76,@77,@78,@79,@80,@81,@82,@83,@84,@85,@86,@87,@88,@89,@90,@91,@92,@93,@94,@95,@96,@97,@98,@99];
    
}


@end
