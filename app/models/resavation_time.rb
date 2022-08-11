class ResavationTime < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '11:00~' },
    { id: 3, name: '11:30~' },
    { id: 4, name: '12:00~' },
    { id: 5, name: '12:30~' },
    { id: 6, name: '13:00~' },
    { id: 7, name: '13:30~' },
    { id: 8, name: '14:00~' },
    { id: 9, name: '14:30~' },
    { id: 10, name: '15:00~' },
    { id: 11, name: '15:30~' },
    { id: 12, name: '16:00~' }
  ]

  include ActiveHash::Associations
  has_many :reserves

end