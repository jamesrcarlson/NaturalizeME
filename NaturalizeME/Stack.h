//
//  Stack.h
//  NaturalizeMe
//
//  Created by James Carlson on 7/21/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;

@interface Stack : NSObject

+ (Stack *)sharedInstance;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@end