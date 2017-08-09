//
//  RunTableViewController.swift
//  FoodTracker
//
//  Created by Reid Sherman MAT on 8/1/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit

class RunTableViewController: UITableViewController {
    var runs = [Run]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //use the edit button item provided by table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        loadSampleRuns()
        if let savedRuns = loadRuns() {
            runs += savedRuns
        }
        else {
            //load sample data
            loadSampleRuns()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return runs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RunTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RunTableViewCell else {
            fatalError("dequeued cell is not instance of runtableviewcell")
        }
        // Configure the cell...
        let run = runs[indexPath.row]
        cell.nameLabel.text = run.name
        cell.dayLabel.text = run.day
        cell.locationLabel.text = run.location
        cell.timeLabel.text = run.time
        cell.starButton.tag = 0
        //cell.starButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControlEvents#>)
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            runs.remove(at: indexPath.row)
            saveRuns()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "AddItem":
                print("Adding new run.")
            case "ShowDetail":
                guard let runDetailViewController = segue.destination as? RunViewController else {
                    fatalError("Unexpected Destination: \(segue.destination)")
            }
                guard let selectedRunCell = sender as? RunTableViewCell else {
                    fatalError("Unexpected Sender: \(sender)")
            }
                guard let indexPath = tableView.indexPath(for: selectedRunCell) else {
                    fatalError("The selected cell is not being displayed by the table")
            }
            let selectedRun = runs[indexPath.row]
            runDetailViewController.run = selectedRun
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    //MARK: Actions
    @IBAction func unwindToRunList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RunViewController, let run = sourceViewController.run {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                runs[selectedIndexPath.row] = run
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new run.
                let newIndexPath = IndexPath(row: runs.count, section: 0)
                runs.append(run)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveRuns()
        }
    }
    private func saveRuns() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(runs, toFile: Run.ArchiveURL.path)
        if isSuccessfulSave {
            print("Runs successfully saved.")
        } else {
            print("Failed to save runs...")
        }
    }
    private func loadSampleRuns(){
        let url = URL(string: "https://reidsherman.com/runs.json")
        URLSession.shared.dataTask(with:url!, completionHandler:
            {(data, response, error) in
                guard let data = data, error == nil else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                    if let runs_load = json["runs"] as? [[String: AnyObject]] {
                        for run in runs_load {
                            
                            let r_name = self.loadJSONString(jsonObject: run, name: "runName")
                            //Make sure that the run name is not already loaded
                            if !self.checkForRunName(name: r_name) {
                                let r_day = self.loadJSONString(jsonObject: run, name: "runDay")
                                let r_time = self.loadJSONString(jsonObject: run, name: "runTime")
                                let r_location = self.loadJSONString(jsonObject: run, name: "runLocation")
                                guard let current_run = Run(name:r_name, day: r_day, time: r_time, location: r_location) else {
                                    fatalError("Unable to instantiate run")
                                }
                                self.runs += [current_run]
                                self.tableView.reloadData()
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error)
                }
        }).resume()
    }
    
    private func loadJSONString(jsonObject: [String:AnyObject], name: String) -> String {
        return(jsonObject[name] as? String! ?? "EMPTY")
    }
    private func checkForRunName(name: String) -> Bool {
        for run in runs {
            if run.name == name {
                return true
            }
        }
        return false
    }
    private func loadRuns() -> [Run]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Run.ArchiveURL.path) as? [Run]
    }

}
