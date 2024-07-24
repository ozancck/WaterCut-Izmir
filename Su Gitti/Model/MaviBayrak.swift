//
//  MaviBayrak.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 20.07.2024.
//

import Foundation

struct OnemliYer: Codable {
    let ilce: String
    let kapino: String
    let enlem: Double
    let aciklama: String
    let ilceID: String
    let mahalle: String
    let mahalleID: String?
    let adi: String
    let boylam: Double
    let yol: String
    
    enum CodingKeys: String, CodingKey {
        case ilce = "ILCE"
        case kapino = "KAPINO"
        case enlem = "ENLEM"
        case aciklama = "ACIKLAMA"
        case ilceID = "ILCEID"
        case mahalle = "MAHALLE"
        case mahalleID = "MAHALLEID"
        case adi = "ADI"
        case boylam = "BOYLAM"
        case yol = "YOL"
    }
}

struct DataModel: Codable {
    let sayfadakiKayitSayisi: Int
    let kayitSayisi: Int
    let sayfaNumarasi: Int
    let onemliYer: [OnemliYer]
    let toplamSayfaSayisi: Int
    
    enum CodingKeys: String, CodingKey {
        case sayfadakiKayitSayisi = "sayfadaki_kayitsayisi"
        case kayitSayisi = "kayit_sayisi"
        case sayfaNumarasi = "sayfa_numarasi"
        case onemliYer = "onemliyer"
        case toplamSayfaSayisi = "toplam_sayfa_sayisi"
    }
}
