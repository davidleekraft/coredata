//
//  Student.h
//  CoreDataHW
//
//  Created by David Kraft on 3/24/14.
//  Copyright (c) 2014 David Kraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * eNumber;
@property (nonatomic, retain) NSNumber * age;

@end
