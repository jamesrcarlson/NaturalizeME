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

@property (assign)NSInteger index;


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




//-(NSString *)randomQuestions {
//    
//    
//    if (self.holder.count  != 0) {
//        self.questionIndex = arc4random_uniform((int)self.holder.count - 1);
//        NSString *randomQuestion = [Study questionTitleAtIndex:self.questionIndex];
//        
//        return randomQuestion;
//        
//    } else {
//        NSLog(@"no more questions");
//        return @"no more questions";
//    }
//}
//-(void)removeIndex {
//    [[QuizController holder] removeObjectAtIndex:self.questionIndex];
//}

//-(NSArray *)questions {
//    NSMutableArray *questionsArray;
//    
//    for (int i = 0; i < [[Study answers]count]; i++) {
//        [questionsArray addObject:[Study questionAtIndex:i]];
//         }
//    return questionsArray;
//}
//-(NSArray *)answers {
//    NSMutableArray *answersArray;
//    
//    for (int i = 0; i < [[Study an]count]; i++) {
//        <#statements#>
//    };
//    
//    return answersArray;
//}


@end
