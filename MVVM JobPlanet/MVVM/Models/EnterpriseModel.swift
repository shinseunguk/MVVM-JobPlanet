//
//  EnterpriseModel.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/09.
//

import Foundation


struct EnterpriseModel: Codable {
    let cell_items : [EnterpriseList]?
}

struct EnterpriseList: Codable {
    // 기업
    let cellType : String?
    let logoPath : String?
    let name : String?
    let industryName : String?
    let rateTotalAvg : CGFloat?
    let reviewSummary : String?
    let interviewQuestion : String?
    let salaryAvg : Int?
    let updateDate : String?
    
    let count : Int?
    let sectionTitle : String?
    let recommendRecruit : [EmploymentDetail]?
    
    enum CodingKeys: String, CodingKey {
        case cellType = "cell_type"
        case logoPath = "logo_path"
        case name = "name"
        case industryName = "industry_name"
        case rateTotalAvg = "rate_total_avg"
        case reviewSummary = "review_summary"
        case interviewQuestion = "interview_question"
        case salaryAvg = "salary_avg"
        case updateDate = "update_date"
        
        case count = "count"
        case sectionTitle = "section_title"
        case recommendRecruit = "recommend_recruit"
    }
}

