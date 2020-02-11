//
//  ViewController.swift
//  Meu primeiro app
//
//  Created by Jonathan on 28/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import os.log


class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var txtNome: UILabel!
    @IBOutlet weak var inserirImageButton: UIButton!
    @IBOutlet weak var avalicaoTextField: UITextField!
    @IBOutlet weak var numeroTextField: UITextField!
    @IBOutlet weak var estadoTextField: UITextField!
    @IBOutlet weak var bairroTextField: UITextField!
    @IBOutlet weak var ruaTextField: UITextField!
    @IBOutlet weak var cidadeTextFild: UITextField!
    @IBOutlet weak var nomeBarTextField: UITextField!
    @IBOutlet weak var rationControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        //indica se o controlador de exibição que apresentou essa cena é do tipo UINavigationController.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        //Verifica se o usuario estava adicionando um novo Bar. O else é chamado se estiver na tela para editar o bar
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
            //popViewController (animated :), que retira o controlador de exibição atual (a cena de detalhes da refeição) da pilha de navegação e anima a transição. Isso descarta a cena de detalhes da refeição e retorna o usuário à lista de refeições.
        } else {
            fatalError("The BarViewController is not inside a navigation controller.")
        }
    }
    
    var bar: Bar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeBarTextField.delegate = self
        ruaTextField.delegate = self
        //inserirImageButton.delegate = self
        numeroTextField.delegate = self
        estadoTextField.delegate = self
        bairroTextField.delegate = self
        cidadeTextFild.delegate = self
        
        // Configure vistas se estiver editando uma refeição existente.
        if let bar = bar {
            navigationItem.title = bar.name
            txtNome.text   = bar.name
            nomeBarTextField.text = bar.name
            image.image = bar.photo
            rationControl.rating = bar.rating
            ruaTextField.text = bar.rua
            numeroTextField.text = String(bar.numero)
            estadoTextField.text = bar.estado
            bairroTextField.text = bar.bairro
            cidadeTextFild.text = bar.cidade
        }
        
// Ative o botão Salvar apenas se o campo de texto tiver um nome de refeição válido.
    updateSaveButtonState()

    }
    
    @IBOutlet weak var image: UIImageView!
    
    let imagePiker = UIImagePickerController()
    @IBAction func selectImage(_ sender: Any) {
        
        print("Entrou na func selectImage")
        imagePiker.delegate = self
        imagePiker.sourceType = .photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            print("Verificou a permissao")
            imagePiker.allowsEditing = false
            imagePiker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(imagePiker, animated: true,completion: nil)
        }
        
    }
    
    //Não ta funcionando
    @IBAction func tirarandoFoto(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagee = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image.image = imagee
        }
        else{
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    // Este método permite configurar um controlador de exibição antes de ser apresentado.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //Configure o controlador de exibição de destino apenas quando o botão Salvar for pressionado.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let namev = nomeBarTextField.text ?? ""
        let photo = image.image
        let rating = rationControl.rating
        let cidadev = cidadeTextFild.text ?? ""
        let estadovv = estadoTextField.text ?? ""
        let bairrovv = bairroTextField.text ?? ""
        let ruav = ruaTextField.text ?? ""
        let numerov = Int(numeroTextField.text ?? "0")
    
        // Defina a refeição a ser passada para MealTableViewController após o desenrolar.
        bar = Bar(name: namev, photo: photo, rating: rating, cidade: cidadev, estado: estadovv, bairro: bairrovv, rua: ruav, numero: numerov!)
    }
    
    private func updateSaveButtonState() {
        // Desative o botão Salvar se o campo de texto estiver vazio
        let textAdd = txtNome.text ?? ""
        saveButton.isEnabled = !textAdd.isEmpty
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Desative o botão Salvar durante a edição.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateSaveButtonState()
        
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
}

