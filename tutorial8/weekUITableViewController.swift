//
//  weekUITableViewController.swift
//  tutorial8
//
//  Created by mobiledev on 23/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class weekUITableViewController: UITableViewController {

    @IBOutlet weak var weekSummary: UITextView!
    var movies = [Student]()
    override func viewDidLoad()
    {
            super.viewDidLoad()

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
            
            let db = Firestore.firestore()
            let movieCollection = db.collection("students")
            movieCollection.getDocuments() { (result, err) in
                if let err = err
                {
                    print("Error getting documents: \(err)")
                }
                else
                {
                    for document in result!.documents
                    {
                        let conversionResult = Result
                        {
                            try document.data(as: Student.self)
                        }
                        switch conversionResult
                        {
                            case .success(let convertedDoc):
                                if var movie = convertedDoc
                                {
                                    // A `Movie` value was successfully initialized from the DocumentSnapshot.
                                    movie.id = document.documentID
                                    print("Movie: \(movie)")
                                    
                                    //NOTE THE ADDITION OF THIS LINE
                                    self.movies.append(movie)
                                }
                                else
                                {
                                    // A nil value was successfully initialized from the DocumentSnapshot,
                                    // or the DocumentSnapshot was nil.
                                    print("Document does not exist")
                                }
                            case .failure(let error):
                                // A `Movie` value could not be initialized from the DocumentSnapshot.
                                print("Error decoding movie: \(error)")
                        }
                    }
                    
                    //NOTE THE ADDITION OF THIS LINE
                    self.tableView.reloadData()
                }
            }
            
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekTableViewCell", for: indexPath)

        //get the movie for this row
        let movie = movies[indexPath.row]

        //down-cast the cell from UITableViewCell to our cell class MovieUITableViewCell
        //note, this could fail, so we use an if let.
        if let movieCell = cell as? WeekTableViewCell
        {
            //populate the cell
             movieCell.studentName.text = movie.title
             movieCell.studentID.text = String(movie.sid)
           
            }
        weekSummary.text = "test"
        return cell
  
    }    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
