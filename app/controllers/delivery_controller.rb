class DeliveryController < ApplicationController
    protect_from_forgery with: :null_session

    def create
        # The method create insert a new row if data is validy
        data = JSON.parse(request.body.read) 

        if (verify(data) == "OK")
            @delivery = Delivery.new(data)

            @delivery.save

            render json: data, status: 202
        else
            render json: data, status: 412
        end
    end

    def verify(data)
        # The verify method validate the given data and returns a confimation
        Time::DATE_FORMATS[:date_pattern] = '%Hh%M - %d/%m/%y'
        
        response = Net::HTTP.post(
            URI.parse('https://delivery-center-recruitment-ap.herokuapp.com/'), 
            data.to_json, 
            {"X-Sent" => Time.now.to_formatted_s(:date_pattern)}
        )
        
        return response.body
    end
end