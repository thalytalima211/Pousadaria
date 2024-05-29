require 'rails_helper'

describe 'Dono de pousada registra reserva para grupos' do
  it 'a partir da gestão da pousada' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199',
                                description: 'Um bom lugar', address_attributes: { address: 'Rua X', number: '100',
                                city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner
    visit root_path
    click_on 'Gestão de Pousada'

    expect(page).to have_link 'Cadastrar nova reserva para grupos'
  end

  it 'com sucesso' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199',
                                description: 'Um bom lugar', address_attributes: { address: 'Rua X', number: '100',
                                city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})

    login_as inn_owner, scope: :inn_owner
    visit root_path
    click_on 'Gestão de Pousada'
    click_on 'Cadastrar nova reserva para grupos'
    fill_in 'Nome', with: 'Reserva para time do Flamengo'
    fill_in 'Data de Início', with: 1.week.from_now
    fill_in 'Data de Término', with: 3.weeks.from_now
    click_on 'Cadastrar reserva'

    expect(page).to have_content 'Reserva cadastrada com sucesso'
    expect(page).to have_content 'Reserva para time do Flamengo'
    expect(page).to have_content "Data de Início: #{1.week.from_now.to_date}"
    expect(page).to have_content "Data de Término: #{3.weeks.from_now.to_date}"
  end

  it 'e vê reservas' do
    inn_owner = InnOwner.create!(first_name: 'Joao', last_name: 'Almeida',
                                  document: '53783222001', email: 'joao@email.com', password: '123456')
    inn = inn_owner.create_inn!(name: 'Pousada do Almeidinha', registration_number: '30638898000199',
                                description: 'Um bom lugar', address_attributes: { address: 'Rua X', number: '100',
                                city: 'Manaus', state: 'AM', postal_code: '69067-080', neighborhood: 'Centro'})
    reservation = Reservation.create!(name: 'Reserva para o time do Flamengo', start_date: 1.week.from_now,
                                      end_date: 3.weeks.from_now, inn: inn)

    login_as inn_owner, scope: :inn_owner
    visit root_path
    click_on 'Gestão de Pousada'

    within('#reservation') do
      expect(page).to have_content 'Reserva para o time do Flamengo'
    end
  end
end
