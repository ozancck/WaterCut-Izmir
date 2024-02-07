//
//  WaterCuts.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 5.02.2024.
//

import Foundation

struct WaterCut: Codable, Hashable {
    let KesintiTarihi, Aciklama, IlceAdi: String
    let MahalleID: [Int]
    let Mahalleler, Tip, ArizaGiderilmeTarihi: String
    let IlceID: Int
    let Birim: String
    let ArizaID: Int
    let ArizaDurumu, GuncellemeTarihi: String
    let ArizaTipID: Int
    let KayitTarihi, KesintiSuresi, Ongoru: String
}
