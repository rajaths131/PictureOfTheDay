//
//  MainViewPresenter.swift
//  PictureOfTheDay
//
//  Created by Rajath Shetty on 23/01/22.
//

import Foundation
import UIKit

protocol MainViewable: AnyObject {
    func showLoadingIndicator()
    func hideLoadingIndicatorAndShowNoDataError()
    func hideLoadingIndicator()
    func showDetails(title: String, details: String, isPastImage: Bool)
    func hideLoadingIndicatorAndShowImage(_ image: UIImage)
    func hideLoadingIndicatorAndShowNoImageError()
}

class MainViewPresenter {
    weak var view: MainViewable?
    let interacter: DataFetchInteracter
    var picture: Picture?
    var dateFormater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init(view: MainViewable,
         interacter: DataFetchInteracter = DataFetchInteracter()) {
        self.view = view
        self.interacter = interacter
    }
    
    func mainViewLoaded() {
        view?.showLoadingIndicator()
        interacter.fetchPictureForTheDay { [weak self] result in
            
            switch result {
            case .success(let picture):
                self?.picture = picture
                var isOldData = false
                if let date = self?.dateFormater.date(from: picture.date) {
                    isOldData = date < Calendar.current.startOfDay(for: Date())
                }

                self?.view?.showDetails(title: picture.title,
                                        details: picture.explanation,
                                        isPastImage: isOldData)
                self?.startLoadingImage(picture)
                
            case .failure(_):
                self?.view?.hideLoadingIndicatorAndShowNoDataError()
            }
        }
    }
    
    func startLoadingImage(_ picture: Picture) {
        self.interacter.getImageForPath(picture.url) { [weak self] image in
            guard let dispalyImage = image else {
                self?.view?.hideLoadingIndicatorAndShowNoImageError()
                return
            }
            
            self?.view?.hideLoadingIndicatorAndShowImage(dispalyImage)
        }
    }
}
