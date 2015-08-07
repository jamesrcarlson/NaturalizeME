//
//  TableViewController.m
//  NaturalizeME
//
//  Created by James Carlson on 8/6/15.
//  Copyright (c) 2015 JC2 Dev. All rights reserved.
//

#import "SetupTableViewController.h"
#import "SetupInfo.h"
#import "SetupController.h"

@interface SetupTableViewController ()

@property (strong, nonatomic) UITextField *addressInput;

@property (strong, nonatomic) NSString *governorLabel;

@property (strong, nonatomic) NSString *senatorLabel;

@property (strong, nonatomic) NSString *representativeLabel;

@property (strong, nonatomic) NSString *stateCapitalLabel;

@property (strong) NSString *senatorOne;
@property (strong) NSString *senatorTwo;
@property (strong) NSString *representative;
@property (strong) NSString *governor;
@property (strong) NSString *stateCapital;

@end

@implementation SetupTableViewController

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


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; //dismisses the keyboard when user touches outside of the textfield
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"civicCells" forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;

    if (indexPath.section  == 0) {
        self.addressInput = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width, cell.frame.size.height)];
        self.addressInput.adjustsFontSizeToFitWidth = YES;
        self.addressInput.textColor = [UIColor blackColor];
        self.addressInput.placeholder = @"Enter your address";
//        self.addressInput.keyboardType = UIKeyboardTypeDefault;
//        self.addressInput.returnKeyType = UIReturnKeyDone;
//        self.addressInput.secureTextEntry = YES;
        [self.addressInput setEnabled:YES];
        [cell.contentView addSubview:self.addressInput];
    }
    if (indexPath.section  == 1) {
        cell.textLabel.text = @"FIND MY DATA";
        cell.textLabel.backgroundColor = [UIColor greenColor];
    }
    if (indexPath.section  == 2) {
        cell.textLabel.text = self.governorLabel;
    }
    if (indexPath.section  == 3) {
        cell.textLabel.text = self.senatorLabel;
    }
    if (indexPath.section  == 4) {
        cell.textLabel.text = self.representativeLabel;
    }
    if (indexPath.section  == 5) {
        cell.textLabel.text = self.stateCapitalLabel;
    }
    if (indexPath.section  == 6) {
        cell.textLabel.text = @"ACCEPT";
        cell.backgroundColor = [UIColor greenColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section  == 1) {
        [self getData];
        [self.addressInput resignFirstResponder];
        [tableView reloadData];
    };
    if (indexPath.section  == 5) {
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
    };
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
