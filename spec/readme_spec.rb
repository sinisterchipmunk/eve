require 'spec_helper'

# Runs the examples found in the synopsis of the README.rdoc file. We need to verify that they work because they should
# be copy-and-paste ready.

if !$mock_services  # only run these if the credentials are (theoretically) valid
  describe "Readme Examples" do
    it "should be copy-and-paste ready" do
      # Get the current server status
      api = Eve::API.new()
      server_status = api.server_status
      puts "Server reports status #{server_status.server_open ? "ONLINE" : "OFFLINE"}"
      puts "\tCurrent time is #{server_status.current_time}"
      puts "\t#{server_status.online_players} players currently online"
      puts

      # Get a list of characters
      api = Eve::API.new(:user_id => $user_id, :api_key => $limited_api_key)
      result = api.account.characters
      puts "Choose a character:"
      result.characters.each_with_index { |char, index| puts "\t#{index}: #{char.name} (#{char.character_id})" }
      choice = 2#gets.chomp.to_i
      puts

      # Get the current training queue. Need a full API key and a character ID for that.
      api.set(:api_key => $full_api_key, :character_id => result.characters[choice].character_id)
      result = api.character.skill_queue
      result.skillqueue.each do |skill|
        result.skillqueue.columns.each do |column|
          print column.ljust(20), ":\t", skill[column], "\n"
        end
        puts
      end
    end
  end
end
