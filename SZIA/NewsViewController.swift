//
//  NewsViewController.swift
//  SZIA
//
//  Created by Ádibádi on 28/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    
    var news = [News]()
    var urlSession : NSURLSession!

    override func viewDidLoad() {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSession = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        self.loadNews()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.loadNews()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("NewsTableViewCell", forIndexPath: indexPath) as UITableViewCell
        
        let newsData = self.news[indexPath.row] as News
        
        cell.textLabel!.text = newsData.title
        cell.detailTextLabel!.text = newsData.content
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NewsDetailsSegue" {
            let vc = segue.destinationViewController as! NewsDetailsViewController
            let row = tableView.indexPathForSelectedRow?.row
            vc.news = self.news[row!] as News
        }
    }
    
    func loadNews() {
        let url = NSURL(string: "http://szia-backend.herokuapp.com/api/news")
        let dataTask = urlSession.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            
            do {
                self.news.removeAll()
                guard let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!,
                    options: NSJSONReadingOptions(rawValue: 0)) as? [AnyObject] else {
                        return
                }
                for object in jsonArray {
                    let d = object as! [NSObject: AnyObject]
                    let n = News(date: d["date"] as! String, title: d["title"] as! String, content: d["content"] as! String)
                    self.news.append(n)
                }
            } catch {
                print("Error \(error)")
            }
        })
        dataTask.resume()
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
