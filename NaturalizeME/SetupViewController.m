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
#import "TextLabelTableViewCell.h"

@interface SetupViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

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

@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:self.civicsInfo];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self loadData:self.civicsInfo];
    
}

-(void)loadData:(SetupInfo *)civicsInfo {
    
    NSInteger highestNumber = [SetupController sharedInstance].civicsInfo.count -1;
    if (highestNumber >=0) {
        SetupInfo *setupInfo = [SetupController sharedInstance].civicsInfo[highestNumber];
        self.governorLabel = [NSString stringWithFormat:@"Your Governor's name is %@", setupInfo.governnor];
        self.senatorLabel = [NSString stringWithFormat:@"Your Senator's names are %@, and %@", setupInfo.senatorOne, setupInfo.senatorTwo];
        self.representativeLabel = [NSString stringWithFormat:@"Your Representative's name is %@",setupInfo.representative];
        self.stateCapitalLabel = [NSString stringWithFormat:@"Your state Capital is %@",setupInfo.stateCapital];
    }else {
        self.governorLabel = @"Your Governor's name is";
        self.senatorLabel = @"Your Senator's names are";
        self.representativeLabel = @"Your Representative's name is";
        self.stateCapitalLabel = @"Your state Capital is";

    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    
    
    NSString *stringPrep = [@"1218 W 1420 N Orem Utah" stringByReplacingOccurrencesOfString:@" " withString:@"+"]; // this NEEDS TO BE FIXED AT SOME POINT
    NSString *keyString = @"&key=AIzaSyCqdu1Nr-LcpjE3JZvm6gnGRXeirVkwuXU";
    
    NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/civicinfo/v2/representatives?address=%@%@", stringPrep, keyString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"%@", dict);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSInteger senatorOneIndex = 0; //should be 0
            NSInteger senatorTwoIndex = 0; // should be 1
            NSInteger governorIndex = 0; // should be 5
            NSInteger representativeIndex = 0; //should be 4
            
            for (NSInteger i = 0; i < 17; i++) {
                if ([dict[@"offices"][i][@"name"]  isEqual: @"United States Senate"]) {
                    senatorOneIndex =(long)dict[@"offices"][i][@"officialIndices"][0];
                    senatorTwoIndex =(long)dict[@"offices"][i][@"officialIndices"][1];
                };
                if ([dict[@"offices"][i][@"roles"]  isEqual: @"legislatorLowerBody"]) {
                    representativeIndex =(long)dict[@"offices"][i][@"officialIndices"][0];
                }
                if ([dict[@"offices"][i][@"name"]  isEqual: @"Governor"]) {
                    governorIndex =(long)dict[@"offices"][i][@"officialIndices"][0];
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
            [self.tableView reloadData];
        });
        
        
    }];
    
    [task resume];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view reloadInputViews]; // this is only getting it to the main thread to process asyncronously. It should just go outside of this, and some other block of code such as to reload the tableview data - should go in there.
    });
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 7;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [UITableViewHeaderFooterView new];
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    if (section == 0) {
        header.textLabel.text = @"Please enter your address";
    }
    if (section == 1) {
        header.textLabel.text = @"Click below to find your representative data";
    }
    if (section == 2) {
        header.textLabel.text = @"Your Governor's name is";
    }
    if (section == 3) {
        header.textLabel.text = @"Your Senator's names are";
    }
    if (section == 4) {
        header.textLabel.text = @"Your Representative's name is";
    }
    if (section == 5) {
        header.textLabel.text = @"Your state capital is";
    }
    if (section == 6) {
        header.textLabel.text = @"Please verify your data prior to submitting";
    }
    return header.textLabel.text;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextLabelTableViewCell *civicCells = [tableView dequeueReusableCellWithIdentifier:@"civicCells"];
    TextLabelTableViewCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:@"textFieldCell"];
    civicCells.civicCell.numberOfLines = 0;
    civicCells.backgroundColor = [UIColor whiteColor];
    civicCells.civicCell.textAlignment = NSTextAlignmentCenter;

    if (indexPath.section  == 0) {
        

        return textFieldCell;
    }
    if (indexPath.section  == 1) {
        civicCells.civicCell.text = @"FIND MY DATA";
        civicCells.civicCell.backgroundColor = [UIColor greenColor];
        return civicCells;
    }
    if (indexPath.section  == 2) {
        civicCells.civicCell.text = self.governorLabel;
        return civicCells;
    }
    if (indexPath.section  == 3) {
        civicCells.civicCell.text = self.senatorLabel;
        return civicCells;
    }
    if (indexPath.section  == 4) {
        civicCells.civicCell.text = self.representativeLabel;
        return civicCells;
    }
    if (indexPath.section  == 5) {
        civicCells.civicCell.text = self.stateCapitalLabel;
        return civicCells;
    }
    if (indexPath.section  == 6) {
        civicCells.civicCell.text = @"ACCEPT";
        civicCells.backgroundColor = [UIColor greenColor];
        return civicCells;
    }else {
    
        return civicCells; }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section  == 1) {
        [self getData];
//        [self.textField resignFirstResponder];
        [tableView reloadData];
    };
    if (indexPath.section  == 6) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure your information is correct?" message:@"Verify the Data" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"The data is correct" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self saveData];
            [self performSegueWithIdentifier:@"acceptSetupData" sender:self];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Re-enter the information" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//            self.textField.text = @"";
            [self needBetterInput];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        //        self.civicsInfo = [[SetupController sharedInstance]storeCivicsInfo:self.governor senatorOneName:self.senatorOne senatorTwoName:self.senatorTwo repName:self.representative stateCapitalName:self.stateCapital];
    };
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    [TextLabelTableViewCell]
//    
//    return YES;
//}
//-(void)textFieldDidBeginEditing:(UITextField *)textField {
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:(TextLabelTableViewCell*)[[textField superview] superview]]; // this should return you your current indexPath
//    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) self.textField = textField.text;
//    } else {
//        self.textField = textField.text;
//    }
//
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:(TextLabelTableViewCell *)[[textField superview]superview]];
//    self.textField = [self.tableView[indexPath.row];
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
