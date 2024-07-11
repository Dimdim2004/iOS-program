//
//  SceneDelegate.m
//  JCZARA
//
//  Created by wjc on 2024/6/17.
//

#import "SceneDelegate.h"
#import "MainViewController.h"
#import "JCSecond.h"
#import "JCThird.h"
#import "JCFourth.h"
@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window.frame = [UIScreen mainScreen].bounds;
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:mainVC];
    nav1.tabBarItem.title = @"主页";
    nav1.tabBarItem.image = [UIImage systemImageNamed:@"house"];
    
    JCSecond *searchVC = [[JCSecond alloc] init];
    searchVC.title = @"搜索";
    searchVC.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:searchVC];
    nav2.tabBarItem.title = @"搜索";
    nav2.tabBarItem.image = [UIImage systemImageNamed:@"magnifyingglass"];
    
    JCFourth *menuVC = [[JCFourth alloc] init];
    menuVC.title = @"菜单";
    menuVC.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:menuVC];
    nav3.tabBarItem.title = @"菜单";
    nav3.tabBarItem.image = [UIImage systemImageNamed:@"list.dash"];
    
    UIViewController *cartVC = [[UIViewController alloc] init];
    cartVC.title = @"购物袋";
    cartVC.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:cartVC];
    nav4.tabBarItem.title = @"购物袋";
    nav4.tabBarItem.image = [UIImage systemImageNamed:@"bag"];
    
    JCThird *profileVC = [[JCThird alloc] init];
    profileVC.title = @"我的";
    profileVC.view.backgroundColor = [UIColor blackColor];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:profileVC];
    nav5.tabBarItem.title = @"我的";
    nav5.tabBarItem.image = [UIImage systemImageNamed:@"person"];
    
    tabBarController.viewControllers = @[nav1, nav2, nav3, nav4, nav5];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
