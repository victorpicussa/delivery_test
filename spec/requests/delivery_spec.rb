require 'rails_helper'

describe 'Delivery', type: :request do
    describe 'POST /create' do
        it 'create new delivery' do
            test_data = {
                externalCode: 9987071,
                storeId: 282,
                subTotal: 49.9,
                deliveryFee: 5.14,
                total_shipping: 5.14,
                total: 55.04,
                country: "BR",
                state: "São Paulo",
                city: "Cidade de Testes",
                district: "Vila de Testes",
                street: "Rua Fake de Testes",
                complement: "teste",
                latitude: -23.629037,
                longitude: -46.712689,
                dtOrderCreate: "2019-06-24T16:45:32.000-04:00",
                postalCode: "85045020",
                number: "0",
                customer: {
                    externalCode: 136226073,
                    name: "JOHN DOE",
                    email: "john@doe.com",
                    contact: "41999999999"
                },
                items: [
                    {
                        externalCode: "IT4801901403",
                        name: "Produto de Testes",
                        price: 49.9,
                        quantity: 1,
                        total: 49.9
                    }
                ],
                payments: [
                    {
                        type: "credit_card",
                        value: 55.04
                    }
                ]
            }

            expect {
                post '/create', params: test_data.to_json
            }.to change { Delivery.count }.from(0).to(1)
            
            expect(response).to have_http_status(:accepted)
        end
    end
end