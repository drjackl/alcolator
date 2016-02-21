//
//  ViewController.m
//  Alcolator
//
//  Created by Jack Li on 2/20/16.
//  Copyright © 2016 Jack Li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender {
    NSString* enteredText = sender.text;
    float const enteredNumber = enteredText.floatValue;
    if (enteredNumber == 0) {
        sender.text = nil;
    }
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    // 1. calculate how much alcohol is in all those beers
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeer = 12; // assume they are 12 oz servings
    float alcoholPercentOfBeer = self.beerPercentTextField.text.floatValue / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeer * alcoholPercentOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    // 2. calculate wine equivalent of drinks
    float ouncesInOneWine = 5; // a wine glass is usually 5 oz
    float alcoholPercentOfWine = 0.13; // 13% is average
    float ouncesOfAlcoholPerWine = ouncesInOneWine * alcoholPercentOfWine;
    float numberOfWinesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWine;
    // 3. decide whether to use "beer"/"beers" and "glass"/"glasses"
    NSString* beerText = NSLocalizedString(@"beers", @"plural of beer");
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular of beer");
    }
    NSString* wineText = NSLocalizedString(@"glasses", @"plural of glass");
    if (numberOfWinesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular of glass");
    }
    // 4. generate the result text, and display it on the label
    NSString* resultText = [NSString stringWithFormat:
                            NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of wine.", nil),
                            numberOfBeers, beerText, self.beerPercentTextField.text.floatValue, numberOfWinesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
