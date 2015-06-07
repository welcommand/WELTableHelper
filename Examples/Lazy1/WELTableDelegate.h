//
//  WELTableDelegate.h
//  WELCommand
//
//  Created by WELCommand on 15/6/6.
//  Copyright (c) 2015年 WELCommand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WELTableDelegate : NSObject <UITableViewDelegate>

@property (nonatomic, weak) IBOutlet id <UITableViewDelegate>viewController;

@end
