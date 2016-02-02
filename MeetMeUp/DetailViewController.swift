//
//  DetailViewController.swift
//  MeetMeUp
//
//  Created by Rafael Auriemo on 2/1/16.
//  Copyright © 2016 Rafael Auriemo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var eventDescriptionlabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    
    var selectedEvent:NSDictionary?
    var commentsArray:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = selectedEvent?.objectForKey("name") as? String
        let rsvpCount:NSNumber = selectedEvent?.objectForKey("yes_rsvp_count") as! NSNumber
        let rsvpCountAsString:String = String(format:"%@", rsvpCount)
        let eventDescription:String = (selectedEvent?.objectForKey("description") as? String)!
        countLabel.text = rsvpCountAsString
        eventDescriptionlabel.text = eventDescription
        hostLabel.text = selectedEvent?.objectForKey("venue")?.objectForKey("name") as? String
        loadComments()
    }
    
    func loadComments() {
        let urlName = selectedEvent?.objectForKey("group")?.objectForKey("urlname") as! String
        let eventID = selectedEvent?.objectForKey("id") as! String
        let url = NSURL(string: "https://api.meetup.com/" + urlName + "/events/" + eventID + "/comments")
        print("https://api.meetup.com/" + urlName + "/events/" + eventID + "/comments")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            do {
                self.commentsArray = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSArray
                print(self.commentsArray)
            }catch let error as NSError {
                print("error: " + error.localizedDescription)
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
        
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as? webVC
        destVC?.eventDictionary = selectedEvent
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell")! as UITableViewCell
        cell.textLabel?.text = commentsArray?.objectAtIndex(indexPath.row).objectForKey("comment") as? String
        let timeCreated = commentsArray?.objectAtIndex(indexPath.row).objectForKey("created") as? NSTimeInterval
        let date = NSDate(timeIntervalSince1970: timeCreated!)
        let user = commentsArray?.objectAtIndex(indexPath.row).objectForKey("member")?.objectForKey("name") as? String
        cell.detailTextLabel?.text = String(format: "%@ %@", date, user!)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if commentsArray != nil {
            return commentsArray!.count
        }else {
            return 0
        }
        
    }
}
