//
//  ViewController.m
//  WELCommand
//
//  Created by WELCommand on 15/5/30.
//  Copyright (c) 2015年 WELCommand. All rights reserved.
//

#import "ViewController.h"
#import "WELDataSource.h"
#import "WELTableDelegate.h"

@interface ViewController ()<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) IBOutlet WELDataSource *dataDelegate;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [_dataDelegate addModels:@[@"a",@"b",@"c",@"d"]];
    [_table reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select");
}


@end
