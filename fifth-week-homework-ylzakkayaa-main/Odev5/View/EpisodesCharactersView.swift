//
//  EpisodesCharactersView.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 26.11.2022.
//

//Episodes'a tıklayınca herhangi bir bölüme tıklanınca açılacak olan view'ı oluşturdum.

import UIKit

protocol NewCharacterViewDelegate: AnyObject {
    func savePressed()
}

final class EpisodesCharactersView: UIView {

    @IBOutlet weak var charactersTextView: UITextView!

    weak var delegate: NewCharacterViewDelegate?
        
    init(frame: CGRect, characters: [String]) {
        super.init(frame: frame)
        customInit()
        charactersTextView.text = characters.reduce("") {$0 + $1 + "\n"}
        charactersTextView.backgroundColor = .random
    }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            customInit()
        }
        
        private func customInit() {
            let nib = UINib(nibName: "EpisodesCharactersView", bundle: nil)
            if let view = nib.instantiate(withOwner: self).first as? UIView {
                addSubview(view)
                view.frame = self.bounds
            }
        }
        
    //Close butonuna tıklayınca view'ı kaldırıyor.
    @IBAction func closeButton(_ sender: Any) {
        delegate?.savePressed()
        removeFromSuperview()
    }
}

//Random color oluşturması için extension tanımladım.
extension UIColor {
    static var randomView: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}


