//
//  ViewController.swift
//  UIWebView
//
//  Created by amit sahu on 14/09/16.
//  Copyright © 2016 tpcg. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate {
    
  
    @IBOutlet weak var webView: UIWebView!
 
    @IBOutlet weak var myProgressView: UIProgressView!
    
    @IBOutlet weak var barBackButton: UIBarButtonItem!
    
    @IBOutlet weak var barForwardButton: UIBarButtonItem!
    @IBOutlet weak var barReloadButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var myTimer: NSTimer = NSTimer()
    var theBool: Bool = Bool()



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webView.delegate = self
        
      
        
        myProgressView.trackTintColor = UIColor.whiteColor()
        
        barBackButton.enabled = false
        barForwardButton.enabled = false
        
        webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        
        let url = NSURL(string: "http://example.com")
        let request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
        
        self.title = "webview"
        
        toolbar.shadowImageForToolbarPosition(UIBarPosition.Top)
        
    }

    override func viewDidAppear(animated: Bool) {
        webViewDidStartLoad(webView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerCallback(){
        
        if webView.canGoBack {
            barBackButton.enabled = true
        }
        
        if webView.canGoForward {
            barForwardButton.enabled = true
        }
       
        if theBool {
            if myProgressView.progress >= 1 {
                myProgressView.hidden = true
                myTimer.invalidate()
              
            }else{
                myProgressView.progress += 0.1
            }
        }else{
            myProgressView.progress += 0.05
            if myProgressView.progress >= 0.95 {
                myProgressView.progress = 0.95
            }
        }
        
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.myProgressView.hidden = false
        myProgressView.progress = 0.0
        theBool = false
        myTimer =  NSTimer.scheduledTimerWithTimeInterval(0.01667,target: self,selector: #selector(ViewController.timerCallback),userInfo: nil,repeats: true)
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
      
        self.theBool = true
    }
    
  
    @IBAction func barBackButtonAction(sender: AnyObject) {
        if webView.canGoBack {
             webView.goBack()
        }
       
    }
    
  
    @IBAction func barForwardButtonAction(sender: AnyObject) {
        if webView.canGoForward{
            webView.goForward()
        }
    }

    @IBAction func barReloadButtonAction(sender: AnyObject) {
        webView.reload()
    }
}

