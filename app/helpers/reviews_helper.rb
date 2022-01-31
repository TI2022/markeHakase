module ReviewsHelper
  def display_star(int)
    "★" * int
  end

  def star_width(average)
    if @reviews.present?
      average * 20
    end
  end
end
