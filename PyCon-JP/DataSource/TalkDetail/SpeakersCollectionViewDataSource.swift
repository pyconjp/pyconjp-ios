//
//  SpeakersCollectionViewDataSource.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 9/8/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit

class SpeakersCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    let reuseIdentifier = "SpeakerCollectionViewCell"
    
    var speakers: [Speaker] = []
    
    // MARK: - Collection View DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return speakers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SpeakerCollectionViewCell
        cell.fill(speaker: speakers[(indexPath as NSIndexPath).row])
        return cell
    }
}
