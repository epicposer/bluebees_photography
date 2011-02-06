class PortfolioPhoto < Photo
  #include ActsAsList::Mongoid

  field :position, :type => Integer

  # associations
  embedded_in :portfolio, :inverse_of => :portfolio_photos
end