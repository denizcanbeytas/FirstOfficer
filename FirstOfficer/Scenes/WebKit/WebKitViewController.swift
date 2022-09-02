//
//  WebKitViewController.swift
//  FirstOfficer
//
//  Created by Deniz on 22.08.2022.
//

import UIKit
import WebKit

protocol WebKitDisplayLogic: AnyObject {
    
}

final class WebKitViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var interactor: WebKitBusinessLogic?
    var router: (WebKitRoutingLogic & WebKitDataPassing)?
    
    var progressView: UIProgressView!
    var webAddresses = ["mobven.com"]
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setURL()
        // setbarButtonItems()
        setBarButtonItemsTop()
        
    }
    
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = WebKitInteractor()
        let presenter = WebKitPresenter()
        let router = WebKitRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension WebKitViewController: WebKitDisplayLogic {
    
}

extension WebKitViewController: WKNavigationDelegate {
        
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        checkIndicatorIsAnimate(show: true)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        checkIndicatorIsAnimate(show: false)
        title = webView.title
    }
    
    func checkIndicatorIsAnimate(show: Bool) {
        show ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in webAddresses{
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
}

extension WebKitViewController {
    
    func setURL(){
        webView.navigationDelegate = self
        guard  let url = URL(string: "https://www.mobven.com") else {return}
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
    }

    // Items For the NavigationBar
    func setBarButtonItemsTop() {
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: webView, action: #selector(webView.goBack))
        //let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressItem = UIBarButtonItem(customView: progressView)
        
        navigationItem.rightBarButtonItems = [backButton,progressItem,refresh]
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress),options: .new, context: nil)
    }
    
    /* Items For the TabBar
     
     func setbarButtonItems(){
         let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
         let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
         let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: webView, action: #selector(webView.goBack))
         let forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrow.forward"), style: .done, target: webView, action: #selector(webView.goForward))
        
         
         progressView = UIProgressView(progressViewStyle: .default)
         progressView.sizeToFit()
         let progressItem = UIBarButtonItem(customView: progressView)

         toolbarItems = [backButton,forwardButton,spacer,progressItem,spacer, refresh]
         navigationController?.isToolbarHidden = false
         
         webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress),options: .new, context: nil)
     }
     
     
     */
}
