Feature: test

Scenario: a man walks into a pub
  Given a Irishman walks into a bar
  When the barman asks his profession
  Then he says he is a Town drunk

Scenario: a man walks into a pub
  Given a Scotsman walks into a bar
  When the barman asks his profession
  Then he says he is a weaver
  
Scenario Outline: making a table
  Given a <nationality> walks into a bar
  When the barman asks his profession
  Then he says he is a <profession>
  Examples:
  | nationality | profession    |
  | Englishman  | Beefeater     |
  | Irishman    | Town drunk    |
  | Scotsman    | Heroin dealer |
  | Welshman    | Sheep shagger |