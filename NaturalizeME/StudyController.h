//
//  StudyController.h
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudyController : NSObject

-(NSMutableArray *)questions;

+ (StudyController *)sharedInstance;

@end
