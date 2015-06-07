//
//  WELDataSource.m
//  WELCommand
//
//  Created by WELCommand on 15/5/31.
//  Copyright (c) 2015年 WELCommand. All rights reserved.
//

#import "WELDataSource.h"

@interface WELDataSource () {
    NSMutableArray *m_Models;
}

@end

@implementation WELDataSource


- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before {
    if(self = [super init]) {
        _cellIdentifier = identifier;
        _cellConfigureBefore = [before copy];
    }
    return self;
}

- (void)addModels:(NSArray *)models {
    if(!models) return;
    if(!m_Models) {
        m_Models = [[NSMutableArray alloc] init];
    }
    [m_Models addObjectsFromArray:models];
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return m_Models.count > indexPath.row ? m_Models[indexPath.row] : nil;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_Models == nil ? 0: m_Models.count;
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
    
    return cell;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return m_Models == nil ? 0: m_Models.count;
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
    return cell;
}

@end
