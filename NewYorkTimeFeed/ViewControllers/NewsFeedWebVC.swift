//
//  NewsFeedWebVC.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 10/06/22.
//

import WebKit
import UIKit

///Renders the web content of the news feed on WebView
class NewsFeedWebVC: UIViewController, WKNavigationDelegate {
  
  var webView: WKWebView!
  var urlString : String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let urlString = urlString {
      if  let url = URL(string: urlString) {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
      }
    }
  }
  
  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }
}
