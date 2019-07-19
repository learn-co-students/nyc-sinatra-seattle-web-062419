class FiguresController < ApplicationController
  # add controller methods

  get '/figures/new' do 
    @titles = Title.all 
    @landmarks = Landmark.all 
    erb :'figures/new'
  end 

  post '/figures' do 
    #binding.pry
    @figure = Figure.create(params["figure"])
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
      @figure.save
    else
      @title = Title.find(params["figure"]["title_ids"])
      @figure.titles << @title
      @figure.save
    end
    if !params["landmark"]["name"].empty? && !params["landmark"]["year"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year"])
      @figure.save
    else
      @landmark = Landmark.find(params["figure"]["landmark_ids"])
      @figure.landmarks << @landmark
      @figure.save
    end

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do 
    @figure = Figure.find(params[:id])

    erb :'/figures/show'
  end

  get '/figures/:id/edit' do 
    #binding.pry
    @figure = Figure.find(params[:id])

    erb :'/figures/edit'
  end

  patch '/figures/:id' do 
    
    redirect :"figures/#{@figure.id}"
  end

end
