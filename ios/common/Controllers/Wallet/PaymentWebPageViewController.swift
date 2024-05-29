//
//  PaymentWebPageViewController.swift
//  rider
//
//  Created by Manly Man on 9/10/20.
//  Copyright © 2020 minimal. All rights reserved.
//

import UIKit
import WebKit

public class PaymentWebPageViewController: UIViewController, WKNavigationDelegate {
    private let webView = WKWebView(frame: .zero)
    var url: String = ""
    weak var delegate: WebPaymentResultDelegate?
    var tokenstr: String = ""
    var transactionID: String = ""
    override public func viewDidLoad() {
        super.viewDidLoad()
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webView)
        // You can set constant space for Left, Right, Top and Bottom Anchors
        NSLayoutConstraint.activate([
            self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
        // For constant height use the below constraint and set your height constant and remove either top or bottom constraint
        //self.webView.heightAnchor.constraint(equalToConstant: 200.0),
        
        self.view.setNeedsLayout()
        self.webView.navigationDelegate = self
        let request = URLRequest(url: URL.init(string: url)!)
        self.webView.load(request)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor
           navigationAction: WKNavigationAction,
           decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {

        let url = navigationAction.request.url!.absoluteString
        print("url",url)
        
        let result = extractTokenAndPayerID(from: url)

        if let token = result.token, let payerID = result.payerID {
            print("Token: \(token)")
            print("PayerID: \(payerID)")
            tokenstr = token
            transactionID = payerID
            
        } else {
            print("Token or PayerID not found")
        }
        
        
        if isUrlVerify(url: url) || isUrlCancel(url: url) {
            if let del = delegate {
                if isUrlVerify(url: url) {
                    del.paid(token: tokenstr, transactonID: transactionID)
                } else {
                    del.canceled()
                }
            }
            decisionHandler(.cancel)
            dismiss(animated: true, completion: nil)
            return
        }
        decisionHandler(.allow)
    }
    
    func isUrlVerify(url: String) -> Bool {
        return url.contains("ridyverifiedpayment")
    }
    
    func isUrlCancel(url: String) -> Bool {
        return url.contains("ridycancelpayment")
        
    }
    func extractTokenAndPayerID(from urlString: String) -> (token: String?, payerID: String?) {
        guard let url = URL(string: urlString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return (nil, nil)
        }
        
        var token: String?
        var payerID: String?
        
        for queryItem in queryItems {
            if queryItem.name == "token" {
                token = queryItem.value
            } else if queryItem.name == "PayerID" {
                payerID = queryItem.value
            }
        }
        
        return (token, payerID)
    }

}

protocol WebPaymentResultDelegate: AnyObject {
    func paid(token:String , transactonID :String)
    func canceled()

}
