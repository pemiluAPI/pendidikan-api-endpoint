require 'v1/pertanyaan.rb'

module Base
  class API < Grape::API
    mount Pertanyaan::APIv1
  end
end
