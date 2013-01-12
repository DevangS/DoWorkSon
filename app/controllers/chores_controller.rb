class ChoresController < ApplicationController
  # GET /chores
  # GET /chores.json
  def index
    @chores = Chore.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chores }
    end
  end

  # GET /chores/1
  # GET /chores/1.json
  def show
    @chore = Chore.find(params[:id])
    @daynames = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
    @people = {"monday" => nil,
               "tuesday" => nil,
               "wednesday" => nil,
               "thursday" => nil,
               "friday" => nil,
               "saturday" => nil,
               "sunday" => nil,
               }
    today = Time.now.strftime('%A').downcase
    flag = false
    nextp=@chore.next_people
    @count=today
    while nextp.size < 7 do
        nextp= nextp + nextp
    end
    @people.each do |weekday,v|

        flag = true if weekday.eql? today
        if flag && @chore[weekday]
            @people[weekday]=nextp.shift
        end
    end
    @people.each do |weekday,v|
        flag = false if weekday.eql? today
        if flag && @chore[weekday]
            @people[weekday]=nextp.shift
        end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chore }
    end
  end

  # GET /chores/new
  # GET /chores/new.json
  def new
    @chore = Chore.new
    @chore.people.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chore }
    end
  end

  # GET /chores/1/edit
  def edit
    @chore = Chore.find(params[:id])
  end

  # POST /chores
  # POST /chores.json
  def create
    @chore = Chore.new(params[:chore])

    respond_to do |format|
      if @chore.save
        format.html { redirect_to video_path, notice: 'Chore was successfully created.',location: @chore }
        format.json { render json: @chore, status: :created, location: @chore }
      else
        format.html { render action: "new" }
        format.json { render json: @chore.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chores/1
  # PUT /chores/1.json
  def update
    @chore = Chore.find(params[:id])

    respond_to do |format|
      if @chore.update_attributes(params[:chore])
        format.html { redirect_to video_path,  notice: 'Chore was successfully updated.',location: @chore }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chore.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chores/1
  # DELETE /chores/1.json
  def destroy
    @chore = Chore.find(params[:id])
    @chore.destroy

    respond_to do |format|
      format.html { redirect_to chores_url }
      format.json { head :no_content }
    end
  end
end
