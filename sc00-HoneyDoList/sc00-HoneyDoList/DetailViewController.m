//
//  DetailViewController.m
//  sc00-HoneyDoList
//
//  Created by shfrc101b8 on 2016-11-11.
//  Copyright © 2016 shfrc101b8. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSMutableString *list = [[NSMutableString alloc]init];
        for(int i = 1;i < [self.detailItem count]; i++){
            NSString *listItem = [NSString stringWithFormat:@"%@\n",self.detailItem[i]];
            [list appendString:listItem];
        }
        self.detailDescriptionLabel.text = list;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(NSArray *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


@end
