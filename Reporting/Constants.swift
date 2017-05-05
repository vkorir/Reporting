


//CONSTANTS
import UIKit

let greenTheme = UIColor(red: 0/255.0, green: 135/255.0, blue: 68/255.0, alpha: 1.0)
let lightGray = UIColor(colorLiteralRed: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
let lighterGray = UIColor(colorLiteralRed: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 246/255.0)

let googleMapsAPI = "AIzaSyA-0DuTlaTDh94wqvhAGX_qbRglc4jQ22g"
let latitude = 37.881853
let longitude = -122.258423

let dateFormat = "yyyy-MM-dd HH:mm:ss.A"
let pollutionOptions = ["Air", "Water", "Other"]
let markerColors = [UIColor(colorLiteralRed: 214/255.0, green: 45/255.0, blue: 32/255.0, alpha: 1.0),
                    UIColor(colorLiteralRed: 0, green: 87/255.0, blue: 231/255.0, alpha: 1.0),
                    UIColor(colorLiteralRed: 0, green: 135/255.0, blue: 68/255.0, alpha: 1.0)]
var posts: [Post] = []

let ToSignIn = "toSignIn"
let SignInToMap = "SignInToMap"
let MapToFeed = "MapToFeed"
let MapToAbout = "MapToAbout"
let MapToNew = "MapToReport"
let MapTousers = "MapToUsers"
let FeedToMap = "FeedToMap"
let FeedToNew = "FeedToNew"
let FeedToAbout = "FeedToAbout"
let NewToMap = "ReportToMap"
let NewToFeed = "NewToFeed"

let feedCell = "feedCell"
let userCell = "userCell"

let onlinePath = "Online"
let postsPath = "Posts"
let imagesPath = "Images"

let nameKey = "name"
let addressKey = "address"
let pollutionIndexKey = "titleIndex"
let dateKey = "date"
let locationKey = "location"
let latitudeKey = "latitude"
let longitudeKey = "longitude"
let descriptionKey = "description"
let imagePath = "imagePath"

let placeholder = "Describe the incident..."
