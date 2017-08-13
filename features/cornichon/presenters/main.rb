require "yaml"

def person
  people.sample
end

def people
  @people ||= YAML.load_file("#{__dir__}/../../test_config/people.yaml")
end

def men
  people.map { |person|  
    person['nationality']
  }
end

def man
  men.sample
end

private

def profession_for(man)
  case man
  when 'Englishman'
    'Beefeater'
  when 'Scotsman'
    'Heroin dealer'
  when 'Irishman'
    'Town drunk'
  when 'Welshman'
    'Sheep shagger'
  end
end