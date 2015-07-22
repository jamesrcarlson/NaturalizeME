//
//  StudyController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "StudyController.h"
#import "Study.h"

@implementation StudyController

+ (StudyController *)sharedInstance {
    static StudyController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [StudyController new];
    });
    return sharedInstance;
}

-(NSMutableArray *)questions {
    
    NSMutableArray *answersArray = [[NSMutableArray alloc]initWithArray:[Study answers]];
    
    return answersArray;
}



@end
