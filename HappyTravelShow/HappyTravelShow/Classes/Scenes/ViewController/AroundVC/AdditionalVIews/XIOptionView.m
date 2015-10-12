//  ddlt
//
//  Created by yxlong on 15/7/27.
//  Copyright (c) 2015年 QQ:854072335. All rights reserved.
//


#import "XIOptionView.h"
#import "XIColorHelper.h"

#define kCellHeight 40

@implementation XIOptionView
@synthesize selectedIndex=_selectedIndex;
@synthesize fetchDataSource=_fetchDataSource;
@synthesize delegate=_delegate;
@synthesize viewIndex;

- (void)dealloc
{
    self.delegate = nil;
    self.fetchDataSource = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        
        _contentTable = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _contentTable.dataSource = self;
        _contentTable.delegate = self;
        _contentTable.separatorColor = [XIColorHelper SeparatorLineColor];
        [self addSubview:_contentTable];
        _contentTable.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        if([_contentTable respondsToSelector:@selector(setSeparatorInset:)]){
            _contentTable.separatorInset = UIEdgeInsetsZero;
        }
        if([_contentTable respondsToSelector:@selector(setLayoutMargins:)]){
            _contentTable.layoutMargins = UIEdgeInsetsZero;
        }
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)index
{
    _selectedIndex = index;
    [_contentTable reloadData];
    if([_delegate respondsToSelector:@selector(didSelectItemAtIndex:inSegment:)]){
        [_delegate didSelectItemAtIndex:index inSegment:self.viewIndex];
    }
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        cell.separatorInset = UIEdgeInsetsZero;
    }
    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(_selectionItems==nil){
        if(_fetchDataSource){
            _selectionItems = _fetchDataSource();
        }
    }
    return _selectionItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.textColor = [UIColor opaqueColorWithRGBBytes:0x333333];
    cell.textLabel.highlightedTextColor = [XIColorHelper ThemeColor];
    cell.textLabel.text = _selectionItems[indexPath.row];
    if(_selectedIndex==indexPath.row){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.highlighted = YES;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.highlighted = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_selectedIndex==indexPath.row){
        return;
    }
    _selectedIndex = indexPath.row;
    [tableView reloadData];
    
    if([_delegate respondsToSelector:@selector(didSelectItemAtIndex:inSegment:)]){
        [_delegate didSelectItemAtIndex:indexPath.row inSegment:self.viewIndex];
    }
}


@end
