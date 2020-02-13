//
//  RatingControl.swift
//  Meu primeiro app
//
//  Created by Jonathan on 31/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
//usado para desenhar no interfaceBuilder
@IBDesignable class RatingControl: UIStackView {
//MARK: Initialization
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    // @IBInspectable - permite alterar o tamanho na aba de inspeção
    @IBInspectable var starCount: Int = 5 {
        didSet {    //sempre q o starCount for alterada, é usado o setupButtons()
            setupButtons()
        }
    }
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    private func setupButtons() {
        
        // Limpando os botões existente
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Carrega as imagens das estrelas
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            // Criando o botão
            let button = UIButton()
            
            // Setando as imagens e inserindo ação delas
            button.setImage(emptyStar, for: .normal)    //estrela vazia
            button.setImage(filledStar, for: .selected) //estrela azual
            button.setImage(highlightedStar, for: .highlighted) //estrela preta
            button.setImage(highlightedStar, for: [.highlighted, .selected, .focused])
            
            // Restrições das estrelas
            // translatesAutoresizingMaskIntoConstraints - possibilita alterar tamanhos da estrela em modo estatico
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // define a acessibilidade dos botões
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Configurando ação do botão
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // adicionando no conjunto de estrelas
            addArrangedSubview(button)
            
            // Adicione o novo botão à matriz de botões de classificação
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    // Cria o setup de botões
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    // Usado para abrir algo que já esta salvo
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculando o rating para a seleção do mesmo
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // Ao selecionar a mesma estrela duas vezes, o rating é zerado
            rating = 0
        } else {
            // Caso contrario define o rating com a estrela selecionada
            rating = selectedRating
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // Se o índice de um botão for menor que a classificação, esse botão deverá ser selecionado.
            button.isSelected = index < rating
            
            // Define a hintString conforme a seleção das estrelas
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calcula o valor das strings
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            // Atribui a sequencia de valores para a hintString
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
 
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
