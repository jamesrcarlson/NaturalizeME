//
//  TableViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 8/6/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "SetupViewController.h"
#import "SetupInfo.h"
#import "SetupController.h"
#import "QuestionController.h"
#import "WelcomeViewController.h"

@interface SetupViewController () <UITextFieldDelegate, UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) NSString *governorLabel;
@property (strong, nonatomic) NSString *senatorLabel;
@property (strong, nonatomic) NSString *representativeLabel;
@property (strong, nonatomic) NSString *stateCapitalLabel;
@property (strong) NSString * textFieldText;
@property (strong) NSString *senatorOne;
@property (strong) NSString *senatorTwo;
@property (strong) NSString *representative;
@property (strong) NSString *governor;
@property (strong) NSString *stateCapital;
@property (strong, nonatomic) IBOutlet UILabel *labelOne;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *labelTwo;
@property (strong, nonatomic) IBOutlet UILabel *labelThree;
@property (strong, nonatomic) IBOutlet UILabel *labelFour;
@property (strong, nonatomic) IBOutlet UILabel *labelFive;
@property (strong, nonatomic) IBOutlet UILabel *labelSix;
@property (strong, nonatomic) IBOutlet UILabel *labelSeven;
@property (strong, nonatomic) IBOutlet UILabel *labelEight;
@property (strong, nonatomic) IBOutlet UILabel *labelNine;




@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:self.civicsInfo];
    
    UIAlertController *firstAlertController = [UIAlertController alertControllerWithTitle:@"You must complete this step prior to begining your studies \nMake sure you are entering your Complete address\nAnd that you Representative's information is displayed" message:@"Enter your full address" preferredStyle:UIAlertControllerStyleAlert];
    [firstAlertController addAction:[UIAlertAction actionWithTitle:@"Got it!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self.tableView reloadData];
    }]];
    

    [self presentViewController:firstAlertController animated:YES completion:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
}
-(void)setLabelText {
    self.labelOne.text = @"Please enter your full address";
    self.labelOne.font = [UIFont fontWithName:@"Helvetica" size:22.0];
    self.labelOne.backgroundColor = [UIColor lightGrayColor];
    self.labelTwo.text = @"Get your Representative's information";
    self.labelTwo.font = [UIFont fontWithName:@"Helvetica" size:22.0];
    self.labelTwo.backgroundColor = [UIColor greenColor];
    self.labelThree.text = self.governorLabel;
    self.labelThree.font = [UIFont fontWithName:@"Helvetica" size:22.0];
    self.labelFour.text = self.senatorLabel;
    self.labelFour.font = [UIFont fontWithName:@"Helvetica" size:22.0];
    self.labelFive.text = self.representativeLabel;
    self.labelFive.font = [UIFont fontWithName:@"Helvetica" size:22.0];
    self.labelSix.text = self.stateCapitalLabel;
    self.labelSix.font = [UIFont fontWithName:@"Helvetica" size:22.0];
    self.labelSeven.text = @"Please verify the information provided is correct before accepting it";
    self.labelSeven.font = [UIFont fontWithName:@"Helvetica" size:22.0];
    self.labelSeven.backgroundColor = [UIColor lightGrayColor];
    self.labelEight.text = @"ACCEPT INFO";
    self.labelEight.font = [UIFont fontWithName:@"Helvetica" size:22.0];
    self.labelEight.backgroundColor = [UIColor greenColor];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self loadData:self.civicsInfo];
    
}

-(void)loadData:(SetupInfo *)civicsInfo {
    
    NSInteger highestNumber = [SetupController sharedInstance].civicsInfo.count - 1;
    
    if (highestNumber >=0) {
        SetupInfo *setupInfo = [SetupController sharedInstance].civicsInfo[highestNumber];
        self.governorLabel = [NSString stringWithFormat:@"Your Governor's name is %@", setupInfo.governnor];
        self.senatorLabel = [NSString stringWithFormat:@"Your Senator's names are %@, and %@", setupInfo.senatorOne, setupInfo.senatorTwo];
        self.representativeLabel = [NSString stringWithFormat:@"Your Representative's name is %@",setupInfo.representative];
        self.stateCapitalLabel = [NSString stringWithFormat:@"Your state Capital is %@",setupInfo.stateCapital];
        [self setLabelText];
        
    }else {
        [self.navigationController setNavigationBarHidden:YES];
        self.governorLabel = @"Your Governor's name is";
        self.senatorLabel = @"Your Senator's names are";
        self.representativeLabel = @"Your Representative's name is";
        self.stateCapitalLabel = @"Your state Capital is";
        [self setLabelText];
        }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)needBetterInput {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"The Address you type in should be exact and accurate?" message:@"If the data is still not loading, please us the 'Enter Manually' option" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Got it!" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)saveData {
    
    self.civicsInfo = [[SetupController sharedInstance]storeCivicsInfo:self.governor senatorOneName:self.senatorOne senatorTwoName:self.senatorTwo repName:self.representative stateCapitalName:self.stateCapital];
}

-(void)getData{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    
    NSString *stringPrep = [self.textField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *keyString = @"&key=AIzaSyCqdu1Nr-LcpjE3JZvm6gnGRXeirVkwuXU";
    
    NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/civicinfo/v2/representatives?address=%@%@", stringPrep, keyString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSInteger senatorOneIndex = 0;
            NSInteger senatorTwoIndex = 0;
            NSInteger governorIndex = 0;
            NSInteger representativeIndex = 0;
                        
            for (int i = 0; i < 17; i++) {
                if ([dict[@"offices"][i][@"name"]  isEqual: @"United States Senate"]) {
                    senatorOneIndex = [dict[@"offices"][i][@"officialIndices"][0]integerValue];
                    senatorTwoIndex = [dict[@"offices"][i][@"officialIndices"][1]integerValue];
                };
                if ([dict[@"offices"][i][@"roles"][0] isEqual: @"legislatorLowerBody"]) {
                    representativeIndex = [dict[@"offices"][i][@"officialIndices"][0]integerValue];
                }
                if ([dict[@"offices"][i][@"name"]  isEqual: @"Governor"]) {
                    governorIndex =[dict[@"offices"][i][@"officialIndices"][0]integerValue];
                }
            };
            self.senatorOne = dict[@"officials"][senatorOneIndex][@"name"];
            self.senatorTwo = dict[@"officials"][senatorTwoIndex][@"name"];
            self.representative = dict[@"officials"][representativeIndex][@"name"];
            self.governor = dict[@"officials"][governorIndex][@"name"];
            self.stateCapital = dict[@"officials"][governorIndex][@"address"][0][@"city"];
            
            self.governorLabel= [NSString stringWithFormat:@"Your Governor's name is %@", self.governor];
            self.stateCapitalLabel = [NSString stringWithFormat:@"Your state Capital is %@",self.stateCapital];
            self.senatorLabel = [NSString stringWithFormat:@"Your Senator's names are %@ and %@", self.senatorOne, self.senatorTwo];
            self.representativeLabel = [NSString stringWithFormat:@"Your Representative's name is %@",self.representative];
            [self setLabelText];
            [self.tableView reloadData];
        });
        
        
    }];
    
    [task resume];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view reloadInputViews]; // this is only getting it to the main thread to process asyncronously. It should just go outside of this, and some other block of code such as to reload the tableview data - should go in there.
    });
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellText = @"Your Senator's names are a senators name, and senators name";
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:22.0];
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:cellText
                                                                         attributes:@{NSFontAttributeName: cellFont}];
    
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size.height + 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 9;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row  == 2) {
        
        if ([self.textField.text isEqualToString:@""]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You must enter in your full address" message:@"Ensure your address is entered correctly" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Got it" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else {
        
        [self getData];
        [self.textField resignFirstResponder];
        [tableView reloadData];
        }
    };
    if (indexPath.row  == 8) {
        
        if (!self.governor) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You must enter in your full address \nAnd ensure that you have an internet connection" message:@"Ensure your address is entered correctly" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Got it" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
        
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure your information is correct?" message:@"Verify the Data" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"The data is correct" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self saveData];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Re-enter the information" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                self.textField.text = @"";
                [self needBetterInput];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        };
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
