//
//  ViewController.swift
//  MeetMeUp
//
//  Created by Rafael Auriemo on 2/1/16.
//  Copyright © 2016 Rafael Auriemo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var resultsArray:NSArray?
    var eventsJson = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=214f172c234154602f63736a7e751e35")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            do {
                self.eventsJson = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                self.resultsArray = self.eventsJson.objectForKey("results") as? NSArray
                self.tableView.reloadData()
            }catch let error as NSError {
                print("error: " + error.localizedDescription)
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(resultsArray != nil){
            return (resultsArray?.count)!
        }else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        
        if (resultsArray != nil) {
            cell.textLabel?.text = resultsArray![indexPath.row].objectForKey("name") as? String
            let addressString = resultsArray![indexPath.row].objectForKey("venue")?.objectForKey("address_1") as? String
            cell.detailTextLabel?.text = addressString
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! DetailViewController
        let cell = sender as! UITableViewCell
        let path = tableView.indexPathForCell(cell)
        destination.selectedEvent = resultsArray?.objectAtIndex(path!.row) as? NSDictionary
    }


}

