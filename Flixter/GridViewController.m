//
//  GridViewController.m
//  Flixter
//
//  Created by Bienn Viquiera on 6/17/22.
//

#import "GridViewController.h"
#import "GridViewCell.h"
#import "UIKit+AFNetworking.h"
#import "PosterDetailViewController.h"


@interface GridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *gridCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *moviesPoster;
@property (nonatomic, strong) NSArray *movies;
@end

@implementation GridViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gridCollectionView.dataSource = self;
    self.gridCollectionView.delegate = self;
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    
    // Do any additional setup after loading the view.
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=970b50d94a74e5c0b1b27b01913c2d57"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               NSLog(@"not reachable");
//               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
//                                          message:@"The internet connections seems dead bruh."
//                                          preferredStyle:UIAlertControllerStyleAlert];
//
//               UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault
//                                              handler:^(UIAlertAction * action) {
//                   [self viewDidLoad];
//               }];
//
//               [alert addAction:defaultAction];
//               [self presentViewController:alert animated: YES completion: nil];
//
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               
               // TODO: Get the array of movies
               // TODO: Store the movies in a property to use elsewhere
               self.movies = dataDictionary[@"results"];
               // TODO: Reload your table view data
               [self.gridCollectionView reloadData];
               
           }
       }];
    [task resume];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //store index path of movie to pass data of
    NSIndexPath *myIndexPath = [self.collectionView indexPathForCell:sender];
    //store object of movie
    NSDictionary *dataToPass = self.movies[myIndexPath.row];
    //define reference to segue
    PosterDetailViewController *detailVC = [segue destinationViewController];
    //pass the object
    detailVC.passedObj = dataToPass;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    // Configure the cell
    //get the movie from the array
    NSDictionary *movie = self.movies[indexPath.row];
    
    //grab poster image
    NSString *urlString = movie[@"poster_path"];
    NSLog(@"%s%@", "https://www.themoviedb.org/t/p/w440_and_h660_face", urlString);

    //set poster image
    NSString *newString = [NSString stringWithFormat:@"%s%@", "https://www.themoviedb.org/t/p/w440_and_h660_face", urlString];
    NSURL *posterlink = [NSURL URLWithString:newString];
    [cell.gridImage setImageWithURL:posterlink];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
