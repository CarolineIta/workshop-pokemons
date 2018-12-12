#enconding: utf-8
Dado("que estou na página da  pokedex") do
    visit 'http://pokedex-angular-example.herokuapp.com/#!/list'
   end
   E("clico para adicionar um novo pokemon") do
     find('.btn-success').click
   end
   Quando("preencho todas as informações") do
     find_field('id').set(0001)
     find_field('name').set('Zé')
     find_field('type1').find('option', text: 'Voador').select_option
     find_field('type2').find('option', text: 'Veneno').select_option
     find_field('attack').set(10)
      find_field('defense').set(5)
     sleep(2)  
     find_field('hp').set(100)
     sleep(2)  
   end
     E("clico em Salvar") do
     click_button('Salvar')
    end
     Então("um novo pokemon é adicionado na pokedex") do
     expect(page).to have_css("span ", :text => "Zé") 
    end