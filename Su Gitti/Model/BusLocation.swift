//
//  BusLocation.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 21.07.2024.
//

import Foundation
struct BusLocation: Decodable {
    let otobusId: Int
    let yon: Int
    let koorY: String
    let koorX: String

    private enum CodingKeys: String, CodingKey {
        case otobusId = "OtobusId"
        case yon = "Yon"
        case koorY = "KoorY"
        case koorX = "KoorX"
    }
}

struct BusLocationResponse: Decodable {
    let hataMesaj: String
    let hatOtobusKonumlari: [BusLocation]
    let hataVarMi: Bool

    private enum CodingKeys: String, CodingKey {
        case hataMesaj = "HataMesaj"
        case hatOtobusKonumlari = "HatOtobusKonumlari"
        case hataVarMi = "HataVarMi"
    }
}



