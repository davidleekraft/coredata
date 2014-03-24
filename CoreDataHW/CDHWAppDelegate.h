//
//  CDHWAppDelegate.h
//  CoreDataHW
//
//  Created by David Kraft on 3/24/14.
//  Copyright (c) 2014 David Kraft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDHWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
