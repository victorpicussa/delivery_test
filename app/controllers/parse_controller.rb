require 'json'
require "uri"
require "net/http"

class ParseController < ApplicationController
    def parser
        # The method parser creates a standardized json from a given data using
        # the pattern.json file
        pattern = JSON.parse(File.read("config/pattern.json"))
        data = JSON.parse(request.body.read)

        result = {}
        # For each entry of the pattern json, use the value to search for the key 
        # in data and store the data value on the result
        pattern.each do |entry_name, entry_value|
            if (entry_value.is_a? String)
                path = entry_value.split(".")
                
                if (path.length > 1)
                    sub_val = data[path[0]]
                    
                    for index in 1..(path.length-1) do
                        if (sub_val[path[index]] != nil)
                            sub_val = sub_val[path[index]]
                        else
                            sub_val = nil
                            break
                        end
                    end
                    
                    result[entry_name] = sub_val
                else
                    if (data[entry_value])
                        result[entry_name] = data[entry_value]
                    else
                        result[entry_name] = "0"
                    end
                end
            elsif (entry_value.is_a? Array)
                arr_val = []

                if (data[entry_value[0]].is_a? Array)
                    data[entry_value[0]].each do |entry|
                        sub_val = {}
                        
                        pattern[entry_name][1].each do |obj_pattern|
                            obj_pattern.each do |key, value|
                                if (value.is_a? String)
                                    path = value.split(".")
                                    
                                    if (path.length > 1)
                                        temp_val = entry[path[0]]
                                        
                                        for index in 1..(path.length-1) do
                                            if (temp_val[path[index]] != nil)
                                                temp_val = temp_val[path[index]]
                                            else
                                                temp_val = nil
                                                break
                                            end
                                        end
                                        
                                        sub_val[key] = temp_val
                                    else
                                        sub_val[key] = entry[value]
                                    end
                                end
                            end
                        end
                        
                        arr_val << sub_val
                    end
                end
                
                result[entry_name] = arr_val
            elsif (entry_value.is_a? Object)   
                sub_val = {}

                entry_value.each do |key, value|                    
                    if (value.is_a? String)
                        path = value.split(".")

                        if (path.length > 1)
                            temp_val = data[path[0]]

                            for index in 1..(path.length-1) do
                                if (temp_val[path[index]] != nil)
                                    temp_val = temp_val[path[index]]
                                else
                                    temp_val = nil
                                    break
                                end
                            end
                            
                            sub_val[key] = temp_val
                        end
                    end 
                end

                result[entry_name] = sub_val
            end
        end
        
        render json: result
    end
end
