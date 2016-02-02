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
        navigationItem.title = selectedEvent?.objectForKey("name") as? String
        let rsvpCount:NSNumber = selectedEvent?.objectForKey("yes_rsvp_count") as! NSNumber
        let rsvpCountAsString:String = String(format:"%@", rsvpCount)
        let eventDescription:String = (selectedEvent?.objectForKey("description") as? String)!
        countLabel.text = rsvpCountAsString
        eventDescriptionlabel.text = eventDescription
        hostLabel.text = selectedEvent?.objectForKey("venue")?.objectForKey("name") as? String
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as? webVC
        destVC?.eventDictionary = selectedEvent
    }
}
