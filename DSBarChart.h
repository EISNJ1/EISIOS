//
//  DSBarChart.h
//  EISIOSApp
//
//  Created by vm mac on 15/10/16.
//  Copyright © 2016 EISPvtLtd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSBarChart : UIView
-(DSBarChart * )initWithFrame:(CGRect)frame
                        color:(UIColor*)theColor
                   references:(NSArray *)references
                    andValues:(NSArray *)values;
@property (atomic) int numberOfBars;
@property (atomic) float maxLen;
@property (atomic, strong) UIColor *color;
@property (atomic) NSArray* vals;
@property (atomic) NSArray* refs;
@end
