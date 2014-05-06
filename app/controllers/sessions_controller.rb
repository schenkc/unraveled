class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
    params[:user][:email], params[:user][:password])
    
    if (user.email == "demo_user1@example.com") || (user.email == "demo_user2@example.com")
      user = reset_demo_user(user)
      login_user!(user)
      redirect_to user_url(user)
      return true
    end

    if user.nil?
      flash.now[:errors] ||=[]
      flash.now[:errors] << "Couldn't find user"
      render :new
    elsif !user.activate?
      flash.now[:errors] ||= []
      flash.now[:errors] << "Check your email for activation"
      render :new
    else
      login_user!(user)
      redirect_to user_url(user)
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token]= nil

    redirect_to new_session_url
  end
  
  private
  
  def reset_demo_user(user)
    tags = %w( bottom-up down-down icord in-the-round one-piece amigurumi reversible textured cables eyelets)
    b = (1...10).to_a
    # reset
    user.destroy
    
    user = User.create(email: "demo_user1@example.com",
              name: "demo1",
              password: "123123",
              bio: "I'm the demo user, please have fun poking around here.",
              activate: true)
    
    # rebuild
    users = User.find([10,11,12,13])
    user.followers = users[0,2]
    user.leaders = users
    user.liked_patterns = Pattern.first(5)
    
    users.each do |fake_user|
      body1 = "Hi there #{fake_user.show_name}, can't wait to see more of your work, #{user.show_name}"
      m = user.sent_messages.new(body: body1, receiver_id: fake_user.id)
      m.save if m.valid?
      body2 = "#{user.show_name}, thanks noticing!"
      m = user.received_messages.new(body: body2, sender_id: fake_user.id)
      m.save if m.valid?
    end
    
    2.times do
      name = Faker::Commerce.product_name
      yarn_name = Faker::Commerce.color + " by " + Faker::Company.name
      yarn_weight = b.sample.to_s
      stitch_col = b.sample.to_s
      stitch_row = b.sample.to_s
      swatch = "4 inches"
      swatch_stitch = "stockenette stitch"
      needles = "US " + (2 * b.sample).to_s
      amount_yarn = "Enough"
      price = "free"
      p = user.designs.create(name: name, yarn_name: yarn_name, yarn_weight: yarn_weight, stitch_col: stitch_col,
                        stitch_row: stitch_row, swatch: swatch, swatch_stitch: swatch_stitch, needles: needles,
                        amount_yarn: amount_yarn, price: price)
      tag_array = tags.sample(b.sample).map { |name| Tag.find_or_create_by(name: name)}
      p.tags << tag_array
    end
    
    return user
  end

end