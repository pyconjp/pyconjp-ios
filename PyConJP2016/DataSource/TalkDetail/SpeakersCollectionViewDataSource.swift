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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return speakers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SpeakerCollectionViewCell
        return cell
    }
}
