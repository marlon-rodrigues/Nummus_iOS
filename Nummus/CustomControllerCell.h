//
//  CustomControllerCell.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomControllerCell : UITableViewCell

@property(nonatomic, retain)UILabel *categoryLabel;
@property(nonatomic, retain)UILabel *dateLabel;
@property(nonatomic, retain)UILabel *amountLabel;
@property(nonatomic, retain)UILabel *accountLabel;

@property(nonatomic)int kindOfCell;

//Change the initializer so it can determine how many itens will be on the cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier numberOfItens:(int)number;

@end
