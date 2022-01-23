module ReviewsHelper
  def display_star(int)
    "★" * int
  end

  def star_width(average)
    average * 20
  end
end
