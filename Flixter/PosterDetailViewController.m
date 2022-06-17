//
//  PosterDetailViewController.m
//  Flixter
//
//  Created by Bienn Viquiera on 6/17/22.
//

#import "PosterDetailViewController.h"

@interface PosterDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *posterSynopsis;

@end

@implementation PosterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.posterSynopsis.text = self.passedObj[@"overview"];
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
