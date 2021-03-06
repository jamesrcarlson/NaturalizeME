//
//  SetupViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "SetupViewController.h"
#import "SetupInfo.h"
#import "SetupController.h"

@interface SetupViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *addressInput;

@property (strong, nonatomic) IBOutlet UILabel *governorLabel;

@property (strong, nonatomic) IBOutlet UILabel *senatorLabel;

@property (strong, nonatomic) IBOutlet UILabel *representativeLabel;

@property (strong, nonatomic) IBOutlet UILabel *stateCapitalLabel;

@property (strong) NSString *senatorOne;
@property (strong) NSString *senatorTwo;
@property (strong) NSString *representative;
@property (strong) NSString *governor;
@property (strong) NSString *stateCapital;


@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.governorLabel.numberOfLines = 0;
    self.senatorLabel.numberOfLines = 0;
    self.stateCapitalLabel.numberOfLines = 0;
    self.representativeLabel.numberOfLines = 0;
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self loadData:self.civicsInfo];
    
}

-(void)loadData:(SetupInfo *)civicsInfo {
    
    NSInteger highestNumber = [SetupController sharedInstance].civicsInfo.count -1;
    if (highestNumber >=0) {
        SetupInfo *setupInfo = [SetupController sharedInstance].civicsInfo[highestNumber];
        self.governorLabel.text = [NSString stringWithFormat:@"Your Governor's name is %@", setupInfo.governnor];
        self.senatorLabel.text = [NSString stringWithFormat:@"Your Senator's names are %@, and %@", setupInfo.senatorOne, setupInfo.senatorTwo];
        self.representativeLabel.text = [NSString stringWithFormat:@"Your Representative's name is %@",setupInfo.representative];
        self.stateCapitalLabel.text = [NSString stringWithFormat:@"Your state Capital is %@",setupInfo.stateCapital];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)notifications {
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveData) name:@"infoCollected" object:nil];
//}


- (IBAction)findRepresentative:(id)sender {
    
    [self getData];
    
    [self.addressInput resignFirstResponder];
    
}


- (IBAction)acceptData:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure your information is correct?" message:@"Verify the Data" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"The data is correct" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self saveData];
        [self performSegueWithIdentifier:@"acceptSetupData" sender:self];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Re-enter the information" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        self.addressInput.text = @"";
        [self needBetterInput];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
//        self.civicsInfo = [[SetupController sharedInstance]storeCivicsInfo:self.governor senatorOneName:self.senatorOne senatorTwoName:self.senatorTwo repName:self.representative stateCapitalName:self.stateCapital];


    
}

-(void)needBetterInput {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"The Address you type in should be exact and accurate?" message:@"If the data is still not loading, please us the 'Enter Manually' option" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Got it!" style:UIAlertActionStyleDefault handler:nil]];
    
}

-(void)saveData {
    
    self.civicsInfo = [[SetupController sharedInstance]storeCivicsInfo:self.governor senatorOneName:self.senatorOne senatorTwoName:self.senatorTwo repName:self.representative stateCapitalName:self.stateCapital];
}

-(void)getData{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    
    
    NSString *stringPrep = [self.addressInput.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *keyString = @"&key=AIzaSyCqdu1Nr-LcpjE3JZvm6gnGRXeirVkwuXU";
    
    NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/civicinfo/v2/representatives?address=%@%@", stringPrep, keyString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"%@", dict);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.senatorOne = dict[@"officials"][0][@"name"];
            self.senatorTwo = dict[@"officials"][1][@"name"];
            self.representative = dict[@"officials"][4][@"name"];
            self.governor = dict[@"officials"][5][@"name"];
            self.stateCapital = dict[@"officials"][5][@"address"][0][@"city"];
            
            self.governorLabel.text = [NSString stringWithFormat:@"Your Governor's name is %@", self.governor];
            self.stateCapitalLabel.text = [NSString stringWithFormat:@"Your state Capital is %@",self.stateCapital];
            self.senatorLabel.text = [NSString stringWithFormat:@"Your Senator's names are %@ and %@", self.senatorOne, self.senatorTwo];
            self.representativeLabel.text = [NSString stringWithFormat:@"Your Representative's name is %@",self.representative];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"infoCollected" object:nil];
            
        });
        

    }];
    
    [task resume];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view reloadInputViews]; // this is only getting it to the main thread to process asyncronously. It should just go outside of this, and some other block of code such as to reload the tableview data - should go in there.
    });
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; //dismisses the keyboard when user touches outside of the textfield
}

//-(void)dealloc {
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}


@end
