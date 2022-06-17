//
//  MovieViewController.m
//  Flixter
//
//  Created by Bienn Viquiera on 6/15/22.
//

#import "UIKit+AFNetworking.h"
#import "MovieViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "AFNetworkReachabilityManager.h"

@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 150;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //check for internet connectivity
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//
//    if (![AFNetworkReachabilityManager sharedManager].reachable) {
//
//    }
    
    
    // Do any additional setup after loading the view.
    //calls method to set up the data fetching
    
    [self.activityIndicator startAnimating];
    [self beginRefresh];

    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];

    self.refreshControl = [[UIRefreshControl alloc] init];
    //addtarget used to actually update
    [self.refreshControl addTarget:self action:@selector(beginRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex: 0];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"overview"];
    
    //grab poster image
    NSString *urlString = movie[@"poster_path"];
    NSLog(@"%s%@", "https://www.themoviedb.org/t/p/w440_and_h660_face", urlString);

    //set poster image
    NSString *newString = [NSString stringWithFormat:@"%s%@", "https://www.themoviedb.org/t/p/w440_and_h660_face", urlString];
    NSURL *posterlink = [NSURL URLWithString:newString];
    [cell.posterImage setImageWithURL:posterlink];

    return cell;
}


// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh {

    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=970b50d94a74e5c0b1b27b01913c2d57"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               NSLog(@"not reachable");
               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
                                          message:@"The internet connections seems dead bruh."
                                          preferredStyle:UIAlertControllerStyleAlert];

               UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction * action) {
                   [self viewDidLoad];
               }];

               [alert addAction:defaultAction];
               [self presentViewController:alert animated: YES completion: nil];
               
               [self.refreshControl endRefreshing];
               [self.activityIndicator stopAnimating];

           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               NSLog(@"%@", dataDictionary);// log an object with the %@ formatter.
               
               // TODO: Get the array of movies
               for (id object in self.movies) {
                   // do something with object
                   NSLog(@"%@",object);
               }
               // TODO: Store the movies in a property to use elsewhere
               self.movies = dataDictionary[@"results"];
               // TODO: Reload your table view data
               [self.tableView reloadData];
               
               [self.activityIndicator stopAnimating];
           }
        [self.refreshControl endRefreshing];

       }];
    [task resume];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
    NSDictionary *dataToPass = self.movies[myIndexPath.row];
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.passedObj = dataToPass;
    //NSLog(detailVC.passedObj);

    
    
    // Pass the selected object to the new view controller.
}

@end
