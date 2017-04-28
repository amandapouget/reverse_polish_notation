describe 'Starting program with \'ruby index.rb\'' do
  it 'begins interaction with the user' do
    expect_any_instance_of(Communicator).to receive(:request_input)
    expect_any_instance_of(Communicator).to receive(:process_input)
    load('index.rb')
  end
end
