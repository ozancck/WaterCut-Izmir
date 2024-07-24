//
//  WaterCutDetails.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 7.02.2024.
//

import UIKit

class WaterCutDetails: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var viewModel = WaterCutDetailsViewModel()

    @IBOutlet var pageTitle: UILabel!

    @IBOutlet var mahallelerBigTitle: UILabel!

    @IBOutlet var mahalleler_collectionView: UICollectionView!

    @IBOutlet var infoTitle: UILabel!
    @IBOutlet var sebepBigTitile: UILabel!
    @IBOutlet var sebepTitleBackground: UIView!

    @IBOutlet var sebepDesc: UILabel!

    @IBOutlet var counterLabel: UILabel!

    var waterCut: WaterCut?
    var mahalleler: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        counterLabel.text = viewModel.remainingTime(targetDateString: viewModel.formatDateString(waterCut?.ArizaGiderilmeTarihi ?? "0") ?? "0")

        sebepTitleBackground.backgroundColor = .black
        sebepTitleBackground.layer.cornerRadius = 12
        sebepDesc.textColor = .white
        sebepDesc.text = "\(waterCut?.Aciklama.lowercased(with: Locale(identifier: "tr_TR")).capitalized ?? "")"

        mahalleler = viewModel.convertToArray(waterCut?.Mahalleler ?? "")

        mahalleler_collectionView.dataSource = self
        mahalleler_collectionView.delegate = self

        pageTitle.text = waterCut?.IlceAdi

        infoTitle.text = waterCut?.KesintiSuresi
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mahalleler.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mahalleler_collectionView.dequeueReusableCell(withReuseIdentifier: "MahallelerCollectionViewCell", for: indexPath) as! MahallelerCollectionViewCell

        cell.titleLabel.text = mahalleler[indexPath.row]

        return cell
    }
}
