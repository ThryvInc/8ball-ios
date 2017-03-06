//
//  ViewController.m
//  8 Ball of Love
//
//  Created by Elliot Schrock on 2/13/17.
//  Copyright © 2017 Thryv, Inc. All rights reserved.
//

#import "ViewController.h"
#import "UIWindow+DHCShakeRecognizer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *eightView;
@property (weak, nonatomic) IBOutlet UIView *affirmationView;
@property (weak, nonatomic) IBOutlet UILabel *affirmationLabel;
@property (nonatomic) NSArray *affirmations;
@end

static CGFloat const AnimationDuration = .5;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShake) name:DHCSHakeNotificationName object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DHCSHakeNotificationName object:nil];
}

- (void)setupViews
{
    self.eightView.layer.cornerRadius = self.eightView.bounds.size.width / 2;
    self.affirmationView.layer.borderWidth = 1;
    self.affirmationView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.affirmationView.layer.cornerRadius = 4;
    self.affirmationView.clipsToBounds = YES;
}

- (void)didShake
{
    [self performRotateOut];
    [self performFadeOutWithCompletion:^{
        self.affirmationLabel.text = self.affirmations[arc4random() % self.affirmations.count];
        [self performFadeIn];
        [self performRotateIn];
    }];
}

- (void)performFadeOutWithCompletion:(void(^)())completion
{
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.affirmationLabel.alpha = 0;
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)performFadeIn
{
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.affirmationLabel.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)performRotateOut
{
    [UIView animateWithDuration:AnimationDuration animations:^{
        float degrees = 20 * pow(-1, arc4random() % 2);
        self.affirmationLabel.transform = CGAffineTransformMakeRotation(degrees * M_PI/180);
    }];
}

- (void)performRotateIn
{
    float degrees = 20 * pow(-1, arc4random() % 2);
    self.affirmationLabel.transform = CGAffineTransformMakeRotation(degrees * M_PI/180);
    [UIView animateWithDuration:AnimationDuration animations:^{
        float degrees = 0; //the value in degrees
        self.affirmationLabel.transform = CGAffineTransformMakeRotation(degrees * M_PI/180);
    }];
}

- (NSArray *)affirmations
{
    if (!_affirmations) {
        _affirmations = @[@"You are in control",
                          @"People like you",
                          @"You will get through this",
                          @"You are free",
                          @"You can do what you want",
                          @"You have power",
                          @"You are safe",
                          @"You are in charge of your life",
                          @"You are in control of your life",
                          @"There are people who love you",
                          @"The world is, by and large, good",
                          @"You have agency",
                          @"You can figure things out",
                          @"There are reasons to be joyful",
                          @"You are good at things",
                          @"People rely on you",
                          @"You are good",
                          @"You make a difference",
                          @"People appreciate you",
                          @"You are important",
                          @"You are cared about",
                          @"There is someone looking out for you",
                          @"You can change your life",
                          @"Good things happen to you",
                          @"You are allowed to be happy",
                          @"Things are going well",
                          @"Things keep getting better",
                          @"The rain is gone",
                          @"It\'s gonna be a sunshiney day",
                          @"You are loved",
                          @"Life is wonderful"];
    }
    return _affirmations;
}

@end
