//
//  TabBarController.m
//  CoreAnimationDemo
//
//  Created by DFD on 2017/2/8.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "TabBarController.h"
#import "SixController.h"
#import "CALayerAnimationController.h"
#import "PresentationModelController.h"
#import "XianShiAnimationController.h"
#import "AnimationGroupController.h"

@interface TabBarController ()<UIActionSheetDelegate, UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectedIndex = self.viewControllers.count - 1;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(goSelect)];
    
    self.delegate = self;
    
}

- (void)goSelect{
    
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"1",@"2",@"3",@"4", nil];;
    [as showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"%@", @(buttonIndex + 1));
    
    UIViewController *vc;
    
    switch (buttonIndex + 1) {
        case 1:
            vc = [[CALayerAnimationController alloc] init];
            break;
        case 2:
            vc = [[PresentationModelController alloc] init];

            break;
        case 3:
            vc = [[XianShiAnimationController alloc] init];
            
            break;
        case 4:
            vc = [[AnimationGroupController alloc] init];
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)rightButtonClick:(id)sender {
//    
//    SixController *six = [[SixController alloc] init];
//    
//    [self.navigationController pushViewController:six animated:YES];
    
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.duration = 1.0;
    
//    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
    
    [viewController.view.layer addAnimation:transition forKey:nil];
    
    NSLog(@"%@", @(viewController.view.layer == self.tabBarController.view.layer));
    
    NSLog(@"%@ %@, %@", viewController.view.layer, self.tabBarController.view.layer, [viewController.view.layer superlayer]);
    
    
    
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
