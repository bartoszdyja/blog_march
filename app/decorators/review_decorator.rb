class ReviewDecorator < Draper::Decorator
  delegate_all

  def author  
  	'John Doe'
  end

end
