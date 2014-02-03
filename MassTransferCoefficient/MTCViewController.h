//
//  MTCViewController.h
//  MassTransferCoefficient
//
//  Copyright (c) 2013 BeOriginal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTCViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *surfaceConcentrationSiText;
@property (nonatomic, strong) IBOutlet UILabel *alloyConcentrationSiLabel;
@property (nonatomic, strong) IBOutlet UILabel *particleRadiusLabel;
@property (strong, nonatomic) IBOutlet UILabel *resultCoefficientLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) IBOutlet UISlider *concentrationSlider;
@property (nonatomic, strong) IBOutlet UISlider *radiusSlider;

@property (nonatomic, strong) IBOutlet UIButton *calculationButton;

- (IBAction)calculateAlert;
- (IBAction)clear;
-(IBAction)concentrationSliderMoved:(UISlider *)sender;
-(IBAction)radiusSliderMoved:(UISlider *)sender;
- (IBAction)concentrationTextField:(UITextField *)sender;


@end
