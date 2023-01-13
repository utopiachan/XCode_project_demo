//
//  addStudentViewController.swift
//  tutorial8
//
//  Created by mobiledev on 23/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
class addStudentViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cameraButtonTapped(_ sender: UIButton)
    {
        if
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            print("Photo Library available")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            print("No camera available")
            
        }
        
    }
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any])
    {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            myImage.image = image
            dismiss(animated: true, completion: nil)}
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var studentName: UITextField!
    @IBOutlet weak var studentID: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    @IBAction func onSave(_ sender: UIBarButtonItem) {
    
        if studentName.text!.isEmpty || studentID.text!.isEmpty{
            let alert = UIAlertController(
                title:"Wait!",
                message: "Some Field is empty, check you have filled all of them.",
                preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(
                                title: "Okay",
                                style: UIAlertAction.Style.cancel))
            self.present(alert, animated: true, completion:nil)
        }
        else {
        (sender as! UIBarButtonItem).title = "Loading..."

        let db = Firestore.firestore()
        let studentCollection = db.collection("students")
        var addStudent = Student(id: studentID.text!, title: studentName.text!, sid: Int32(studentID.text!)!)

        
        do
        {
            //update the database (code from lectures)
            try db.collection("students").addDocument(from: addStudent, completion: {(err) in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document successfully added")
                    self.performSegue(withIdentifier: "saveSegueAdd", sender: sender)
                }
                
            })
        } catch { print("Error updating document \(error)") }         //good code would check this is a float
        
        if myImage.image !== nil{
            // Data in memory
            print("found image")
            guard let data = myImage.image?.jpegData(compressionQuality: 0.1)else {
                print("cannot assign data")
                return
                    
            }

            let imageReference = Storage.storage().reference().child(String(addStudent.sid)+".png")
            imageReference.putData(data,metadata: nil, completion: { _, error in
                guard error == nil else {
                    print("failed to upload" + error!.localizedDescription)
                    return
                        
                }
                imageReference.downloadURL(completion: { [self]url, error in
                    guard let url = url, error == nil else {
                        return
                    }
                    addStudent.url = url.absoluteString
                                            print ("download url :+" + (addStudent.url!))
                                            do
                                            {
                                                //update the database (code from lectures)
                                                try db.collection("students").document(addStudent.id!).setData(from: addStudent){ [self] err in
                                                    if let err = err {
                                                        print("Error updating document: \(err)")
                                                    } else {
                                                        print("Document successfully updated")
                                                        //this code triggers the unwind segue manually
                                                        // Data in memory
                                                       
                                                                                self.performSegue(withIdentifier: "saveSegueAdd", sender: sender)
                                                    }
                                                }
                                            } catch { print("Error updating document \(error)") }                 })
               
            })
        }
        else { print("no image found")}
      //note "error" is a magic variable
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
