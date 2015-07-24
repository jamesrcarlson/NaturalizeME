//
//  SetupViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 7/16/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "SetupViewController.h"
#import "SetupInfo.h"

@interface SetupViewController ()

@property (strong, nonatomic) IBOutlet UITextField *addressInput;

@property (strong, nonatomic) IBOutlet UILabel *governorLabel;

@property (strong, nonatomic) IBOutlet UILabel *senatorLabel;

@property (strong, nonatomic) IBOutlet UILabel *representativeLabel;

@property (strong) NSString *senatorOne;
@property (strong) NSString *senatorTwo;
@property (strong) NSString *representative;
@property (strong) NSString *governor;



@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)findRepresentative:(id)sender {
    
    [self getData];
    
}

- (IBAction)acceptData:(id)sender {
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
            
            self.governorLabel.text = [NSString stringWithFormat:@"Your Governor's name is %@", self.governor];
            self.senatorLabel.text = [NSString stringWithFormat:@"Your Senator's Name is %@", self.senatorOne];
            self.representativeLabel.text = [NSString stringWithFormat:@"Your Representative's name is %@",self.representative];
        });
        
        
        
        
        
//        SetupInfo *setupInfo = [SetupInfo new];
//        setupInfo.senatorOne = self.senatorOne;
//        setupInfo.senatorTwo = self.senatorTwo;
//        setupInfo.representative = self.representative;
//        setupInfo.governnor = self.governor;
    }];
    
    [task resume];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view reloadInputViews]; // this is only getting it to the main thread to process asyncronously. It should just go outside of this, and some other block of code such as to reload the tableview data - should go in there.
    });
    
    
//    [self.view reloadInputViews];
}

@end
