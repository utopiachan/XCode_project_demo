//
//  DetailViewController.swift
//  tutorial8
//
//  Created by mobiledev on 16/5/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var movie : Student?
    var movieIndex : Int? //used much later in tutorial
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sAverage: UILabel!
    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var yearLabel: UITextField!
    @IBOutlet var durationLabel: UITextField!
    @IBOutlet weak var Mark2: UISegmentedControl!
    @IBOutlet weak var Mark3: UITextField!
    @IBOutlet weak var Mark4: UISegmentedControl!
    @IBOutlet weak var Mark5: UITextField!
    @IBOutlet weak var Mark6: UISegmentedControl!
    @IBOutlet weak var Mark7: UITextField!
    @IBOutlet weak var Mark8: UISegmentedControl!
    @IBOutlet weak var Mark12: UITextField!
    @IBOutlet weak var Mark11: UITextField!
    @IBOutlet weak var Mark10: UITextField!
    @IBOutlet weak var Mark9: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let displayMovie = movie
        {
            let totalMark = Double( (displayMovie.week1+displayMovie.week2+displayMovie.week3+displayMovie.week4+displayMovie.week5+displayMovie.week6+displayMovie.week7+displayMovie.week8+displayMovie.week9+displayMovie.week10+displayMovie.week11+displayMovie.week12))
            
            var average = round(Double(totalMark/12*10))/10
            sAverage.text = String(average)+"%"
         self.navigationItem.title = displayMovie.title //this awesome line sets the page title
            titleLabel.text = displayMovie.title
            yearLabel.text = String(displayMovie.sid)
            durationLabel.text = String(displayMovie.week1)
            
            Mark3.text=String(displayMovie.week3)
            Mark5.text=String(displayMovie.week5)
            Mark7.text=String(displayMovie.week7)
            Mark9.text=String(displayMovie.week9)
            Mark10.text=String(displayMovie.week10)
            Mark11.text=String(displayMovie.week11)
            Mark12.text=String(displayMovie.week12)
            switch displayMovie.week2{
            case 100: Mark2.selectedSegmentIndex = 0
            case 80: Mark2.selectedSegmentIndex = 1
            case 70: Mark2.selectedSegmentIndex = 2
            case 60: Mark2.selectedSegmentIndex = 3
            case 0: Mark2.selectedSegmentIndex = 4
            default:Mark2.selectedSegmentIndex = 0
            }
            switch displayMovie.week4{
            case 100: Mark4.selectedSegmentIndex = 1
            case 50: Mark4.selectedSegmentIndex = 0
            case 0: Mark4.selectedSegmentIndex = 2
            default:Mark4.selectedSegmentIndex = 2
            }
            switch displayMovie.week6{
            case 100: Mark6.selectedSegmentIndex = 0
            case 80: Mark6.selectedSegmentIndex = 1
            case 70: Mark6.selectedSegmentIndex = 2
            case 60: Mark6.selectedSegmentIndex = 3
            case 50: Mark6.selectedSegmentIndex = 4
            case 0:Mark6.selectedSegmentIndex = 5
            default:Mark6.selectedSegmentIndex = 5
            }
            switch displayMovie.week8{
            case 100: Mark8.selectedSegmentIndex = 0
            case 0: Mark8.selectedSegmentIndex = 1
            default:Mark8.selectedSegmentIndex = 1
            }
            if displayMovie.url != nil {
                print("image founded")
                if let url = URL(string:(displayMovie.url!)){
                    print("getting url")
                    let task = URLSession.shared.dataTask(with: url) {data, response, error in
                        guard let data = data, error == nil else {return}
                        DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                    }
                    task.resume()
                }
                
                
            }
        }
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
            imageView.image = image
            dismiss(animated: true, completion: nil)}
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSave(_ sender: UIBarButtonItem) {
    
        (sender as! UIBarButtonItem).title = "Loading..."

        let db = Firestore.firestore()


        
        movie!.title = titleLabel.text!
        movie!.sid = Int32(yearLabel.text!)! //good code would check this is an int
        movie!.week1 = Int32(durationLabel.text!)!
        movie!.week3 = Int32(Mark3.text!)!
        movie!.week5 = Int32(Mark5.text!)!
        movie!.week7 = Int32(Mark7.text!)!
        movie!.week9 = Int32(Mark9.text!)!
        movie!.week10 = Int32(Mark10.text!)!
        movie!.week11 = Int32(Mark11.text!)!
        movie!.week12 = Int32(Mark12.text!)!

        switch Mark2.selectedSegmentIndex{
        case 0: movie!.week2 = 100
        case 1: movie!.week2 = 80
        case 2: movie!.week2 = 70
        case 3: movie!.week2 = 60
        case 4: movie!.week2 = 0
        default:movie!.week2 = 0
        }
        switch Mark4.selectedSegmentIndex{
        case 0: movie!.week4 = 50
        case 1: movie!.week4 = 100
        case 2: movie!.week4 = 0
        default:movie!.week4 = 0
        }
        switch Mark6.selectedSegmentIndex{
        case 0: movie!.week6 = 100
        case 1: movie!.week6 = 80
        case 2: movie!.week6 = 70
        case 3: movie!.week6 = 60
        case 4: movie!.week6 = 50
        case 5: movie!.week6 = 0
        default:movie!.week6 = 0
        }
        switch Mark8.selectedSegmentIndex{
        case 0: movie!.week8 = 100
        case 1: movie!.week8 = 0
        default:movie!.week8 = 0
        }
        //good code would check this is a float
        if imageView.image !== nil{
            // Data in memory
            print("found image")
            guard let data = imageView.image?.jpegData(compressionQuality: 0.1) else {
                print("cannot assign data")
                return
                    
            }

            let imageReference = Storage.storage().reference().child(String(movie!.sid)+".png")
            imageReference.putData(data,metadata: nil, completion: { _, error in
                guard error == nil else {
                    print("failed to upload")
                    return
                        
                }
                imageReference.downloadURL(completion: { [self]url, error in
                    guard let url = url, error == nil else {
                        return
                    }
                    self.movie?.url = url.absoluteString
                    print ("download url :+" + (movie?.url!)!)
                                            do
                                            {
                                                //update the database (code from lectures)
                                                try db.collection("students").document(movie!.id!).setData(from: movie!){ [self] err in
                                                    if let err = err {
                                                        print("Error updating document: \(err)")
                                                    } else {
                                                        print("Document successfully updated")
                                                        //this code triggers the unwind segue manually
                                                        // Data in memory
                                                       
                                                    self.performSegue(withIdentifier: "saveSegue", sender: sender)
                                                    }
                                                }
                                            } catch { print("Error updating document \(error)") }                 })
               
            })
        }
        else { print("no image found")}
        do
        {
            //update the database (code from lectures)
            try db.collection("students").document(movie!.id!).setData(from: movie!){ [self] err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                    //this code triggers the unwind segue manually
                    // Data in memory
                   
                                            self.performSegue(withIdentifier: "saveSegue", sender: sender)
                }
            }
        } catch { print("Error updating document \(error)") } //note "error" is a magic variable
    }

    @IBAction func onDelete(_ sender:Any)
    {
        let alert = UIAlertController(
            title:"Wait!",
            message: "You sure you wanna delete " + movie!.title + "?",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(
                            title: "Yeah",
                            style: UIAlertAction.Style.default, handler: { (action) in
                                let db=Firestore.firestore()
                                do
                                {
                                    db.collection("students").document(self.movie!.id!).delete(){ err in
                                if let err=err{
                                print("Error deleting")
                                }else {print("Document deleted")
                                    self.performSegue(withIdentifier: "deleteSegue", sender: sender)
                                    }
                                }
                            }
                            }))
        
        alert.addAction(UIAlertAction(
                            title: "Nope",
                            style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion:nil)
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
