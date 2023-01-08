//
//  EmploymentModel.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/08.
//

import Foundation

struct EmploymentModel: Decodable {
    let recruit_items: [EmploymentDetail]?
}

struct EmploymentDetail: Codable {
    let id: Int?
    let title: String?
    let reward: Int?
    let appeal: String?
    let image_url: String?
    let company: ComapnyDetail?
}

struct ComapnyDetail : Codable {
    let name: String?
    let logo_path: String?
    let ratings: [ratingDetail]?
}

struct ratingDetail : Codable {
    let type: String?
    let rating: CGFloat?
}

