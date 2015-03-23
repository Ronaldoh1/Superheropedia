//
//  ViewController.m
//  Superheropedia
//
//  Created by Ronald Hernandez on 3/23/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *superheroArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    self.superheroArray = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Batman",@"name", @"28", @"age",nil], [NSDictionary dictionaryWithObjectsAndKeys:@"Ironman",@"name", @"34", @"age", nil], nil];

    NSURL *url =[NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];

    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.superheroArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        [self.tableView reloadData];

         }];



}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];

    NSDictionary *dictionary = [self.superheroArray objectAtIndexedSubscript:indexPath.row];

    cell.textLabel.text = [dictionary objectForKey:@"name"];
    cell.detailTextLabel.text = [dictionary objectForKey:@"description"];
    cell.detailTextLabel.numberOfLines = 0;
    NSURL *url = [NSURL URLWithString:[dictionary objectForKey:@"avatar_url"]] ;
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.superheroArray.count;
}


@end
