//
//  BookTableViewController.swift
//  BookClubSwift
//
//  Created by Yemi Ajibola on 1/31/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import CoreData

class BookTableViewController: UITableViewController, UITextFieldDelegate {

    var reader:Reader!
    var books = [Book]()
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        loadBooks()
        
    }

    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath)
        
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title


        return cell
    }
    
     func textFieldShouldReturn(textField: UITextField) -> Bool
     {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Book", inManagedObjectContext: moc)
        
        let request = NSFetchRequest(entityName: "Book")
        let predicate = NSPredicate(format: "title == %@", textField.text!)
        var results:NSArray!
        request.predicate = predicate
        
        do
        {
            results = try moc.executeFetchRequest(request)
        }
        catch
        {
            // Error handling
        }
        
        var book:Book
        
        if(results.count == 0)
        {
        
            print("This book is new so I'm gonna go ahead and make a new one!")
            book = Book(entity: entity!, insertIntoManagedObjectContext: moc)
            book.title = textField.text
            
        }
        else
        {
            print("This book has already been created so I'll just add it to your collection.")
            book = results[0] as! Book
        }
        
        var tempArray = reader.books?.allObjects
        tempArray?.append(book)
        reader.books = NSSet(array: tempArray!)
        
        do
        {
            try moc.save()
            
        }
        catch
        {
            // Error handling
        }
        
       
        print(reader.books?.allObjects)

        textField.text = ""
        
        loadBooks()
        
        return textField.resignFirstResponder()
     }
    
    func loadBooks()
    {
        books = reader.books?.allObjects as! [Book]
        tableView.reloadData()
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let commentTVC = segue.destinationViewController as! CommentTableViewController
        let indexPath = tableView.indexPathForSelectedRow
        
        commentTVC.book = books[indexPath!.row]
        commentTVC.reader = reader
        
        print(books[(indexPath?.row)!].readers)
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
