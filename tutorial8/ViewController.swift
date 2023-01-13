//
//  ViewController.swift
//  tutorial8
//
//  Created by mobiledev on 16/5/21.
//
import Firebase
import FirebaseFirestoreSwift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let db=Firestore.firestore()
        let movieCollection = db.collection("students")
        let matrix = Student(title: "The Matrix", sid: 1999, week1: 150)
        do {
            try movieCollection.addDocument(from: matrix, completion: { (err) in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Successfully created movie")
                }
            })
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
        movieCollection.getDocuments() { (result, err) in
          //check for server error
          if let err = err
          {
              print("Error getting documents: \(err)")
          }
          else
          {
              //loop through the results
              for document in result!.documents
              {
                  //attempt to convert to Movie object
                  let conversionResult = Result
                  {
                      try document.data(as: Student.self)
                  }

                  //check if conversionResult is success or failure (i.e. was an exception/error thrown?
                  switch conversionResult
                  {
                      //no problems (but could still be nil)
                      case .success(let convertedDoc):
                          if let movie = convertedDoc
                          {
                              // A `Movie` value was successfully initialized from the DocumentSnapshot.
                              print("Movie: \(movie)")
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
          }
        }
    }

}

