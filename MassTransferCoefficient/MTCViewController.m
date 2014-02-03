//
//  MTCViewController.m
//  MassTransferCoefficient
//
//  Copyright (c) 2013 BeOriginal. All rights reserved.
//

#import "MTCViewController.h"
#import "AboutViewController.h"

@interface MTCViewController ()

@end

@implementation MTCViewController {
    int currentConcent2Value;
    int currentRadiusValue;
    NSNumber *currentConcent1Value;
    double coefficient;
}

- (IBAction)concentrationSliderMoved:(UISlider *)sender
{
    currentConcent2Value = lroundf(sender.value);
    self.alloyConcentrationSiLabel.text = [NSString stringWithFormat:@"%d", currentConcent2Value];
}

- (IBAction)radiusSliderMoved:(UISlider *)sender
{
    currentRadiusValue = lroundf(sender.value);
    self.particleRadiusLabel.text = [NSString stringWithFormat:@"%d", currentRadiusValue];
}

- (IBAction)concentrationTextField:(UITextField *)text
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    currentConcent1Value = [f numberFromString:self.surfaceConcentrationSiText.text];
}

- (void)updateLabels
{
    self.surfaceConcentrationSiText.text = [NSString stringWithFormat:@""];
    self.alloyConcentrationSiLabel.text = [NSString stringWithFormat:@"%d", currentConcent2Value];
    self.particleRadiusLabel.text = [NSString stringWithFormat:@"%d", currentRadiusValue];
    self.resultCoefficientLabel.text = [NSString stringWithFormat:@""];
}

- (void)start
{
    currentConcent2Value = 10;
    currentRadiusValue = 150;
    
    self.concentrationSlider.value = currentConcent2Value;
    self.radiusSlider.value = currentRadiusValue;
    
    self.resultCoefficientLabel.hidden = YES;
    self.titleLabel.hidden = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    [self start];
    [self updateLabels];
}

- (IBAction)clear
{
    [self start];
    [self updateLabels];
}

- (void)estimation
{
    double g = 9.81;
    double nu = 0.000005091;
    double D = 0.000000016;
    double prom, prom2, prom3;
    prom = (1000000000 * g * ([currentConcent1Value doubleValue] - currentConcent2Value) / (currentRadiusValue * nu * currentConcent2Value));
    prom2 = pow(prom, 0.25);
    prom3 = pow(D, 0.75);
    coefficient = 0.54 * prom2 * prom3;
}

- (void)alertMessage
{
    NSString *message;
    NSString *title;
    
    if ([self.surfaceConcentrationSiText.text isEqualToString:@""]) {
        message = [NSString stringWithFormat:@"Введите концентрацию кремния на поверхности частицы"];
        title = [NSString stringWithFormat:@"ОШИБКА"];
    } else {
        
        if ([currentConcent1Value doubleValue] < currentConcent2Value) {
            message = [NSString stringWithFormat:@"Концентрация кремния в расплаве не может превышать его концентрацию на поверхности частицы"];
            title = [NSString stringWithFormat:@"ОШИБКА"];
        } else {
            
            self.resultCoefficientLabel.hidden = NO;
            self.titleLabel.hidden = NO;
            
            self.resultCoefficientLabel.text = [NSString stringWithFormat:@"%.8f", coefficient];
            message = [NSString stringWithFormat:@"Коэффициент массоотдачи равен: \n%.8f", coefficient];
            title = [NSString stringWithFormat:@"РЕЗУЛЬТАТ"];
        }
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)calculateAlert
{
    [self estimation];
    [self alertMessage];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showInfo"]) {
        UINavigationController *navController = segue.destinationViewController;
        AboutViewController *controller = (AboutViewController *) navController.topViewController;
    }
}

@end
