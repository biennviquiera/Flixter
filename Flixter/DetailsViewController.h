//
//  DetailsViewController.h
//  Flixter
//
//  Created by Bienn Viquiera on 6/16/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *detailPoster;
@property (weak, nonatomic) IBOutlet UIImageView *detailBackdrop;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (nonatomic, strong) NSDictionary *passedObj;
@end

NS_ASSUME_NONNULL_END
