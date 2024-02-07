//
//  WaterCutDetailsViewModel.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 7.02.2024.
//

import Foundation

struct WaterCutDetailsViewModel {
    
    
    func convertToArray(_ input: String) -> [String] {
        let components = input.components(separatedBy: ", ")
        return components
    }

    /*
    let inputString = "ozan, hasan, mehmet"
    let resultArray = convertToArray(inputString)
    print(resultArray) // Çıktı: ["ozan", "hasan", "mehmet"]
     */
    
    func formatDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        }

        return nil
    }
    
    func remainingTime(targetDateString: String) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
           
           guard let targetDate = dateFormatter.date(from: targetDateString) else {
               return "Geçersiz tarih formatı"
           }
           
           let currentDate = Date()
           
           let calendar = Calendar.current
           let components = calendar.dateComponents([.day, .hour, .minute], from: currentDate, to: targetDate)
           
           if let days = components.day, let hours = components.hour, let minutes = components.minute {
               if days < 0 || hours < 0 || minutes < 0 {
                   return "Hedef tarih geçmiş"
               } else {
                   return String(format: "%02d gün, %02d saat, %02d dakika kaldı", days, hours, minutes)
               }
           } else {
               return "Geçersiz zaman aralığı"
           }
       }
    
}
