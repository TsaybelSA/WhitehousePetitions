//
//  Petition.swift
//  WhitehousePetitions
//
//  Created by Сергей Цайбель on 03.06.2022.
//

import Foundation

struct Petition: Codable {
	var title: String
	var body: String
	var signatureCount: Int
}
