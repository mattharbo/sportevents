desc "Update competition with latest ranking"
task retrieve_L1_ranking_for_current_season: :environment do

# Les standings sont utilisés pour définir la "hotness" des rencontres d'une journée
# de championnat avant que cette dernière soit commencée. 

# On utilise les standings à jour de la journée x pour déterminé le scoring
# des rencontres de la journée x+1.

# En principe, il n'y a pas de modification/mise à jour des standings tant que la journée
# n'est pas terminée en intégralité.

# Lorsque la date de tous les matchs de la dernière journée enregistrée en base
# sont dans le passé, alors on va chercher le dernier classement pour toutes les équipes.

# Attention /!\ cet algo ne fonctionne pas lorsque plus de 1 match d'une même journée
# sont décallés et reprogrammés à des dates différents.
# Auquel cas la MAJ aura lieu uniquement le jour du dernier match joué.

# --------------------------------------------
# 1. Vérification s'il y a besoin d'une MAJ

todaysgames = Fixture.where(dateandtime: Fixture.find(111).dateandtime.to_date.all_day)
# todaysgames = Fixture.where(dateandtime: Date.today.all_day)

rounds_of_the_day = Array.new
unique_round = String.new

# Est-ce qu'il y a des matchs aujourd'hui et récupération du/des round(s) associé(s) ?
if todaysgames.any?
	puts todaysgames.size.to_s+" game/s was/were scheduled today 🙌"	
	todaysgames.each do |fixture|
		rounds_of_the_day.push(fixture.round)
	end
else
	puts "🥱 No game today"
end

# Y a-t-il plusieurs ou une seule journée ? le cas échéant quelle est-elle ?
if !rounds_of_the_day.empty? and rounds_of_the_day.uniq.size == 1
	unique_round = rounds_of_the_day[0]
	puts "🎯 Targeted round : "+unique_round
elsif rounds_of_the_day.size > 1
	puts "⚠️ Different rounds played today"
end

# Est-ce que tous les autres matches de cette journée sont dans le passé ?
if !unique_round.strip.empty?
	total_games_for_the_round=Fixture.where(round:unique_round).size
	compteur=0
	Fixture.where(round:unique_round).each do |fixture|	
		fixture.dateandtime.to_date.past? ? compteur += 1 : break
	end

	if compteur==total_games_for_the_round
		puts "👌 All games are in the past"
		update_needed = true
	else
		puts "⏳ Some games of the round are still to play"
	end
end


# --------------------------------------------
# 2. Appel API && 3. Enregistrement en base

if update_needed == true
	puts "🪃 An update is needed"

	require 'uri'
	require 'net/http'

	#######################################
	# ⚠️ season to be updated every year! #
	#######################################
	url = URI("https://api-football-v1.p.rapidapi.com/v3/standings?season=2023&league=61")

	http = Net::HTTP.new(url.host, url.port)
	http.use_ssl = true

	request = Net::HTTP::Get.new(url)
	request["X-RapidAPI-Key"] = 'QfDWrtMJ5wmsh1fjUZRYXaKkPpuvp1nv5hUjsnZgUbue0iFVJY'
	request["X-RapidAPI-Host"] = 'api-football-v1.p.rapidapi.com'

	response = http.request(request)
	lateststanding=JSON.parse(response.body)

	def get_team(teamname)
		@teamfrombdd = Team.where("name like ?", "%#{teamname.split.last}%")
		# To handle "Stade Rennais" case which doesn't match with the team name
		@teamfrombdd.blank? ? @teamfrombdd = Team.where("city like ?", "%#{teamname.split.last}%") : @teamfrombdd
		return @teamfrombdd
	end

	lateststanding["response"][0]["league"]["standings"][0].each do |rank|
		
		Standing.create(
			competition:Competition.find(League.where("name like ?", "%Ligue 1%").take.id),
			round:unique_round.to_i,
			team:get_team(rank["team"]["name"]).take,
			rank:rank["rank"],
			points:rank["points"],
			played:rank["all"]["played"]
		)		

	end 
end

# --------------------------------------------
# 4. Création des prochains matchs en base ==> autre appel / fonction du rake

end