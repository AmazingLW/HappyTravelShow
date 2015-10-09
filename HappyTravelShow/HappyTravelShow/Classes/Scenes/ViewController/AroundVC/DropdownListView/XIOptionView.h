//  ddlt
//
//  Created by yxlong on 15/7/27.
//  Copyright (c) 2015年 QQ:854072335. All rights reserved.
//

#import "XIBorderSideView.h"
#import "XIDropdownlistViewProtocol.h"

@interface XIOptionView : XIBorderSideView<XIDropdownlistViewProtocol, UITableViewDataSource, UITableViewDelegate>
{
@public
    UITableView *_contentTable;
    NSArray *_selectionItems;
}


@end
