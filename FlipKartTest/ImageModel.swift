
import Foundation

class AnimalResponse: Codable {
    var id: Int?
    var imageURL: String?
    var difficulty: Int?
    var answer: String?
    var isShown: Bool? =  false
    
    func updateIsShown(){
        isShown = true
    }

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case difficulty, answer, isShown
    }
}

typealias responseData = [AnimalResponse]

