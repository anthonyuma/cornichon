def person
  people.sample
end

def people
  men.map { |m|
    {
      'nationality' => m,
      'profession' => profession_for(m)
    }
  }
end

def men
  ["Englishman", "Irishman", "Scotsman", "Welshman"]
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