require 'sinatra/base'

class PastaBin < Sinatra::Base
    set :views, settings.root + '/views'
    set :public_folder, File.dirname(__FILE__) + '/public'

    get '/'        do; @page_title = "Index"  ; erb :index  ; end
    get '/about'   do; @page_title = "About"  ; erb :about  ; end
    get '/api'     do; @page_title = "API"    ; erb :api    ; end
    get '/contact' do; @page_title = "Contact"; erb :contact; end

    not_found do; redirect to('/')                          ; end
    error     do; @erreur = env['sinatra.error']; erb :error; end

    # démarre le serveur si ce fichier est directement exécuté
    run! if app_file == $0
end
