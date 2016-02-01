//
//  FriendsTableViewController.swift
//  BookClubSwift
//
//  Created by Yemi Ajibola on 1/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import CoreData

class FriendsTableViewController: UITableViewController
{
    var friends = [Reader]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //loadFriends()

    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        loadFriends()
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
//    {
//        // #warning Incomplete implementation, return the number of sections
//        return friends.count
//    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath)
        
        let friend = friends[indexPath.row]
        
        print(friend)

        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = "Number of books: " + String(friend.books?.count)
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    func loadFriends()
    {
        let request = NSFetchRequest(entityName: "Reader")
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortByName]
        let predicate = NSPredicate(format: "isFriend == %@", NSNumber(bool: true))
        request.predicate = predicate
        
        //let error = nil
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        do
        {
            let results = try moc.executeFetchRequest(request)
            friends = results as! [Reader]
            //print(friends)
            print(friends.count)
            tableView.reloadData()
        }
            
        catch
        {
            print("Error occurred")
        }
        
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
