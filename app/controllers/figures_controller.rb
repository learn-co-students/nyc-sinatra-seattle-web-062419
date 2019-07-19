class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do 
    @figures = Figure.all
    erb :'figures/index'
  end
  get '/figures/new' do 
    @titles = Title.all 
    @landmarks = Landmark.all 
    erb :'figures/new'
  end 

  post '/figures' do 
    #binding.pry

    puts params
    @figure = Figure.create(params["figure"])
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
      @figure.save
    elsif params["figure"]["title_ids"]
      @titles = Title.find(params["figure"]["title_ids"])
      @figure.titles = @titles
      @figure.save
    end
    if !params["landmark"]["name"].empty? 
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year"])
      @figure.save
    else
      @landmarks = Landmark.find(params["figure"]["landmark_ids"])
      @figure.landmarks = @landmarks
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
    @titles = @figure.titles
    @landmarks =@figure.landmarks

    erb :'/figures/edit'
  end

  patch '/figures/:id' do 
    @figure = Figure.find(params[:id])
    @figure.update(name:params["figure"]["name"])
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
      @figure.save
    elsif params["figure"]["title_ids"]
      @titles = Title.find(params["figure"]["title_ids"])
      @figure.titles = @titles
      @figure.save
    end
    if !params["landmark"]["name"].empty? 
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year"])
      @figure.save
    else
      @landmarks = Landmark.find(params["figure"]["landmark_ids"])
      @figure.landmarks = @landmarks
      @figure.save
    end
    
    redirect :"figures/#{@figure.id}"
  end

end
