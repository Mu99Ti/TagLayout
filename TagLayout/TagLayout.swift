//
//  TagCollectionViewLayout.swift
//  TagLayout
//
//  Created by Muhamad Talebi on 8/6/23.
//

import UIKit

class TagLayout: UICollectionViewLayout {
    
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentSize: CGSize = .zero
    private var texts: [String] = [
        "df", "h", "jdsjhfjsd", "jdksakodjask", "jsandjsa", "jhdajshfs"
    ]
    
    private var font: UIFont?
    private var padding: CGFloat = 10
   
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        
        layoutAttributes.removeAll()
        
        
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var cellSize: CGSize = .zero
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                
                cellSize = calculateCellSize(for: texts.randomElement()!)
                
                
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attribute.frame = CGRect(x: xOffset, y: yOffset, width: cellSize.width, height: cellSize.height)
                layoutAttributes.append(attribute)
                
                xOffset += cellSize.width + padding
                if xOffset + cellSize.width > collectionView.bounds.width {
                    xOffset = padding
                    yOffset += cellSize.height + padding
                }
            }
        }
        
        
        contentSize = CGSize(width: collectionView.bounds.width, height: yOffset + cellSize.height)
        
    }
    
    private func calculateCellSize(for text: String) -> CGSize {
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font as Any
        ]
        let textSize = (text as NSString).size(withAttributes: textAttributes)
        let cellWidth = textSize.width + 20
        let cellHeight = textSize.height + 20
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes.first { $0.indexPath == indexPath }
    }
    
    func configure(texts: [String], font: UIFont, padding: CGFloat) {
        self.texts = texts
        self.font = font
        self.padding = padding
    }
}
