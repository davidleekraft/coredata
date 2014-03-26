//
//  CDHWViewController.m
//  CoreDataHW
//
//  Created by David Kraft on 3/24/14.
//  Copyright (c) 2014 David Kraft. All rights reserved.
//

#import "CDHWViewController.h"
#import "CDHWAppDelegate.h"
#import "Student.h"

@interface CDHWViewController ()
{
    NSManagedObjectContext *context;
}

@end

@implementation CDHWViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self resultsTextView] setUserInteractionEnabled:NO];
    [[self resultsTextView] setText:@""];
    
    [[self firstNameTextField] setDelegate:self];
    [[self lastNameTextField] setDelegate:self];
    [[self eNumberTextField] setDelegate:self];
    [[self ageTextField] setDelegate:self];
    
    CDHWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    context = [appDelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addStudent:(id)sender
{
    NSManagedObject *studentToAdd = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *studentAge = [formatter numberFromString:[self.ageTextField text]];
    
    [studentToAdd setValue:[self.firstNameTextField text] forKeyPath:@"firstName"];
    [studentToAdd setValue:[self.lastNameTextField text] forKeyPath:@"lastName"];
    [studentToAdd setValue:[self.eNumberTextField text] forKeyPath:@"eNumber"];
    [studentToAdd setValue:studentAge forKey:@"age"];
    
    NSError *error;
    
    if(![context save:&error])
    {
        NSLog(@"Save Error: %@", [error localizedDescription]);
    }
}
- (IBAction)searchStudent:(id)sender
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Student" inManagedObjectContext:context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName like %@ or lastName like %@ or eNumber like %@ or age like %@", self.firstNameTextField.text, self.lastNameTextField.text, self.eNumberTextField.text, self.ageTextField.text];
    
    [request setPredicate:predicate];
    
    NSError *error;
    
    NSArray *resultsArray = [context executeFetchRequest:request error:&error];
    
    if ([resultsArray count] > 0) {
        NSMutableString *resultsString = [[NSMutableString alloc] init];
        
        for (Student *nextStudent in resultsArray) {
            [resultsString appendFormat:@"%@ %@ %@ %@\n", nextStudent.firstName, nextStudent.lastName, nextStudent.eNumber, nextStudent.age];
        }
        
        [self.resultsTextView setText:resultsString];
        }
    else
    {
        [self.resultsTextView setText:@"No results returned"];
    }
    
}
- (IBAction)deleteStudent:(id)sender
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Student" inManagedObjectContext:context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eNumber like %@",self.eNumberTextField.text];
    
    [request setPredicate:predicate];
    
    NSError *error;
    
    NSArray *resultsArray = [context executeFetchRequest:request error:&error];
    
    if ([resultsArray count] > 0) {
        
        for (Student *nextStudent in resultsArray) {
            [context deleteObject:nextStudent];
        }
        
        [context save:&error];
        [self.resultsTextView setText:[NSString stringWithFormat:@"%d record(s) deleted", [resultsArray count]] ];
    }
    else
    {
        [self.resultsTextView setText:@"No results returned"];
    }
    
}
# pragma mark - UITextField Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

@end
