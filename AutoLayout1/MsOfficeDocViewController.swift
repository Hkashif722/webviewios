//
//  MsOfficeDocViewController.swift
//  AutoLayout1
//
//  Created by Asif on 03/10/23.
//

import UIKit
import WebKit

class MsOfficeDocViewController: UIViewController, WKNavigationDelegate{

    var webView: WKWebView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView = WKWebView()
        webView.navigationDelegate = self

        // Load the PDF file
       
//        webView.isUserInteractionEnabled = false
//        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.panGestureRecognizer.isEnabled = true
        webView.scrollView.pinchGestureRecognizer?.isEnabled = true
        
        
        openWebViewer()
        
    }
    
    func openWebViewer() {
        view.addSubview(webView)
        
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
//        self.navigationItem.leftBarButtonItem = backButton
        DispatchQueue.main.async {
            if let url = self.url {
                let request = URLRequest(url: url)
                self.webView.load(request)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    // Show an activity indicator when the web view starts loading
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.center = webView.center
    activityIndicator.startAnimating()
    activityIndicator.tag = 100 // Assign a tag to the indicator for later removal
    view.addSubview(activityIndicator)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Hide the activity indicator when the web view finishes loading
        if let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView {
            activityIndicator.removeFromSuperview()
        }
    }
    

}
