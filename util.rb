require 'date'
require 'json'

class Util

  SECRET = 'secret.json'

  def self.read_secret
    File.open(SECRET) do |f|
      JSON.load(f)
    end
  end

end
