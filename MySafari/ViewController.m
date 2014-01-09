//
//  ViewController.m
//  MySafari
//
//  Created by Yash Varma on 1/9/14.
//
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIWebView *myWebView;
    __weak IBOutlet UITextField *myURLTextField;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UIActivityIndicatorView *activitySpinner;
    
}

@property (nonatomic, assign) NSInteger lastContentOffset;
@property (nonatomic, assign) NSURLRequest *request;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    myWebView.scrollView.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [activitySpinner stopAnimating];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to load webpage!" message:error. localizedDescription delegate:nil cancelButtonTitle:@"That Sucks" otherButtonTitles:@"Fine!", @"That does suck!", @"I Like Pie", nil];
    [alert show];
}

//Add http to URL when necessary:
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSString *myURLString = myURLTextField.text;
    NSURL *url;
    if ([myURLString hasPrefix:@"http://"]) {
        url = [NSURL URLWithString:textField.text];
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",myURLString]];
    }
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    

    [myWebView loadRequest:req];
    [textField resignFirstResponder];
    return YES;
}


//Make URL appear in text field, spinner starts animating
- (void)webViewDidStartLoad:(UIWebView *)webView {
     myURLTextField.text = [[myWebView.request URL] absoluteString];
    [activitySpinner startAnimating];
   
    
    //Make title appear in text field

titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
}
//When the page finishes loading, the spinner stops and hides
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [activitySpinner stopAnimating];
}

//Adds back button
- (IBAction)onBackButtonPressed:(id)sender {
    [myWebView goBack];
}

//Adds stop loading button
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    
    [myWebView stopLoading];
    
}


//Scrolling makes text field dissapear on reappear:

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.lastContentOffset > scrollView.contentOffset.y) {
        myURLTextField.alpha = ((scrollView.contentOffset.y)/10);
        
        
        
    } else if (self.lastContentOffset < scrollView.contentOffset.y){
          myURLTextField.alpha = (100/(scrollView.contentOffset.y));
        
    }
    
    
}


    //Add button with alert "Coming soon!"
- (IBAction)onComingSoonButtonPressed:(id)sender {
    
    UIAlertView *comingSoonAlert = [[UIAlertView alloc] initWithTitle:@"Coming soon!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [comingSoonAlert show];
    
    
}


- (IBAction)onForwardButtonPressed:(id)sender {
    [myWebView goForward];
}


- (IBAction)onReloadButtonPressed:(id)sender {
     [myWebView reload];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
