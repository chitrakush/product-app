//
//  ProductResponse.swift
//  ProductApp
//
//  Created by Chitra on 05/02/26.
//

struct ProductResponse: Decodable {
    let data: [Product]
    let pagination: Pagination
}

struct Pagination: Decodable {
    var page:Int
    let limit: Int
    let total: Int
}

struct Product: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let brand: String
    let stock: Int
    let image: String
    let specs: ProductSpecs
    let rating: ProductRating
}

struct ProductSpecs: Decodable {
    let color: String?
    let size: String?
    let material: String?
    let weight: String?
    let storage: String?
    let battery: String?
    let waterproof: Bool?
    let screen: String?
    let ram: String?
    let power: String?
    let thickness: String?
    let maxWeight: String?
    let compartments: Int?
    let connection: String?
    let capacity: String?
    let output: String?
    let modes, programs: Int?
    let lens, frame, insulation: String?
    let adjustable: Bool?
}

struct ProductRating: Decodable {
    let rate: Double
    let count: Int
}

