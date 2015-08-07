//
//  ManualSetupViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "ManualSetupViewController.h"
#import "SetupController.h"


@interface ManualSetupViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *governorNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *governameTextField;
@property (strong, nonatomic) IBOutlet UILabel *senatorNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *senatorNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *senatorTwoNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *senatorTwoTextField;
@property (strong, nonatomic) IBOutlet UILabel *representativeNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *representativeNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *stateCapitalLabel;
@property (strong, nonatomic) IBOutlet UITextField *stateCapitalTextField;


@end

@implementation ManualSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)acceptDataPushed:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure your information is correct?" message:@"Verify the Data" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"The data is correct" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self saveData];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Re-enter the information" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self clearFields:self];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)saveData {
    self.civicsInfo = [[SetupController sharedInstance]storeCivicsInfo:self.governameTextField.text senatorOneName:self.senatorNameTextField.text senatorTwoName:self.senatorTwoTextField.text repName:self.representativeNameTextField.text stateCapitalName:self.stateCapitalTextField.text];
    
    self.governorNameLabel.text = [NSString stringWithFormat:@"Your Governor's name is %@", self.governameTextField.text];
    self.senatorNameLabel.text = [NSString stringWithFormat:@"Your Senator's name is %@ ", self.senatorNameTextField.text];
    self.senatorTwoNameLabel.text = [NSString stringWithFormat:@"Your other Senator's name is %@ ", self.senatorTwoTextField.text];
    self.representativeNameLabel.text = [NSString stringWithFormat:@"Your Representative's name is %@",self.representativeNameTextField.text];
    self.stateCapitalLabel.text = [NSString stringWithFormat:@"Your state Capital is %@",self.stateCapitalTextField.text];
}

- (IBAction)clearFields:(id)sender {
    self.governameTextField.text = @"";
    self.senatorNameTextField.text = @"";
    self.senatorTwoTextField.text = @"";
    self.representativeNameTextField.text = @"";
    self.stateCapitalTextField.text = @"";
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self loadData:self.civicsInfo];
}
-(void)loadData:(SetupInfo *)civicsInfo {
    
    NSInteger highestNumber = [SetupController sharedInstance].civicsInfo.count -1;
    if (highestNumber >=0) {
        SetupInfo *setupInfo = [SetupController sharedInstance].civicsInfo[highestNumber];
        self.governorNameLabel.text = [NSString stringWithFormat:@"Your Governor's name is %@", setupInfo.governnor];
        self.senatorNameLabel.text = [NSString stringWithFormat:@"Your Senator's name is %@ ", setupInfo.senatorOne];
        self.senatorTwoNameLabel.text = [NSString stringWithFormat:@"Your other Senator's name is %@ ", setupInfo.senatorTwo];
        self.representativeNameLabel.text = [NSString stringWithFormat:@"Your Representative's name is %@",setupInfo.representative];
        self.stateCapitalLabel.text = [NSString stringWithFormat:@"Your state Capital is %@",setupInfo.stateCapital];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
