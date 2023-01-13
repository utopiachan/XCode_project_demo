//
//  StudentUITableViewController.swift
//  tutorial8
//
//  Created by mobiledev on 16/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift


class WeekSummaryTableViewController: UITableViewController , UIPickerViewDataSource, UIPickerViewDelegate{
    var weeks = ["week 1", "week 2","week 3", "week 4","week 5", "week 6","week 7", "week 8","week 9", "week 10","week 11", "week 12"]
    var detected: String? = "week 1"
    var studentTotal: Double? = 0.0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weeks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weeks[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = weeks[row]
        detected = item
       studentTotal = 0
       
        self.tableView.reloadData()
      
    }
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekSummaryTableViewCell", for: indexPath)

        //get the movie for this row
        let movie = movies[indexPath.row]

        //down-cast the cell from UITableViewCell to our cell class MovieUITableViewCell
        //note, this could fail, so we use an if let.
        if let movieCell = cell as? WeekSummaryTableViewCell
        {
            //populate the cell
             movieCell.studentName.text = movie.title
             movieCell.studentID.text = String(movie.sid)
            movieCell.sImage.image = nil
            if movie.url != nil {
                print("image founded")
                if let url = URL(string:(movie.url!)){
                    print("getting url")
                    let task = URLSession.shared.dataTask(with: url) {data, response, error in
                        guard let data = data, error == nil else {return}
                        DispatchQueue.main.async {
                            movieCell.sImage.image = UIImage(data: data)
                    }
                    }
                    task.resume()
                }
            }
            switch detected{
            case "week 1" : movieCell.studentMark.text = String(movie.week1)
                studentTotal = studentTotal! + Double(movie.week1)
            case "week 2" :
                switch movie.week2{
                case 100: movieCell.studentMark.text = "A"
                case 80: movieCell.studentMark.text = "B"
                case 70: movieCell.studentMark.text = "C"
                case 60: movieCell.studentMark.text = "D"
                case 0: movieCell.studentMark.text = "F"
                default:movieCell.studentMark.text = "F"
                }

                studentTotal = studentTotal! + Double(movie.week2)
            case "week 3" : movieCell.studentMark.text = String(movie.week3)
                studentTotal = studentTotal! + Double(movie.week3)
            case "week 4" :
                switch movie.week4{
            case 100: movieCell.studentMark.text = "2 Pt"
            case 50: movieCell.studentMark.text = "1 Pt"
            case 0: movieCell.studentMark.text = "0 Pt"
            default:movieCell.studentMark.text = "0 Pt"
            }
                studentTotal = studentTotal! + Double(movie.week4)
            case "week 5" : movieCell.studentMark.text = String(movie.week5)
                studentTotal = studentTotal! + Double(movie.week5)
            case "week 6" :
                switch movie.week6{
            case 100: movieCell.studentMark.text = "HD+"
            case 80: movieCell.studentMark.text = "HD"
            case 70: movieCell.studentMark.text = "DN"
            case 60: movieCell.studentMark.text = "CR"
            case 50: movieCell.studentMark.text = "PP"
            case 0: movieCell.studentMark.text = "NN"
            default:movieCell.studentMark.text = "NN"
            }
                studentTotal = studentTotal! + Double(movie.week6)
            case "week 7" : movieCell.studentMark.text = String(movie.week7)
                studentTotal = studentTotal! + Double(movie.week7)
            case "week 8" :
                switch movie.week8{
            case 100: movieCell.studentMark.text = "Attend"
            case 0: movieCell.studentMark.text = "Absent"
            default:movieCell.studentMark.text = "Absent"
            }
                studentTotal = studentTotal! + Double(movie.week8)
            case "week 9" : movieCell.studentMark.text = String(movie.week9)
                studentTotal = studentTotal! + Double(movie.week9)
            case "week 10" : movieCell.studentMark.text = String(movie.week10)
                studentTotal = studentTotal! + Double(movie.week10)
            case "week 11" : movieCell.studentMark.text = String(movie.week11)
                studentTotal = studentTotal! + Double(movie.week11)
            case "week 12" : movieCell.studentMark.text = String(movie.week12)
                studentTotal = studentTotal! + Double(movie.week12)
            default: movieCell.studentMark.text = " "
            }
        }
   
        weekSummary.text = "Current Week Average: " +  String((round(studentTotal!/Double(movies.count)*10))/10) + "%"
        return cell
     
    }
    

}
