//
//  webVC.swift
//  MeetMeUp
//
//  Created by Aaron B on 2/1/16.
//  Copyright © 2016 Rafael Auriemo. All rights reserved.
//

import UIKit

class webVC: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var eventDictionary:NSDictionary?
    override func viewDidLoad() {
        super.viewDidLoad()
        let eventUrlString:String = (eventDictionary?.objectForKey("event_url") as? String)!
        let homeUrl = NSURL(string: eventUrlString)
        let urlRequest = NSURLRequest(URL: homeUrl!)
        webView.loadRequest(urlRequest)
    }
}
