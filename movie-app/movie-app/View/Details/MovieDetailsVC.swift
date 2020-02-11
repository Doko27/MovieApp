//
//  IWKBUMovieDetailsVC.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 04/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit
import ChameleonFramework
import Cosmos

class MovieDetailsVC: BaseViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgBgView: UIView!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var genresLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var votesLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var id: Int?
    var request: MovieRequest?
    var data: MovieDetailsModel?
    var credistData: [MovieCreditsModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        request?.doGetMovieDetails(id: self.id ?? 0)
        request?.doGetMovieCredits(id: self.id ?? 0)
    }
}

// MARK: - Configure View
extension MovieDetailsVC {
    
    func configView() {
        configImage()
        configCollection()
        configGeneralInfo()
    }
    
    func configImage() {
        bgImg.sd_setImage(with: URL(string: "\(BaseURL.GetImageUrl())\(data?.backdropPath ?? "")")) { (img, err, cache, url) in
            self.bgImg.setLoad(isLoad: false, style: .medium)
            if err == nil {
                self.bgImg.image = img
            } else {
                self.bgImg.image = nil
                self.bgImg.backgroundColor = UIColor.lightGray
            }
        }
        posterImg.sd_setImage(with: URL(string: "\(BaseURL.GetImageUrl())\(data?.posterPath ?? "")")) { (img, err, cache, url) in
            self.posterImg.setLoad(isLoad: false, style: .medium)
            if err == nil {
                self.posterImg.image = img
            } else {
                self.posterImg.image = nil
                self.posterImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    func configGeneralInfo() {
        title = data?.title ?? ""
        titleLbl.text = data?.title?.uppercased() ?? ""
        imgBgView.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: view.bounds, andColors: [UIColor.darkGray, UIColor.black])
        releaseDateLbl.text = "\(DateHelper.dateParseToStringUTC(data?.releaseDate ?? "", oldFormat: "yyyy-MM-dd", newFormat: "EEEE, dd MMMM yyyy"))"
        let duration = (Double(data?.runtime ?? 0)/60.0)
        durationLbl.text = "\(String(format:"%.1f", duration)) Hour"
        languageLbl.text = data?.languages ?? ""
        ratingView.settings.fillMode = .precise
        ratingView.rating = (data?.rating ?? 0.0)/2.0
        genresLbl.text = data?.genres?.joined(separator: ", ")
        votesLbl.text = "\(Int(data?.score ?? 0.0)) Votes"
        overviewLbl.text = data?.overview ?? ""
    }
    
}

// MARK: - Configure Collection View
extension MovieDetailsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func configCollection() {
        collectionView?.register(UINib(nibName: "CreditsCell", bundle: nil), forCellWithReuseIdentifier: "CreditsCell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditsCell", for: indexPath) as? CreditsCell
        if credistData?.count ?? 0 > 0 {
            cell?.setupData(data: credistData?[indexPath.item])
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/1.5, height: collectionView.frame.height)
    }
}

// MARK: - API Integration
extension MovieDetailsVC: MovieResponse {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config(vc: self)
    }
    
    func config(vc: MovieDetailsVC) {
        var present = MoviePresenter()
        present.output = vc
        vc.request = present
    }
    
    func displayMovieDetails(result: MovieDetailsModel) {
        data = result
        configView()
    }
    
    func displayMovieCredits(result: [MovieCreditsModel]) {
        credistData = result
        reloadData()
    }
    
    func displayError(message: String, object: Any) {
        UIAlertController.showSimpleDialog(vc: self, title: "", message: message, button: "OK")
    }
    
}
