//
//  QuizController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "QuizController.h"
#import "Study.h"

@interface QuizController ()



@end

@implementation QuizController
+ (QuizController *)sharedInstance {
    static QuizController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [QuizController new];
        
        
    });
    return sharedInstance;
}







@end
