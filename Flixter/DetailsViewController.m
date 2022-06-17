//
//  DetailsViewController.m
//  Flixter
//
//  Created by Bienn Viquiera on 6/16/22.
//
#import "UIKit+AFNetworking.h"
#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //set the detailed synopsis text
    self.synopsisLabel.text = self.passedObj[@"overview"];
    
    self.titleLabel.text = self.passedObj[@"title"];
    //set the poster image
    //grab poster image
    NSString *urlString = self.passedObj[@"poster_path"];
    NSLog(@"%s%@", "https://www.themoviedb.org/t/p/w440_and_h660_face", urlString);

    //set poster image
    NSString *newString = [NSString stringWithFormat:@"%s%@", "https://www.themoviedb.org/t/p/w440_and_h660_face", urlString];
    NSURL *posterlink = [NSURL URLWithString:newString];
    [self.detailPoster setImageWithURL:posterlink];
    
    //set the backdrop image
    //grab backdrop image
    NSString *urlStringbd = self.passedObj[@"backdrop_path"];
    NSLog(@"%s%@", "https://www.themoviedb.org/t/p/w440_and_h660_face", urlStringbd);

    //set poster image
    NSString *newStringbd = [NSString stringWithFormat:@"%s%@", "https://www.themoviedb.org/t/p/w533_and_h300_bestv2/", urlStringbd];
    NSURL *posterlinkbd = [NSURL URLWithString:newStringbd];
    [self.detailBackdrop setImageWithURL:posterlinkbd];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
