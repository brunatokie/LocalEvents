


import Foundation

struct Event : Codable {
	let people : [String]?
	let date : Int?
	let description : String?
	let image : String?
	let longitude : Double?
	let latitude : Double?
	let price : Double?
	let title : String?
	let id : String?

	enum CodingKeys: String, CodingKey {

		case people = "people"
		case date = "date"
		case description = "description"
		case image = "image"
		case longitude = "longitude"
		case latitude = "latitude"
		case price = "price"
		case title = "title"
		case id = "id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		people = try values.decodeIfPresent([String].self, forKey: .people)
		date = try values.decodeIfPresent(Int.self, forKey: .date)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		price = try values.decodeIfPresent(Double.self, forKey: .price)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		id = try values.decodeIfPresent(String.self, forKey: .id)
	}
    
    

}
