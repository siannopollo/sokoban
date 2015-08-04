require 'requirements'

MainWindowController.instance.run

# Shoes.app width: 500 do
#   (1..5).to_a.each do |i|
#     # flow do
#       (1..5).to_a.each do |ii|
#         flow(width: 0.5) do
#           flow(width: 50) {para "#{i} - #{ii}"}
#         end
#       end
#     # end
#   end
#
#   # stack do
#     flow {para 'one'}
#     flow {para 'two'}
#     flow {para 'three'}
#   # end
# end

# Shoes.app do
#   @info = para "NO KEY is PRESSED."
#   button('click it') {
#     alert(Level.inspect)
#     # Shoes.app width: 100, height: 100 do
#     #   para 'YOU DID IT!'
#     # end
#   }
#   keypress do |k|
#     @info.replace "#{k.inspect} was PRESSED."
#   end
# end

# Use a main window to show all the possible levels
# When a user chooses a level number, a new window pops up, of the proper size,
# and renders the game and makes it playable
