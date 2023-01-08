//
//  Enterprise2TableViewCell.swift
//  MVVM JobPlanet
//
//  Created by ukBook on 2023/01/09.
//

import UIKit

class Enterprise2TableViewCell: UITableViewCell {
    let forCellWithReuseIdentifier = "EnterpriseCollectionViewCell"
    
    var param : [EmploymentDetail]? {
        didSet {
            print("param \(param)")
        }
    }
    
    let view1 = UIView()
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let label : UILabel = {
        let view = UILabel()
        view.text = "인기 급상승 채용 공고"
        view.textColor = .jpgray01
        view.font = .boldSystemFont(ofSize: 24)
        view.sizeToFit()
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .white
        addSubview(view1)
        
        
        _ = [label,collectionView].map {
            view1.addSubview($0)
            view1.layer.borderWidth = 1
            $0.layer.borderWidth = 1
        }
        
        view1.snp.makeConstraints{(make) in
            make.top.left.bottom.right.equalTo(0)
        }
        
        label.snp.makeConstraints{(make) in
            make.left.top.equalTo(20)
//            make.width.equalTo(150)
        }
        
        collectionView.snp.makeConstraints{(make) in
            make.top.equalTo(self.label.snp.bottom).offset(16)
            make.left.equalToSuperview()
            make.bottom.equalTo(-22)
            make.width.equalTo(500)
        }
        collectionView.register(UINib(nibName: "EnterpriseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: forCellWithReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension Enterprise2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: forCellWithReuseIdentifier, for: indexPath) as? EnterpriseCollectionViewCell else { fatalError("can't dequeue CustomCell") }
        
        return cell
    }
    
    
}
