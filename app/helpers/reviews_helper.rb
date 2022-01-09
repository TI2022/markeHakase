module ReviewsHelper
  def display_star(star)
    "★" * star
  end

  def star_width(average)
    average * 20
  end
end
