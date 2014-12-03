//
//  CustomControllerCell.m
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomControllerCell.h"

@implementation CustomControllerCell

@synthesize categoryLabel = _categoryLabel;
@synthesize dateLabel = _dateLabel;
@synthesize amountLabel = _amountLabel;
@synthesize accountLabel = _accountLabel;
@synthesize kindOfCell = _kindOfCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier numberOfItens:(int)number
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        
        //1 - 4 text cells
        //Other - 2 text cells
        if (number == 1)
        {
            _categoryLabel = [[UILabel alloc]init];
            _categoryLabel.textAlignment = UITextAlignmentLeft;
            _categoryLabel.font = [UIFont boldSystemFontOfSize:14];
            _categoryLabel.backgroundColor = [UIColor clearColor];
            
            _dateLabel = [[UILabel alloc]init];
            _dateLabel.textAlignment = UITextAlignmentLeft;
            _dateLabel.font = [UIFont systemFontOfSize:11];
            _dateLabel.backgroundColor = [UIColor clearColor];
            
            _amountLabel = [[UILabel alloc]init];
            _amountLabel.textAlignment = UITextAlignmentRight;
            _amountLabel.font = [UIFont boldSystemFontOfSize:13];
            _amountLabel.backgroundColor = [UIColor clearColor];
            
            _accountLabel = [[UILabel alloc]init];
            _accountLabel.textAlignment = UITextAlignmentRight;
            _accountLabel.font = [UIFont systemFontOfSize:11];
            _accountLabel.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_categoryLabel];
            [self.contentView addSubview:_dateLabel];
            [self.contentView addSubview:_amountLabel];
            [self.contentView addSubview:_accountLabel];
        }
        else 
        {
            _categoryLabel = [[UILabel alloc]init];
            _categoryLabel.textAlignment = UITextAlignmentLeft;
            _categoryLabel.font = [UIFont boldSystemFontOfSize:17];
            _categoryLabel.backgroundColor = [UIColor clearColor];
            
            _amountLabel = [[UILabel alloc]init];
            _amountLabel.textAlignment = UITextAlignmentRight;
            _amountLabel.font = [UIFont boldSystemFontOfSize:17];
            _amountLabel.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:_categoryLabel];
            [self.contentView addSubview:_amountLabel];
        }
        
        self.kindOfCell = number;
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    if (self.kindOfCell == 1)
    {
        frame = CGRectMake(boundsX+20, 0, 200, 25);
        _categoryLabel.frame = frame;
        
        frame = CGRectMake(boundsX+20, 20, 100, 20);
        _dateLabel.frame = frame;
        
        frame = CGRectMake(boundsX+150, 0, 100, 25);
        _amountLabel.frame = frame;
        
        frame = CGRectMake(boundsX+150, 20, 100, 20);
        _accountLabel.frame = frame;  
    }
    else
    {
        frame = CGRectMake(boundsX+20, 10, 200, 25);
        _categoryLabel.frame = frame;
        
        frame = CGRectMake(boundsX+120, 10, 150, 25);
        _amountLabel.frame = frame;
    }
}

@end
