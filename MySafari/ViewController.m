//
//  ViewController.m
//  MySafari
//
//  Created by Yash Varma on 1/9/14.
//
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
{
    __weak IBOutlet UIWebView *myWebView;
    __weak IBOutlet UITextField *myURLTextField;
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSURL *url = [NSURL URLWithString: myURLTextField.text];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:req];
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)onBackButtonPressed:(id)sender {
    [myWebView goBack];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    
    [myWebView stopLoading];
    
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
