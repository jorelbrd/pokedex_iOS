//
//  ServiceNetwork.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/7/21.
//


import UIKit

class Service {
    
    static let shared = Service()
    
    let BASE_URL = "https://pokeapi.co/api/v2/pokemon"
    var arrayResults = [DataResult]()
    var pokemons = [PokemonData]()
    
    func getAllPokemon(success: @escaping (JSON) -> ()) {
        
        let allUrl = BASE_URL //+ "?limit=200"
        
        guard let url = URL(string: allUrl) else { return }
        
        
        URLSession.shared.dataTask(with: url){ (data, respose, error) in
            self.errorFailed(error: error)
            
            guard let data = data else { return }
            
            do {
                
                //convert JSON to swift elementt
                let json = try JSON(data: data)
                
                //return one element type result of pokemon api {results[...]}
                success(json)
                
                
            } catch let error{
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func getAllDataPokemon(success: @escaping ([PokemonData]) -> ()) {
        self.getAllPokemon(){ (respons) in
            let result = respons["results"]
            print(result)
            result.forEach{ value in
                let name = value.1["name"].rawString()
                self.fetchPokemon(namePokemon: name) { (data) in
                    self.pokemons.append(data)
                    success(self.pokemons)
                }
            }
            
        }
        
    }
    
    
    
    func getDetailPokemon(pokeInfo: PokemonData, success: @escaping (PokemonData) -> ()){
        guard let url = URL(string: pokeInfo.url!) else { return }
        self.getPokemon(url: url, pokeInfo: pokeInfo){ (pokemonResult) in
            success(pokemonResult)
        }
        
    }
    
    func fetchPokemonEspecific(namePokemon: String?) {
        if let name = namePokemon{
            let urlSearch = BASE_URL + "/" + name
            //print(urlSearch)
            guard let url = URL(string: urlSearch) else { return }
            let info = PokemonData()
            self.getPokemon(url: url, pokeInfo: info){ (pokemonResult) in
                self.pokemons.removeAll()
                self.pokemons.append(pokemonResult)
            }
        }
        
    }
    
    func fetchPokemon(namePokemon: String?, success: @escaping (PokemonData) -> ()) {
        if let name = namePokemon{
            let urlSearch = BASE_URL + "/" + name.lowercased()
            //print(urlSearch)
            guard let url = URL(string: urlSearch) else { return }
            let info = PokemonData()
            self.getPokemon(url: url, pokeInfo: info){ (pokemonResult) in
                success(pokemonResult)
            }
        }
        
    }
    
    func setEvolutions(pokeInfo: PokemonData) {
        
        if pokeInfo.nextEvolution?.count == 0 {
            let urlSpecies = pokeInfo.specieUrl
            self.getEspecies(url: urlSpecies!) { (urlEvolution) in
                self.getEvolutions(url: urlEvolution, pokem: pokeInfo)
            }
        }
    }
    
    func getPokemon(url: URL, pokeInfo: PokemonData, success: @escaping (PokemonData) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            self.errorFailed(error: error)
            
            do{
                guard let data = data else { return }
                
                
                
                let json = try JSON(data: data)
                
                pokeInfo.name = json["name"].rawString()
                
                let urlSpecies = json["species"]["url"].rawString()
                
                pokeInfo.specieUrl = urlSpecies
            
                
                pokeInfo.order = Int(json["order"].rawString()!)
                
                //get description of pokemons
                let urlDescription = json["species"]["url"].rawString()
                
                self.getDescription(urlString: urlDescription!){ (description) in
                    pokeInfo.description = description
                }
                
                //get types of pokemon
                let types = json["types"]
                
                
                types.forEach { (_types) in
                    pokeInfo.types?.append(_types.1["type"]["name"].rawString()!)
                }
                
                //get moves
                let moves = json["moves"]
                
                
                moves.forEach{ move in
                    var movePokemon = PokemonData.Moves()
                    let nombre = move.1["move"]["name"].rawString()
                    movePokemon.name = nombre
                    pokeInfo.moves?.append(movePokemon)
                }
                
                
                //get stats
                if let HP = Int(json["stats"][0]["base_stat"].rawString()!){
                    pokeInfo.hp = HP
                }
                
                if let ATK = Int(json["stats"][1]["base_stat"].rawString()!){
                    pokeInfo.atk = ATK
                }
                if let DEF = Int(json["stats"][2]["base_stat"].rawString()!){
                    pokeInfo.def = DEF
                }
                if let SATK = Int(json["stats"][3]["base_stat"].rawString()!){
                    pokeInfo.satk = SATK
                }
                if let SDEF = Int(json["stats"][4]["base_stat"].rawString()!){
                    pokeInfo.sdef = SDEF
                }
                if let SPD = Int(json["stats"][5]["base_stat"].rawString()!){
                    pokeInfo.spd = SPD
                }
                
                //get moves
                
                
                
                //get id pokemons
                pokeInfo.id = Int(json["id"].rawString()!)
                
                //get color for background of pokemon
                pokeInfo.color = pokeInfo.setColor(stringColor: json["types"][0]["type"]["name"].rawString()!)
                
                //get image of pokemon
                let urlImage = json["sprites"]["other"]["official-artwork"]["front_default"].rawString()
                self.loadImg(urlString: urlImage ?? ""){ (img) in
                    pokeInfo.image = img
                }
                
                //return pokmon with new data
                success(pokeInfo)
            } catch let error{
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func getEvolutions(url: String, pokem: PokemonData) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            self.errorFailed(error: error)
            do{
                guard let data = data else { return }
                let json = try JSON(data: data)
                
                //get fisrt evolutions
                var name = json["chain"]["species"]["name"].rawString()
                self.addNextEvolution(name: name!, pokemon: pokem, minLvl: 0)
                
                
                //get second evolutions
                name = json["chain"]["evolves_to"][0]["species"]["name"].rawString()
                var min_level = Int(json["chain"]["evolves_to"][0]["evolution_details"][0]["min_level"].rawString() ?? "0")
                
                self.addNextEvolution(name: name!, pokemon: pokem, minLvl: min_level)
                
                //get last evolutions
                name = json["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"].rawString()
                min_level = Int(json["chain"]["evolves_to"][0]["evolves_to"][0]["evolution_details"][0]["min_level"].rawString() ?? "0")
                self.addNextEvolution(name: name!, pokemon: pokem, minLvl: min_level)
                
                
            } catch let error{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    func addNextEvolution(name: String, pokemon: PokemonData, minLvl: Int?)  {
        self.fetchPokemon(namePokemon: name) { (pokemonResult) in
            pokemonResult.levelEvolution = minLvl
            pokemon.nextEvolution?.append(pokemonResult)
        }
    }
    
    func getEspecies(url: String, success: @escaping (String) -> ()) {
        print(url)
        guard let urldir = URL(string: url) else { return }
        print(urldir)
        URLSession.shared.dataTask(with: urldir){ (data, response, error) in
            self.errorFailed(error: error)
            do{
                guard let data = data else { return }
                let json = try JSON(data: data)
                let urlEvolutions = json["evolution_chain"]["url"].rawString()!
                
                success(urlEvolutions)
            } catch let error{
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    func getDescription(urlString: String, success: @escaping (String) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            self.errorFailed(error: error)
            
            do{
                guard let data = data else { return }
                
                let json = try JSON(data: data)
                
                let description = json["flavor_text_entries"][6]["flavor_text"].rawString()
                
               
                
                success(description!)
            } catch let error{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
   
    
    
    func loadImg(urlString: String, success: @escaping (UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            success(image)
                        }
                    }
                }
            }
        }
    
    
    func numRowsSection(section: Int) -> Int {
        if self.pokemons.count != 0 {
            return self.pokemons.count
        } else {return 0}
    }
    
    func cellRowAt(indexPath: IndexPath) -> PokemonData {
        return self.pokemons[indexPath.row]
    }
    
    
    private func fetchImage(withUrlString urlString: String, success: @escaping(UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Failed to fetch image with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            success(image)
            
        }.resume()
    }
    
    
    private func errorFailed(error: Error?){
        if let error = error {
            print("Failed to fetch image with error: ", error.localizedDescription)
            return
        }
    }
}
