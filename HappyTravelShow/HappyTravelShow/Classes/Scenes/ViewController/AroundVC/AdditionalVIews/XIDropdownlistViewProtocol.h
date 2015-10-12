//  ddlt
//
//  Created by yxlong on 15/7/27.
//  Copyright (c) 2015年 QQ:854072335. All rights reserved.
//

@protocol XIDropdownlistViewProtocol <NSObject>

@optional
@property(nonatomic, assign) NSInteger viewIndex;
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, copy) NSArray*(^fetchDataSource)(void);
@property(nonatomic, weak) id<XIDropdownlistViewProtocol> delegate;

- (void)didSelectItemAtIndex:(NSInteger)index inSegment:(NSInteger)segment;
@end
