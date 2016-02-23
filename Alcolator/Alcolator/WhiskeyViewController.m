//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Jack Li on 2/21/16.
//  Copyright © 2016 Jack Li. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (void) buttonPressed:(UIButton*)sender {
    [self.beerPercentTextField resignFirstResponder];
    // 1. calculate oz. of alcohol of beers
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeer = 12; // assume 12 oz beer bottles
    
    float alcoholPercentOfBeer = self.beerPercentTextField.text.floatValue / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeer * alcoholPercentOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    // 2. calculate number of whiskey shots
    float ouncesInOneWhiskey = 1; // a 1 oz shot
    float alcoholPercentOfWhiskey = 0.4; // 40% is average
    
    float ouncesOfAlcoholPerWhiskey = ouncesInOneWhiskey * alcoholPercentOfWhiskey;
    float numberOfWhiskeysForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskey;
    // 3. singular/plural formatting
    NSString* beerText = NSLocalizedString(@"beers", @"plural of beer");
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    }
    NSString* whiskeyText = [self servingTextPluralGivenNumber:numberOfWhiskeysForEquivalentAlcoholAmount];
    // 4. generate and display result
    NSString* resultText = [NSString stringWithFormat:
                            NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of whiskey.", nil),
                            numberOfBeers, beerText, self.beerPercentTextField.text.floatValue, numberOfWhiskeysForEquivalentAlcoholAmount, whiskeyText];
    self.resultLabel.text = resultText;
}

- (NSString*) servingTextPlural:(BOOL)isPlural {
    if (isPlural) {
        return NSLocalizedString(@"shots", @"plural of shot");
    } else {
        return NSLocalizedString(@"shot", @"singular shot");
    }
}

@end
