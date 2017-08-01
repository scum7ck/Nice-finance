class Stock < ApplicationRecord
	has_many :user_stocks
	has_many :users, through: :user_stocks
	# Искать акцию по сокращению(ticker)
	def self.find_by_ticker(ticker_symbol)
		where(ticker: ticker_symbol).first
	end

	# Искать акцию
	def self.new_from_lookup(ticker_symbol)
		looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
		# Неправильный поиск возвращает nil
		return nil unless looked_up_stock.name

		# показывается цену акции, название и ссокращение
		new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
		new_stock.last_price = new_stock.price
		new_stock
	end

	# Получаем цену
	def price
		# Если существует, то вернуть это значение
		closing_price = StockQuote::Stock.quote(ticker).close
		# Закрытая цена
		return "#{closing_price} (Closing)" if closing_price

		# Открытая цена
		opening_price = StockQuote::Stock.quote(ticker).open
		return "#{opening_price} (Opening)" if opening_price

		# Иначе
		'Unavailable'
	end
end
