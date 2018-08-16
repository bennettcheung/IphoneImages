//
//  ViewController.m
//  IphoneImages
//
//  Created by Bennett on 2018-08-16.
//  Copyright © 2018 Bennett. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSArray *urlArray;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupURLs];
    [self loadImage]; // 5
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupURLs {
    self.urlArray = @[@"http://imgur.com/bktnImE.png",
                      @"http://imgur.com/zdwdenZ.png",
                      @"http://imgur.com/CoQ8aNl.png",
                      @"http://imgur.com/2vQtZBb.png",
                      @"http://imgur.com/y9MIaCS.png"
                      ];
    self.url = self.urlArray[0];
    
}


- (void)loadImage {
    NSURL *url = [NSURL URLWithString:self.url]; // 1
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
        }];
    }]; // 4
    
    [downloadTask resume];
}

- (IBAction)loadRandomImages:(UIButton *)sender {
    int arrayCount = (int)[self.urlArray count];
    int randomIndex = arc4random_uniform(arrayCount);
    self.url = self.urlArray[randomIndex];
    [self loadImage];
}

@end
