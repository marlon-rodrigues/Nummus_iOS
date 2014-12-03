//
//  PieChartViewController.h
//  Nummus
//
//  Created by Marlon Geraldo Rodrigues Viana on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartViewController : UIView

//The graph gonna have the maximum of 4 values
@property(nonatomic) float graphValue1;
@property(nonatomic) float graphValue2;
@property(nonatomic) float graphValue3;
@property(nonatomic) float graphValue4;

- (void) setValuesForGraph:(float)value1 setGraphValue2:(float)value2 setGraphValue3:(float)value3 setGraphValue4:(float)value4;

@end
