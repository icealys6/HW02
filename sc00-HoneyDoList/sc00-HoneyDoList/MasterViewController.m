//
//  MasterViewController.m
//  sc00-HoneyDoList
//
//  Created by shfrc101b8 on 2016-11-11.
//  Copyright © 2016 shfrc101b8. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Foundation/Foundation.h"

@interface MasterViewController ()
@property (nonatomic,strong) NSMutableArray *addObject;
@property (nonatomic,strong)NSDictionary *staticDict;
@property NSMutableArray *objects;
@property(nonatomic, readonly) NSArray<UITextField *> *textFields;
@property (nonatomic,strong) NSString * text;
@property (nonatomic,strong) NSMutableString *parseText;
@property int rowNumber;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //NSString *path =@"/Users/shfrc101b8/Desktop/sc01-HW1/sc00-HoneyDoList/sc00-HoneyDoList/PropertyList.plist";
    NSString *path =  [[NSBundle mainBundle] pathForResource:@"PropertyList" ofType:@"plist"];
    
    //init dictionaries
    if(!self.objects){
       
        self.objects = [[NSMutableArray alloc]initWithContentsOfFile:path];
    }

    
   
    
    
        self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"To do list" message:@"format: task(subtask,...)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
       
        
            self.text = [alertView textFieldAtIndex:0].text;
        //take string of text and parse it into objects
        [self parser];
        
       
        
        
            
        
            
       
        
        
        
        //Add object to file
        //couldn't get path for mainBundle to work so I hardcoded the path
        NSString *path =@"/Users/shfrc101b8/desktop/sc01-HW1/sc00-HoneyDoList/sc00-HoneyDoList/PropertyList.plist";
        //NSString *path =  [[NSBundle mainBundle] pathForResource:@"PropertyList" ofType:@"plist"];
        [self.objects writeToFile:path atomically: YES];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_rowNumber inSection:0];
        
        
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    }
}

-(void)parser{
    NSString *token;
   
    NSMutableArray *parseObj = [[NSMutableArray alloc]init];
    _parseText = [[NSMutableString alloc]init];
    bool notcopyObject;
    for(int i = 0; i< [self.text length]; i++)
    {
        token = [NSString stringWithFormat:@"%c",[self.text characterAtIndex:i]];
        notcopyObject = (![token isEqualToString:@"("]) && (![token isEqualToString:@")"]) && (![token isEqualToString:@","]);
        if(notcopyObject)
        {
           
           [self.parseText appendString:token];
        }
        else{
            NSString *valueForObject = [[NSString alloc]init];
            valueForObject = [NSString stringWithFormat:@"%@", self.parseText];
            [parseObj addObject:valueForObject];
            [self.parseText setString:@""];
        }
    }
    [self.objects addObject:parseObj];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *object = self.objects[indexPath.row];
     
        
     
     
    
     DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
}
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.objects count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    _rowNumber = (int)indexPath.row;
    NSArray *aObject = self.objects[indexPath.row];
    NSString *task = aObject[0];
    cell.textLabel.text = task;
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
        //copy objects to dictionary and write new plist
        
        
        self.staticDict = [self.objects copy];
        NSString *path =@"/Users/shfrc101b8/Desktop/sc01-HW1/sc00-HoneyDoList/sc00-HoneyDoList/PropertyList.plist";
        //NSString *path =  [[NSBundle mainBundle] pathForResource:@"PropertyList" ofType:@"plist"];
        [self.objects writeToFile:path atomically: YES];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
       
    }
}


@end
