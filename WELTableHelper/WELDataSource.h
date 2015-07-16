//
//  WELDataSource.h
//  WELCommand
//
//  Created by WELCommand on 15/5/31.
//  Copyright (c) 2015年 WELCommand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WELCellConfigure.h"

typedef void (^CellConfigureBefore)(id cell, id model, NSIndexPath * indexPath);

@interface WELDataSource : NSObject <UITableViewDataSource,UICollectionViewDataSource>

//--------- For Code
- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before;

- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before stateModelClass:(NSString *)stateModelClass;

//--------- For StoryBoard not use in code

@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;
@property (nonatomic, strong) IBInspectable NSString *cellStateModelClass;
@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;

//---------Public

- (void)addModels:(NSArray *)models;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;

- (void)registEvenIntermediary:(CellEventIntermediary)block;

@end