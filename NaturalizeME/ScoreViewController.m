//
//  ScoreViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "ScoreViewController.h"
#import "ScoreController.h"

@interface ScoreViewController ()

@property (strong, nonatomic) IBOutlet UILabel *numberOfQuestionsRightLabel;

@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;

@property (strong)NSNumber *scoreHolder;
@property (strong)NSNumber *totalAnswerHolder;

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateScore];
    
}
- (IBAction)acceptScore:(id)sender {
    
    [[ScoreController sharedInstance]save];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateScore {
    self.scoreHolder = [ScoreController sharedInstance].latestQuizScore;
    self.totalAnswerHolder = [ScoreController sharedInstance].answersCompleted;
    float score = ((float)self.scoreHolder.integerValue/(float)self.totalAnswerHolder.integerValue) *100;
    
    self.numberOfQuestionsRightLabel.text = [NSString stringWithFormat:@"%@ out of %@", self.scoreHolder, self.totalAnswerHolder];
    self.percentageLabel.text = [NSString stringWithFormat:@"%ld %%", (long)score];
}

@end
