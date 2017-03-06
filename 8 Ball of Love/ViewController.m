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
                          @"People do like you",
                          @"You will get through this",
                          @"You are free",
                          @"You can do what you want",
                          @"You will reach your goal-believe",
                          @"You are not alone",
                          @"Listen to your quiet voice within",
                          @"Your life makes a difference",
                          @"Your work is important",
                          @"You are needed",
                          @"You can change your mind",
                          @"Evil fails where there is love",
                          @"Your answers are in your heart",
                          @"You are surrounded by love",
                          @"You are surrounded by opportunity",
                          @"It\'s ok to rest and care for yourself",
                          @"You have power",
                          @"You deserve to be loved",
                          @"You can take a different path",
                          @"Let go a little and trust in others",
                          @"You are safe",
                          @"You are wanted",
                          @"You will figure things out",
                          @"You are in charge of your life",
                          @"You are in control of your life",
                          @"There are people who love you",
                          @"You do more good than you know",
                          @"The world is mostly a safe place",
                          @"Take a moment to enjoy the sky",
                          @"Take a moment to breathe",
                          @"You have agency",
                          @"You can figure things out",
                          @"There are reasons to be joyful",
                          @"There are reasons to be grateful",
                          @"Trust that you will be alright",
                          @"You are good at things",
                          @"Things go right more than go wrong",
                          @"People rely on you",
                          @"You are good",
                          @"You do make a difference",
                          @"People do appreciate you",
                          @"You are important",
                          @"You are cared about",
                          @"There is someone looking out for you",
                          @"You can change your life",
                          @"Good things happen to you",
                          @"Good things will happen again",
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
