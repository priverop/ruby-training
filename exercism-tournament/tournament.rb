# frozen_string_literal: true

# Tournament manager
module Tournament
  def self.tally(input)
    return header if input.strip.empty?

    ranking = {}

    # Hay que iterar el input para ir almacenando los resultados (puntos)
    input.split('\n').each do |line|
      # Método que dada la linea, devuelve los resultados (puntos)
      ranking = result(ranking, line.strip.split(';'))
    end
    puts 'Ending ranking:'
    p ranking
    puts ''
    # print ranking - with header
    print_ranking(ranking)
  end

  def self.header
    <<~HEADER
      Team                           | MP |  W |  D |  L |  P
    HEADER
  end

  # Allegoric Alaskans;Blithering Badgers;win
  def self.result(ranking, array)
    puts ''
    puts 'Single Result: '
    local_team = array[0]
    p local_team
    visitant_team = array[1]
    p visitant_team
    condition = array[2]
    p condition
    p ranking

    ranking[local_team] ||= empty_ranking
    ranking[local_team][:played] += 1
    ranking[visitant_team] ||= empty_ranking
    ranking[visitant_team][:played] += 1

    case condition
    when 'win'
      ranking[local_team][:wins] += 1
      ranking[local_team][:points] += 3
      ranking[visitant_team][:loses] += 1
    when 'loss'
      ranking[local_team][:loses] += 1
      ranking[visitant_team][:points] += 3
      ranking[visitant_team][:wins] += 1
    when 'draw'
      ranking[local_team][:draws] += 1
      ranking[local_team][:points] += 1
      ranking[visitant_team][:points] += 1
      ranking[visitant_team][:draws] += 1
    else
      raise StandardError, 'Condition not found'
    end
    puts '--'
    puts ''
    ranking
  end

  def self.empty_ranking
    { played: 0, wins: 0, draws: 0, loses: 0, points: 0 }
  end

  def self.print_ranking(ranking)
    print = header
    ranking.each do |team_name, results|
      print += print_single_team_rank(team_name, results)
    end
    print
  end

  def self.print_single_team_rank(team_name, results)
    <<~HEADER
      #{team_name}             |  #{results[:played]} |  #{results[:wins]} |  #{results[:draws]} |  #{results[:loses]} |  #{results[:points]}
    HEADER
  end

  def self.sort_ranking; end
end
