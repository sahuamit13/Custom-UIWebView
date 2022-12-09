//
//  ViewController.swift
//  UIWebView
//
//  Created by amit sahu on 14/09/16.
//  Copyright © 2016 tpcg. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController{
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var barBackButton: UIBarButtonItem!
    @IBOutlet weak var barForwardButton: UIBarButtonItem!
    @IBOutlet weak var barReloadButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    let loadingKey = "loading"
    let estimatedProgressKey = "estimatedProgress"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "webview"
        // Do any additional setup after loading the view, typically from a nib.
        self.webView.navigationDelegate = self
        self.webView.addObserver(self, forKeyPath: self.loadingKey, options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: self.estimatedProgressKey, options: .new, context: nil)

        self.loadURL()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func loadURL(){
        if let url = URL(string: "https://developer.apple.com/"){
            let request = URLRequest(url: url)
            self.webView.load(request)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == self.loadingKey) {
            self.barBackButton?.isEnabled = webView.canGoBack
            self.barForwardButton?.isEnabled = webView.canGoForward
        }
        if (keyPath == self.estimatedProgressKey) {
            self.progressBar?.isHidden = webView?.estimatedProgress == 1
            self.progressBar?.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }

    @IBAction func barBackButtonAction(sender: AnyObject) {
        if self.webView.canGoBack {
            self.webView.goBack()
        }
    }
    
    @IBAction func barForwardButtonAction(sender: AnyObject) {
        if self.webView.canGoForward{
            self.webView.goForward()
        }
    }

    @IBAction func barReloadButtonAction(sender: AnyObject) {
        if let webUrl = webView.url{
            let request = URLRequest(url: webUrl)
            self.webView.load(request)
        }
    }
}

extension ViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.progressBar.setProgress(0.0, animated: false)
    }
}
