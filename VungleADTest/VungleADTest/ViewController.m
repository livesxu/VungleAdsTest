//
//  ViewController.m
//  VungleADTest
//
//  Created by livesxu on 2018/8/16.
//  Copyright © 2018年 Livesxu. All rights reserved.
//1.Placement 貌似有问题。
//2.提前load，等待询问结果，再行展示.

#import "ViewController.h"

#import <VungleSDK/VungleSDK.h>

@interface ViewController ()<VungleSDKDelegate>

@property (nonatomic, strong) VungleSDK *sdk;

@property (nonatomic, strong) UIButton *goAds;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sdk = [VungleSDK sharedSDK];
    [self.sdk setDelegate:self];
    [self.sdk setLoggingEnabled:YES];
    NSError *error = nil;
    
    if(![self.sdk startWithAppId:@"5b74e2ae52c5170f6e95ebfa" error:&error]) {
        NSLog(@"Error while starting VungleSDK %@", [error localizedDescription]);
        
        return;
    }
    
}

- (UIButton *)goAds {
    
    if (!_goAds) {
        
        _goAds = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
        _goAds.backgroundColor = [UIColor redColor];
        
        [_goAds addTarget:self action:@selector(goAdsAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goAds;
}

- (void)goAdsAction {
    
    if ([self.sdk loadPlacementWithID:@"RE-2422419" error:nil]) {
        
        NSError *error = nil;
        
        [self.sdk playAd:self options:@{} placementID:@"RE-2422419" error:&error];
        
        if (error) {
            NSLog(@"Error encountered playing ad: %@", error);
        }
    }
}


- (void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(nullable NSString *)placementID error:(nullable NSError *)error;{
    
    if (!error) {
        
        NSLog(@"%@%@",placementID,@"已经准备好");
        
        [self.view addSubview:self.goAds];
    }
    
    NSLog(@"%@     %@   %@",NSStringFromSelector(_cmd),placementID,error);
    
}
- (void)vungleWillShowAdForPlacementID:(nullable NSString *)placementID;{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)vungleWillCloseAdWithViewInfo:(nonnull VungleViewInfo *)info placementID:(nonnull NSString *)placementID;{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)vungleDidCloseAdWithViewInfo:(nonnull VungleViewInfo *)info placementID:(nonnull NSString *)placementID;{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}


- (void)vungleSDKDidInitialize;{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}


- (void)vungleSDKFailedToInitializeWithError:(NSError *)error;{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}


@end
