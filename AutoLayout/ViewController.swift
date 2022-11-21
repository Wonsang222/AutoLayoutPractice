//
//  ViewController.swift
//  AutoLayout
//
//  Created by 황원상 on 2022/11/19.
//

import UIKit

class ViewController: UIViewController {
    
    var values:[CGFloat] = []
    var range = (1...12)
    var heightConstraint = [NSLayoutConstraint]()
    var barheightMultipliers : [CGFloat]{
        values.map{
            $0 / 100
        }
    }
    
    lazy var stack1:UIStackView = {
        let st = UIStackView()
        st.alignment = .center
        st.axis = .vertical
        st.distribution = .fillEqually
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var stack2:UIStackView = {
        let st = UIStackView()
        st.alignment = .center
        st.axis = .horizontal
        st.distribution = .fill
        st.backgroundColor = .systemRed
        st.spacing = 30
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var stack3:UIStackView = {
        let st = UIStackView()
        st.alignment = .bottom
        st.axis = .horizontal
        st.spacing = 30
        st.distribution = .fillEqually
        st.backgroundColor = .black
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .white
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let contentView:UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureView()
        drawGraph()
        barheightConstraint()
        
        view.addSubview(stack1)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stack2)
        contentView.addSubview(stack3)
        
        
        let widthAnchor = contentView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor)
        widthAnchor.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            stack1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stack1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: stack1.trailingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            widthAnchor,
            
            stack2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stack2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack2.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.025),
            
            stack3.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack3.bottomAnchor.constraint(equalTo: stack2.topAnchor),
            
        ])
    }
    
    func configureView(){
        let a = [100, 80, 60,40,20,0]
        
        for i in a{
            let label = UILabel()
            label.text = "\(i)"
            stack1.addArrangedSubview(label)
        }
        
        for i in range{
            let label = UILabel()
            label.text = "\(i)"
            stack2.addArrangedSubview(label)
        }
    }
    
    func drawGraph(){
        range.forEach { x in
            let bar = UIView()
            bar.backgroundColor = .systemBlue
            stack3.addArrangedSubview(bar)
        }
        
        values = range.map({ _ in
            CGFloat.random(in: 1...100)
        })
        
        print(values)
    }
    
    func barheightConstraint(){
        heightConstraint.forEach { con in
            con.isActive = false
        }
        
        heightConstraint = zip(barheightMultipliers, stack3.arrangedSubviews).map{
            $1.heightAnchor.constraint(equalTo: stack3.heightAnchor, multiplier: $0)
        }
        
       
        NSLayoutConstraint.activate(heightConstraint)
        self.view.layoutIfNeeded()
        
    }


}

