//
//  WELWordCell+Configure.m
//  test_fount
//
//  Created by WELCommand on 15/6/8.
//  Copyright (c) 2015年 WELCommand. All rights reserved.
//

#import "WELWordCell+Configure.h"

@implementation WELWordCell (Configure)

-(void)configureCellWithModel:(id)model {
    self.wordLabel.text = model;
}

@end
