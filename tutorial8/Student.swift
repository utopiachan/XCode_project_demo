import Firebase
import FirebaseFirestoreSwift

public struct Student : Codable
{
    @DocumentID var id:String?
    var title:String
    var sid:Int32
    var week1:Int32=0
    var week2:Int32=0
    var week3:Int32=0
    var week4:Int32=0
    var week5:Int32=0
    var week6:Int32=0
    var week7:Int32=0
    var week8:Int32=0
    var week9:Int32=0
    var week10:Int32=0
    var week11:Int32=0
    var week12:Int32=0
    var url:String?
}
