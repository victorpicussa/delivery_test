# PAYLOAD PARSER

Um simples parser de JSON feito em Ruby on Rails.

# INICIALIZAÇÃO

O projeto possui a dependência do Ruby versão 2.7.0 e do SQLite3. Como será possível armazenar
um JSON padronizado é preciso criar o banco de dados, para isso bastar utilizar o comando **rake db:migrate**.
Para verificar a criação foi um sucesso basta usar **sqlite3 db/development.rb** para acessar o banco de dados.
Com isso, executando o comando **rails s** o servidor estará ativo.

# UTILIZAÇÃO

O projeto possui duas rotas: */parse* que recebe um certo JSON e retorna os dados no padrão definido
em *pattern.json*; */create* que recebe um JSON e verifica sua validade antes de inserir no banco de dados.

# TESTES

Testes simples foram aplicados nas rotas de */parse* e */create* com RSpec 5.0. A execução dos testes é feita com
o comando **bundle exec rspec spec/requests/parser_spec.rb** e **bundle exec rspec spec/requests/delivery_spec.rb**.

# EXEMPLO

Fazendo uma requisição de GET para a rota *127.0.0.1:3000/parse* com o seguinte JSON:
```json
{
  "id": 9987071,
  "store_id": 282,
  "date_created": "2019-06-24T16:45:32.000-04:00",
  "date_closed": "2019-06-24T16:45:35.000-04:00",
  "last_updated": "2019-06-25T13:26:49.000-04:00",
  "total_amount": 49.9,
  "total_shipping": 5.14,
  "total_amount_with_shipping": 55.04,
  "paid_amount": 55.04,
  "expiration_date": "2019-07-22T16:45:35.000-04:00",
  "total_shipping": 5.14,
  "order_items": [
    {
      "item": {
        "id": "IT4801901403",
        "title": "Produto de Testes"
      },
      "quantity": 1,
      "unit_price": 49.9,
      "full_unit_price": 49.9
    }
  ],
  "payments": [
    {
      "id": 12312313,
      "order_id": 9987071,
      "payer_id": 414138,
      "installments": 1,
      "payment_type": "credit_card",
      "status": "paid",
      "transaction_amount": 49.9,
      "taxes_amount": 0,
      "shipping_cost": 5.14,
      "total_paid_amount": 55.04,
      "installment_amount": 55.04,
      "date_approved": "2019-06-24T16:45:35.000-04:00",
      "date_created": "2019-06-24T16:45:33.000-04:00"
    }
  ],
  "shipping": {
    "id": 43444211797,
    "shipment_type": "shipping",
    "date_created": "2019-06-24T16:45:33.000-04:00",
    "receiver_address": {
      "id": 1051695306,
      "address_line": "Rua Fake de Testes 3454",
      "street_name": "Rua Fake de Testes",
      "street_number": "3454",
      "comment": "teste",
      "zip_code": "85045020",
      "city": {
        "name": "Cidade de Testes"
      },
      "state": {
        "name": "São Paulo"
      },
      "country": {
        "id": "BR",
        "name": "Brasil"
      },
      "neighborhood": {
        "id": null,
        "name": "Vila de Testes"
      },
      "latitude": -23.629037,
      "longitude": -46.712689,
      "receiver_phone": "41999999999"
    }
  },
  "status": "paid",
  "buyer": {
    "id": 136226073,
    "nickname": "JOHN DOE",
    "email": "john@doe.com",
    "phone": {
      "area_code": 41,
      "number": "999999999"
    },
    "first_name": "John",
    "last_name": "Doe",
    "billing_info": {
      "doc_type": "CPF",
      "doc_number": "09487965477"
    }
  }
}
```

O retorno será o JSON padronizado:
```json
{
    "externalCode": 9987071,
    "storeId": 282,
    "subTotal": 49.9,
    "deliveryFee": 5.14,
    "total_shipping": 5.14,
    "total": 55.04,
    "country": "BR",
    "state": "São Paulo",
    "city": "Cidade de Testes",
    "district": "Vila de Testes",
    "street": "Rua Fake de Testes",
    "complement": "teste",
    "latitude": -23.629037,
    "longitude": -46.712689,
    "dtOrderCreate": "2019-06-24T16:45:32.000-04:00",
    "postalCode": "85045020",
    "number": "0",
    "customer": {
        "externalCode": 136226073,
        "name": "JOHN DOE",
        "email": "john@doe.com",
        "contact": "41999999999"
    },
    "items": [
        {
            "externalCode": "IT4801901403",
            "name": "Produto de Testes",
            "price": 49.9,
            "quantity": 1,
            "total": 49.9
        }
    ],
    "payments": [
        {
            "type": "credit_card",
            "value": 55.04
        }
    ]
}
```

A partir do JSON padronizado basta fazer um requisição POST para a rota *127.0.0.1:3000/create*,
a qual fará a validação e retornará uma resposta: **202** se os dados foram aceitos e inseridos no banco
de dados; **412** caso os dados são inváidos.