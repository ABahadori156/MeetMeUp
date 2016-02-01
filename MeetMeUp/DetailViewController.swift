//
//  DetailViewController.swift
//  MeetMeUp
//
//  Created by Rafael Auriemo on 2/1/16.
//  Copyright © 2016 Rafael Auriemo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedEvent:NSDictionary?
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var eventDescriptionlabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
