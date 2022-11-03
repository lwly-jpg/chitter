require_relative '../lib/post_repository'
require_relative '../lib/post'

def reset_chitter_table
  seed_sql = File.read('spec/seeds_chitter.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_chitter_table
  end

  it 'returns list of posts' do
    repo = PostRepository.new
    posts = repo.all
    expect(posts.length).to eq(5)
    expect(posts.first.content).to eq('I love music! x')
    expect(posts[1].date).to eq('2022-10-31')
    expect(posts[2].time).to eq('10:20:00')
    expect(posts.last.user_id).to eq(2)
  end
end