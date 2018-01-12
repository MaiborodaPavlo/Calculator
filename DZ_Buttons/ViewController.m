//
//  ViewController.m
//  DZ_Buttons
//
//  Created by Pavel on 12.01.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    PMAdditionOperation,
    PMDifferenceOperation,
    PMMultiplicationOperation,
    PMDivisionOperation,
    PMPercentageOperation
} PMOperationsEnum;

@interface ViewController ()

@property (strong, nonatomic) NSMutableString *mutableString;
@property (assign, nonatomic) CGFloat firstNumber;
@property (assign, nonatomic) CGFloat secondNumber;
@property (assign, nonatomic) PMOperationsEnum operation;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mutableString = [NSMutableString string];
    self.firstNumber = NSNotFound;
    self.secondNumber = NSNotFound;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Help Methods

- (NSString *) doOperation: (PMOperationsEnum) operation withNumber: (CGFloat) firstNumber andNumber: (CGFloat) secondNumber {
    
    CGFloat returnValue = 0.f;
    
    switch (operation) {
        case PMPercentageOperation:
            returnValue = firstNumber * secondNumber / 100;
            break;
            
        case PMAdditionOperation:
            returnValue = firstNumber + secondNumber;
            break;
            
        case PMDifferenceOperation:
            if (firstNumber == 0.f) {
                returnValue = [[NSString stringWithFormat:@"-%f", secondNumber] floatValue];
            } else {
                returnValue = firstNumber - secondNumber;
            }
            break;
            
        case PMMultiplicationOperation:
            returnValue = firstNumber * secondNumber;
            break;
            
        case PMDivisionOperation:
            if (secondNumber == 0) {
                returnValue = 0;
            } else {
                returnValue = firstNumber / secondNumber;
            }
            break;
            
        default:
            break;
    }
    
    return [NSString stringWithFormat: @"%f", returnValue];
    
}

- (BOOL) isDotInString {
    NSRange range = [self.mutableString rangeOfString: @"." options: NSCaseInsensitiveSearch];
    
    if (range.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Actions

- (IBAction) actionPressPlusMinus: (UIButton *) sender {
    
    if ([self.mutableString isEqualToString: @""]) {
        [self.mutableString appendString: self.scoreboardLabel.text];
    }
    
    NSRange range = [self.mutableString rangeOfString: @"-"];
    
    if (range.location != NSNotFound) {
        [self.mutableString setString: [self.mutableString substringFromIndex: range.location + 1]];
    } else {
        [self.mutableString setString: [NSMutableString stringWithFormat: @"-%@", self.mutableString]];
    }
    
    self.scoreboardLabel.text = self.mutableString;
    
}

- (IBAction) actionPressDot: (UIButton *) sender {
    
    if (![self isDotInString]) {
        
        if ([self.mutableString isEqualToString: @""]) {
            [self.mutableString appendString: @"0."];
        } else {
            [self.mutableString appendString: @"."];
        }
        
        self.scoreboardLabel.text = self.mutableString;
    }
    
    
}

- (IBAction) actionPressOperand: (UIButton *) sender {
    
    if (self.firstNumber == NSNotFound) {
        if ([self.mutableString isEqualToString: @""]) {
            self.firstNumber = [self.scoreboardLabel.text floatValue];
        } else {
            self.firstNumber = [self.mutableString floatValue];
            [self.mutableString setString:@""];
        }
    } else {
        self.secondNumber = [self.mutableString floatValue];

        self.scoreboardLabel.text = [self doOperation: self.operation withNumber: self.firstNumber andNumber: self.secondNumber];
        
        [self.mutableString setString:@""];
        self.firstNumber = NSNotFound;
        self.secondNumber = NSNotFound;
    }
    
    switch (sender.tag) {
        case 16:
            self.operation = PMPercentageOperation;
            break;
        case 15:
            self.operation = PMAdditionOperation;
            break;
        case 14:
            self.operation = PMDifferenceOperation;
            break;
        case 13:
            self.operation = PMMultiplicationOperation;
            break;
        case 12:
            self.operation = PMDivisionOperation;
            break;
        default:
            break;
    }
    
    
}

- (IBAction) actionPressNumber: (UIButton *) sender {
    
    //[self.mutableString setString:@""];
    [self.mutableString appendString: [sender titleForState: UIControlStateNormal]];
    self.scoreboardLabel.text = self.mutableString;
    
}

- (IBAction) actionClean: (UIButton *) sender {
    
    self.scoreboardLabel.text = @"0";
    [self.mutableString setString:@""];
    self.firstNumber = NSNotFound;
    self.secondNumber = NSNotFound;
}
@end
