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

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateScore];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateScore {
    self.scoreHolder = [ScoreController sharedInstance].latestQuizScore;
    
    self.numberOfQuestionsRightLabel.text = [NSString stringWithFormat:@"%@ out of 100", self.scoreHolder];
    self.percentageLabel.text = [NSString stringWithFormat:@"%@ ", self.scoreHolder];
}

@end
