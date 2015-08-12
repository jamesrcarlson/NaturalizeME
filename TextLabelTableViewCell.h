//
//  TextLabelTableViewCell.h
//  NaturalizeME
//
//  Created by James Carlson on 8/8/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextLabelTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *myLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreViewLabel;
@property (strong, nonatomic) IBOutlet UILabel *answerStudyLabel;
@property (strong, nonatomic) IBOutlet UILabel *wrongAnswerLabel;
@property (strong, nonatomic) IBOutlet UILabel *fastQuizLabel;





@end
