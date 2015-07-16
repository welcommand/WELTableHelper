//
//  WELCellConfigure.h
//  WELCommand
//
//  Created by WELCommand on 15/6/7.
//  Copyright (c) 2015年 WELCommand. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void (^ CellEventIntermediary)(NSString *eventID,id sender);

@protocol WELCellConfigure <NSObject>


-(void)configureCellWithModel:(id)model;

@optional
//------state
-(void)configureCellStateWithModel:(id)stateModel;

//-------event
@property (nonatomic, copy) CellEventIntermediary eventIntermediary;


@end
