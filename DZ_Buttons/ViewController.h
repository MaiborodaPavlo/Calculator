//
//  ViewController.h
//  DZ_Buttons
//
//  Created by Pavel on 12.01.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *scoreboardLabel;

- (IBAction) actionClean: (UIButton *) sender;
- (IBAction) actionPressNumber: (UIButton *) sender;
- (IBAction) actionPressOperand: (UIButton *) sender;
- (IBAction) actionPressDot: (UIButton *) sender;
- (IBAction) actionPressPlusMinus: (UIButton *) sender;

@end

