//
//  CommentTableViewController.swift
//  BookClubSwift
//
//  Created by Yemi Ajibola on 1/31/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import CoreData

class CommentTableViewController: UITableViewController, UITextFieldDelegate
{
    
    var comments = [Comment]()
    var reader:Reader!
    var book:Book!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadComments()
        
        //print(book.title! + " has "+String(book.comments?.count)+" comments")

    }

    
    // MARK: - Table view data source

    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return comments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath)

        // Configure the cell...
        let comment = comments[indexPath.row]
        
        cell.textLabel?.text = comment.text
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = comment.reader?.name

        return cell
    }
    
    
    func loadComments()
    {
        comments = book.comments?.allObjects as! [Comment]
        tableView.reloadData()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Comment", inManagedObjectContext: moc)
        let comment = Comment(entity: entity!, insertIntoManagedObjectContext: moc)
        comment.text = textField.text
        comment.reader = reader
        comment.book = book
        
        var tempArray = book.comments?.allObjects
        tempArray?.append(comment)
        
        
        book.comments = NSSet(array: tempArray!)
        
        do
        {
            try moc.save()
        }
        catch
        {
            // Error handling
        }
        
        textField.text = ""
        
        loadComments()
        
        return textField.resignFirstResponder()
        
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
