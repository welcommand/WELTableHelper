//
//  WELDataSource.m
//  WELCommand
//
//  Created by WELCommand on 15/5/31.
//  Copyright (c) 2015年 WELCommand. All rights reserved.
//

#import "WELDataSource.h"

@interface WELDataSource ()

@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) NSMutableArray *stateModels;

@property (nonatomic, copy) CellEventIntermediary eventBlock;

@end

@implementation WELDataSource

- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before {
    return [self initWithIdentifier:identifier configureBlock:before stateModelClass:@""];
}

- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before stateModelClass:(NSString *)stateModelClass {
    if(self = [super init]) {
        _cellIdentifier = identifier;
        _cellConfigureBefore = [before copy];
        _cellStateModelClass = stateModelClass;
    }
    return self;
}

- (void)addModels:(NSArray *)models {
    if(!models) return;
    [self.models addObjectsFromArray:models];
    [self addStateModelsWithCount:models.count];
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return [self.models objectAtIndex:indexPath.row];
}

-(void)addStateModelsWithCount:(NSInteger)count{
    if(!_cellStateModelClass || [_cellStateModelClass isEqualToString:@""]) {
        return;
    }
    
    for(NSInteger i = 0 ; i < count; i++){
        Class sm = NSClassFromString(_cellStateModelClass);
        id smobj = [[sm alloc] init];
        [self.stateModels addObject:smobj];
    }
}

- (id)stateModelsAtIndexPath:(NSIndexPath *)indexPath {
    return [self.stateModels objectAtIndex:indexPath.row];
}

- (void)registEvenIntermediary:(CellEventIntermediary)block {
    self.eventBlock = block;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    
    
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    if ([cell respondsToSelector:@selector(configureCellWithModel:)]) {
        [cell performSelector:@selector(configureCellWithModel:) withObject:model];
    }
    
    if([cell respondsToSelector:@selector(configureCellStateWithModel:)]) {
        [cell performSelector:@selector(configureCellStateWithModel:) withObject:[self stateModelsAtIndexPath:indexPath]];
    }
    
    if([cell respondsToSelector:@selector(setEventIntermediary:)]) {
        [cell performSelector:@selector(setEventIntermediary:) withObject:self.eventBlock];
    }
    
    return cell;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    if ([cell respondsToSelector:@selector(configureCellWithModel:)]) {
        [cell performSelector:@selector(configureCellWithModel:) withObject:model];
    }
    
    if([cell respondsToSelector:@selector(configureCellStateWithModel:)]) {
        [cell performSelector:@selector(configureCellStateWithModel:) withObject:[self stateModelsAtIndexPath:indexPath]];
    }
    
    if([cell respondsToSelector:@selector(setEventIntermediary:)]) {
        [cell performSelector:@selector(setEventIntermediary:) withObject:self.eventBlock];
    }
    
    
    
    return cell;
}


#pragma mark-
#pragma mark- get/set

-(NSMutableArray *)models {
    if(!_models) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}

-(NSMutableArray *)stateModels {
    if(!_stateModels){
        _stateModels = [[NSMutableArray alloc] init];
    }
    return _stateModels;
}

-(void)setCellIdentifier:(NSString *)cellIdentifier {
    if(_cellIdentifier) return;
    _cellIdentifier = cellIdentifier;
}

-(void)setCellStateModelClass:(NSString *)cellStateModelClass {
    if(_cellStateModelClass) return;
    _cellStateModelClass = cellStateModelClass;
}

@end
