//
//  ViewController.m
//  StickMan
//
//  Created by Alaa Awad on 5/28/17.
//  Copyright © 2017 Alaa Awad. All rights reserved.
//

#import "ViewController.h"

#define kHeadInitialPosition CGRectMake(135, 100, 50, 50)
#define kTorsoInitialPosition CGRectMake(155, 150, 10, 100)
#define kUpperLegInitialPosition CGRectMake(140, 250, 40, 10)
#define kLeftLegInitialPosition CGRectMake(130, 250, 10, 40)
#define kRightLegInitialPosition CGRectMake(180, 250, 10, 40)
#define kLeftUpperArmInitialPosition CGRectMake(115, 170, 40, 10)
#define kRightUpperArmInitialPosition CGRectMake(165, 170, 40, 10)
#define kLeftLowerArmInitialPosition CGRectMake(105, 170, 10, 40)
#define kRightLowerArmInitialPosition CGRectMake(205, 170, 10, 40)

@interface ViewController ()

@property (nonatomic, strong) NSArray *bodyParts;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;

@property (nonatomic, strong) UIView *head;
@property (nonatomic, strong) UIView *torso;
@property (nonatomic, strong) UIView *upperLegs;
@property (nonatomic, strong) UIView *leftLeg;
@property (nonatomic, strong) UIView *rightLeg;
@property (nonatomic, strong) UIView *upperLeftArm;
@property (nonatomic, strong) UIView *upperRightArm;
@property (nonatomic, strong) UIView *lowerLeftArm;
@property (nonatomic, strong) UIView *lowerRightArm;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createBlockMan];
    [self createWalls];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(tapRecognized:)];
    [self.view addGestureRecognizer:tap];
}

- (void) tapRecognized: (UITapGestureRecognizer *) sender
{
    CGPoint tapPoint = [sender locationInView:self.view];
    CGVector direction = CGVectorMake((tapPoint.x - self.view.center.x)
                                      / (self.view.frame.size.width / 2),
                                      (tapPoint.y - self.view.center.y)
                                      / (self.view.frame.size.height / 2));
    [self changeGravityDirection:direction];
}

- (void) changeGravityDirection: (CGVector) direction
{
    self.gravity.gravityDirection = direction;
    
    if (!self.gravity.dynamicAnimator)
        [self.animator addBehavior:self.gravity];
}

- (UIGravityBehavior *) gravity
{
    if (!_gravity)
        _gravity = [[UIGravityBehavior alloc] initWithItems:self.bodyParts];
    
    return _gravity;
}

- (UIDynamicAnimator *) animator
{
    if (!_animator)
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    return _animator;
}

- (void) createBlockMan
{
    self.head = [[UIView alloc] initWithFrame:kHeadInitialPosition];
    [self.view addSubview:self.head];
    
    UIView *leftEye = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 5, 5)];
    leftEye.backgroundColor = [UIColor whiteColor];
    [self.head addSubview:leftEye];
    
    UIView *rightEye = [[UIView alloc] initWithFrame:CGRectMake(30, 15, 5, 5)];
    rightEye.backgroundColor = [UIColor whiteColor];
    [self.head addSubview:rightEye];
    
    UIView *mouth = [[UIView alloc] initWithFrame:CGRectMake(15, 35, 20, 3)];
    mouth.backgroundColor = [UIColor whiteColor];
    [self.head addSubview:mouth];
    
    self.torso = [[UIView alloc] initWithFrame:kTorsoInitialPosition];
    [self.view addSubview:self.torso];
    
    self.upperLegs = [[UIView alloc] initWithFrame:kUpperLegInitialPosition];
    [self.view addSubview:self.upperLegs];
    
    self.leftLeg = [[UIView alloc] initWithFrame:kLeftLegInitialPosition];
    [self.view addSubview:self.leftLeg];
    
    self.rightLeg = [[UIView alloc] initWithFrame:kRightLegInitialPosition];
    [self.view addSubview:self.rightLeg];
    
    self.upperLeftArm = [[UIView alloc]
                         initWithFrame:kLeftUpperArmInitialPosition];
    [self.view addSubview:self.upperLeftArm];
    
    self.upperRightArm = [[UIView alloc]
                          initWithFrame:kRightUpperArmInitialPosition];
    [self.view addSubview:self.upperRightArm];
    
    self.lowerLeftArm = [[UIView alloc]
                         initWithFrame:kLeftLowerArmInitialPosition];
    [self.view addSubview:self.lowerLeftArm];
    
    self.lowerRightArm = [[UIView alloc]
                          initWithFrame:kRightLowerArmInitialPosition];
    [self.view addSubview:self.lowerRightArm];
    
    self.bodyParts = @[self.head,
                       self.torso,
                       self.upperLegs,
                       self.leftLeg,
                       self.rightLeg,
                       self.upperLeftArm,
                       self.upperRightArm,
                       self.lowerLeftArm,
                       self.lowerRightArm];
    
    [self.bodyParts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, 
                                                 BOOL *stop) {
        [(UIView *)obj setBackgroundColor:[UIColor blackColor]];
    }];
}


- (void) createWalls
{
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]
                                              initWithItems:self.bodyParts];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
}
@end