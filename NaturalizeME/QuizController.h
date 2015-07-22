//
//  QuizController.h
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuizController : NSObject

//@property (nonatomic, strong)NSMutableArray *holderArray;

//+(NSMutableArray *)holder;

@property (assign)int questionIndex;

+ (QuizController *)sharedInstance;
//-(NSArray *)questions;

@end
