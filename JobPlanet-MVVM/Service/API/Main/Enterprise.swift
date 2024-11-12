//
//  Enterprise.swift
//  JobPlanet-MVVM
//
//  Created by ukseung.dev on 11/6/24.
//

import Foundation

// MARK: - Welcome
struct Enterprise: Codable {
    let cellItems: [CellItem]

    enum CodingKeys: String, CodingKey {
        case cellItems = "cell_items"
    }
}

// MARK: - CellItem
struct CellItem: Codable {
    let cellType: CellType
    let logoPath: String?
    let name, industryName: String?
    let rateTotalAvg: Double?
    let reviewSummary, interviewQuestion: String?
    let salaryAvg: Int?
    let updateDate: String?
    let count: Int?
    let sectionTitle: String?
    let recommendRecruit: [RecruitItem]?
    let cons, pros: String?

    enum CodingKeys: String, CodingKey {
        case cellType = "cell_type"
        case logoPath = "logo_path"
        case name
        case industryName = "industry_name"
        case rateTotalAvg = "rate_total_avg"
        case reviewSummary = "review_summary"
        case interviewQuestion = "interview_question"
        case salaryAvg = "salary_avg"
        case updateDate = "update_date"
        case count
        case sectionTitle = "section_title"
        case recommendRecruit = "recommend_recruit"
        case cons, pros
    }
}

enum CellType: String, Codable {
    case cellTypeCompany = "CELL_TYPE_COMPANY"
    case cellTypeHorizontalTheme = "CELL_TYPE_HORIZONTAL_THEME"
    case cellTypeReview = "CELL_TYPE_REVIEW"
}

enum Name: String, Codable {
    case 잡플래닛 = "잡플래닛"
}

enum TypeEnum: String, Codable {
    case ceo지지도 = "CEO 지지도"
    case 경영진 = "경영진"
    case 복지급여 = "복지/급여"
    case 사내문화 = "사내문화"
    case 승진가능성 = "승진 가능성"
    case 워라밸 = "워라밸"
}
