# rubocop:disable Metrics/MethodLength
# rubocop:disable Layout/LineLength
# rubocop:disable Style/RedundantInterpolation
# rubocop:disable Layout/IndentationConsistency

require 'telegram/bot'
require_relative 'motivate.rb'
require_relative 'joke.rb'

class Bot
    def initialize
        token = '' # ambil sendiri di t.me/BotFather

        Telegram::Bot::Client.run(token) do |bot|
            bot.listen do |message|
                case message.text

                when '/start'
                    bot.api.send_message(chat_id: message.chat.id, text: "Hello #{message.from.first_name}! Welcome to Re7 beta bot, this bot created by Rlxfly. I will keep you motived and entertained, use /start to start the bot, /stop to end the bot, /motivate to get a diffrent motivational quote everytime you request for it or /joke to get a joke everytime you request for it")

                when '/stop'
                    bot.api.send_message(chat_id: message.chat.id, text: "Bye #{message.from.first_name}~", date: message.date)

                when '/motivate'
                    values = Motivate.new
                    value = values.select_random

                    bot.api.send_message(chat_id: message.chat.id, text: "#{value['text']}", date: message.date)

                when '/joke'
                    values = Joke.new
                    value = values.make_the_request

                    bot.api.send_message(chat_id: message.chat.id, text: "#{value['joke']}", date: message.date)

                else

                    bot.api.send_message(chat_id: message.chat.id, text: "Invalid command #{message.from.first_name}! Use /start, /stop, /motivate or /joke ")
                end
            end
        end
    end
end

# rubocop: enable Metrics/MethodLength
# rubocop: enable Layout/LineLength
# rubocop: enable Style/RedundantInterpolation
# rubocop: enable Layout/IndentationConsistency
