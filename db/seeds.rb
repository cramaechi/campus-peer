# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

### Load books information. This might change in production. ###

=begin
Book.delete_all

Book.create(
  title: 'Introduction To Geography',
  author: 'Arthur Getis,Judith Getis,Jerome Fellmann',
  publisher: 'McGraw-Hill Science/Engineering/Math',
  isbn10: '0073522821',
  isbn13: '9780073522821')
Book.create(
  title: 'Exploring Python',
  author: 'Timothy Budd',
  publisher: 'McGraw-Hill Science/Engineering/Math',
  isbn10: '0073523372',
  isbn13: '9780073523378')
Book.create(
  title: 'Critical Thinking: A Campus Life Casebook (2nd Edition)',
  author: 'Madeleine Picciotto',
  publisher: 'Prentice Hall',
  isbn10: '0131115197',
  isbn13: '9780131115194')
Book.create(
  title: 'The Expanded Family Life Cycle: Individual, Family, And Social Perspectives (4th Edition)',
  author: 'Monica McGoldrick,Betty Carter,Nydia Garcia-Preto',
  publisher: 'Prentice Hall',
  isbn10: '0205747965',
  isbn13: '9780205747962')
Book.create(
  title: 'Human Behavior And The Larger Social Environment: A New Synthesis (2nd Edition)',
  author: 'Miriam McNown Johnson,Rita Rhodes',
  publisher: 'Prentice Hall',
  isbn10: '0205763669',
  isbn13: '9780205763665')
Book.create(
  title: 'The Autobiography Of Eleanor Roosevelt (Quality Paperbacks Series)',
  author: 'Eleanor Roosevelt',
  publisher: 'Da Capo Press',
  isbn10: '030680476X',
  isbn13: '9780306804762')
Book.create(
  title: 'Cell Biology: A Short Course',
  author: 'Stephen R. Bolsover,Elizabeth A. Shephard,Hugh A.',
  publisher: 'Wiley-Blackwell',
  isbn10: '0470526998',
  isbn13: '9780470526996')
Book.create(
  title: 'Hold Paramount: The Engineer''s Responsibility To Society',
  author: 'Alastair S. Gunn,P.  Aarne Vesiland',
  publisher: 'CL-Engineering',
  isbn10: '053439258X',
  isbn13: '9780534392581')
Book.create(
  title: 'The Lightning Thief (Movie Tie-in Edition) (Percy Jackson And The Olympians)',
  author: 'Rick Riordan',
  publisher: 'Hyperion Book CH',
  isbn10: '142313494X',
  isbn13: '9781423134947')
Book.create(
  title: 'International Economics: Global Markets And Competition',
  author: 'Henry Thompson',
  publisher: 'World Scientific Publishing Company',
  isbn10: '9812563466',
  isbn13: '9789812563460')

  =end
  