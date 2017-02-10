//
//  TabBarController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/8.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "TabBarController.h"
#import "SixController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectedIndex = self.viewControllers.count - 1;
}

- (IBAction)rightButtonClick:(id)sender {
//    
//    SixController *six = [[SixController alloc] init];
//    
//    [self.navigationController pushViewController:six animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
