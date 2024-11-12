//
//  RecruitResponse.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/6/24.
//

import Foundation

// 회사 정보를 나타내는 구조체
struct Company: Codable {
    let name: String
    let logoPath: String
    let ratings: [Rating]

    enum CodingKeys: String, CodingKey {
        case name
        case logoPath = "logo_path"
        case ratings
    }
}

// 평점을 나타내는 구조체
struct Rating: Codable {
    let type: String
    let rating: Double
}

// 채용 정보를 나타내는 구조체
struct RecruitItem: Codable {
    let id: Int
    let title: String
    let reward: Int
    let appeal: String
    let imageUrl: String
    let company: Company

    enum CodingKeys: String, CodingKey {
        case id, title, reward, appeal
        case imageUrl = "image_url"
        case company
    }
}

// 전체 데이터를 나타내는 구조체
struct Recruit: Codable {
    let recruitItems: [RecruitItem]

    enum CodingKeys: String, CodingKey {
        case recruitItems = "recruit_items"
    }
}
