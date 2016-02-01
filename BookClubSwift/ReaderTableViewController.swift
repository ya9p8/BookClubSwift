//
//  ReaderTableViewController.swift
//  BookClubSwift
//
//  Created by Yemi Ajibola on 1/30/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import CoreData


class ReaderTableViewController: UITableViewController
{
    var readers = [Reader]()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        //let fetchRequest = NSFetchRequest(entityName: "Reader")
        
        
        loadReaders()
        
        if(readers.count < 1)
        {
            guard let path = NSBundle.mainBundle().pathForResource("friends", ofType: "json") else { print("JSON File not found!"); return }
            let data = NSData(contentsOfFile: path)
            do
            {
                let array = try NSJSONSerialization.JSONObjectWithData(data!, options:[]) as! [String]
                //print(array)
                
                for name in array
                {
                    
                    let entity = NSEntityDescription.entityForName("Reader", inManagedObjectContext: moc)
                    let reader = Reader(entity: entity!, insertIntoManagedObjectContext: moc)
                    reader.name = name
                    //print(reader.name)
                    reader.isFriend = NSNumber(bool: false)
                    //print(reader.isFriend)
                    loadReaders()
                }
            }
            catch
            {
                
            }
        }
        
        
        
    }
    
    
    func loadReaders()
    {
        let request = NSFetchRequest(entityName: "Reader")
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortByName]
        let predicate = NSPredicate(format: "isFriend == %@", false)
        
        request.predicate = predicate
        //let error = nil
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        do
        {
            let results = try moc.executeFetchRequest(request)
            readers = results as! [Reader]
            tableView.reloadData()
        }
        
        catch{
            print("Error occurred")
        }
        
    }
    
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      
        return readers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReaderCell", forIndexPath: indexPath)

        let reader = readers[indexPath.row]
        
        cell.textLabel!.text = reader.valueForKey("name") as? String

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let moc = appDelegate.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Reader")
        let predicate = NSPredicate(format: "name == %@", readers[indexPath.row].name!)
        
        request.predicate = predicate
        do
        {
            let results = try moc.executeFetchRequest(request)
            
            
            for friend in results
            {
                let newFriend = friend as! Reader
                newFriend.isFriend = NSNumber(bool: true)
            
            }
            
            do
            {
                try moc.save()
            }
            catch {/*Error stuff*/}
        }
            
        catch
        {
            // More error stuff
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
