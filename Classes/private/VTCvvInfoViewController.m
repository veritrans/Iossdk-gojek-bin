//
//  VTCvvInfoViewController.m
//  iossdk-gojek
//
//  Created by Nanang Rafsanjani on 3/24/16.
//  Copyright © 2016 Veritrans. All rights reserved.
//

#import "VTCvvInfoViewController.h"
#import "UIViewController+Modal.h"

@interface VTCvvInfoViewController ()

@end

@implementation VTCvvInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)okPressed:(id)sender {
    [self dismissCustomViewController:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
