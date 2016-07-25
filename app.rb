require 'sinatra/base'

class PastaBin < Sinatra::Base
    get '/' do
        erb :layout
    end

    # démarre le serveur si ce fichier est directement exécuté
    run! if app_file == $0
end
