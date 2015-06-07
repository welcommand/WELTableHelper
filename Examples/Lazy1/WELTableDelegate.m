//
//  WELTableDelegate.m
//  WELCommand
//
//  Created by WELCommand on 15/6/6.
//  Copyright (c) 2015年 WELCommand. All rights reserved.
//

#import "WELTableDelegate.h"

@implementation WELTableDelegate

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    if([super respondsToSelector:aSelector]) {
        return self;
    } else if ([self.viewController respondsToSelector:aSelector]) {
        return self.viewController;
    }
    return self;
}


- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [super respondsToSelector:aSelector] || [self.viewController respondsToSelector:aSelector];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.viewController tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
