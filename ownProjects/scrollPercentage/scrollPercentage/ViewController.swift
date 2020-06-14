//
//  ViewController.swift
//  scrollPercentage
//
//  Created by Marina Beatriz Santana de Aguiar on 06.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    lazy var scrollView = webView.scrollView
    lazy var screenHeight = self.view.bounds.height
    lazy var scrollViewSize = scrollView.contentSize.height

    var webView: WKWebView!
    var alertController: UIAlertController!
    var progressView: UIProgressView!
    var progressBarButton: UIBarButtonItem!
    let websitesDict = ["Apple": "https://www.apple.com", "Google": "https://www.google.com"].sorted(by: {$0 < $1})

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain,
                                                            target: self, action: #selector(showAlertToOpenWebsite))
        
        alertController = UIAlertController(title: "Open Website", message: nil, preferredStyle: .actionSheet)
        for tuple in websitesDict {
            alertController.addAction(UIAlertAction(title: tuple.key, style: .default, handler: openWebsite))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        progressBarButton = UIBarButtonItem(customView: progressView)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        
        toolbarItems = [progressBarButton]
        navigationController?.isToolbarHidden = false
    }
    // Pay attentation that you don't pick the static method
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "URL" {
            var verifiedWebsite = false
            for website in  websitesDict {
                if website.value.contains(webView.url!.host!) {
                    verifiedWebsite = true
                    break
                }
            }
            if !verifiedWebsite {
                let warning = UIAlertController(title: "WARNING", message: "You are going to an unverified website", preferredStyle: .alert)
                warning.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(warning, animated: true)
            }
        }
    }
    
    @objc
    func showAlertToOpenWebsite() {
        present(alertController, animated: true)
    }
    
    func openWebsite(action: UIAlertAction) {
        title = action.title
        if let websiteKVPair = websitesDict.first(where: {$0.key == title}) {
            let url = URL(string: websiteKVPair.value)!
            webView.load(URLRequest(url: url))
            progressView.progress = 0
            scrollView.delegate = self
            return
        }
        print("Could not load the requested website")
    }
   
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !webView.isLoading {
            let distanceToOrigin = scrollView.contentOffset.y
            let approximateValue = (Double(distanceToOrigin) + Double(screenHeight)) / Double(scrollViewSize)
            //print(distanceToOrigin)
            //print(scrollViewSize)
            if approximateValue > 1 {
                progressView.progress = 1
                return
            }
            progressView.progress = Float(approximateValue)
        }
    }
}



