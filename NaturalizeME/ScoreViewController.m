//
//  ScoreViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@property (strong, nonatomic) IBOutlet UILabel *numberOfQuestionsRightLabel;


@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;


@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateScore:self.scores];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateScore:(Scores *)scores {
    
    self.numberOfQuestionsRightLabel.text = [NSString stringWithFormat:@"%ld out of 100", (long)scores.quizScore];
}

@end
