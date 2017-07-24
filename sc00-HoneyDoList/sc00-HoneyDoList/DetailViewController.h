//
//  DetailViewController.h
//  sc00-HoneyDoList
//
//  Created by shfrc101b8 on 2016-11-11.
//  Copyright © 2016 shfrc101b8. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSArray *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

