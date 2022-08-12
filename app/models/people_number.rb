class PeopleNumber < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '1人' },
    { id: 3, name: '2人' },
    { id: 4, name: '3人' },
    { id: 5, name: '4人' },
    { id: 6, name: '5人' },
    { id: 7, name: '6人' }
  ]

  include ActiveHash::Associations
  has_many :reserves

end