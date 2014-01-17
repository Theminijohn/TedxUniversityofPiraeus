class PagesController < ApplicationController
  def home
  end

  def about
  end

  def schedule
  end

  def team
  end

  def speakers
  end

  def talks
  end

  def submit
  end

  def youridea
  end

  def faq
  end

  def thelounge
    if current_user.has_role? :team
      @applications = Application.all
      @ideas = Idea.all
    else
      redirect_to root_path
    end
  end

end
