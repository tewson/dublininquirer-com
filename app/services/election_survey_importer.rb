require 'roo'

class ElectionSurveyImporter
  CSV_COLS = [:timestamp, :email, :full_name, :party_name, :area_name]

  def self.csv_to_params(survey, file)
    sheet = Roo::CSV.new(file.path, csv_options: {skip_blanks: true, encoding: "utf-8"})
    update_areas_from_sheet(survey, sheet)
    update_parties_from_sheet(survey, sheet)
    update_candidates_from_sheet(survey, sheet)
    update_questions_from_sheet(survey, sheet)
    update_responses_from_sheet(survey, sheet)
  end

  def validate_survey_csv(sheet)
    errors = errors_from_csv?(sheet)
    errors.any? ? errors : true
  end

  private

  def self.column_for(col_sym)
    (CSV_COLS.index(col_sym) + 1)
  end

  def self.update_areas_from_sheet(survey, sheet)
    survey.areas = sheet.column(column_for(:area_name)).
      drop(1).to_a.
      map(&:strip).uniq.map do |area_name|
      { name: area_name,
        slug: area_name.parameterize }
    end
  end

  def self.update_parties_from_sheet(survey, sheet)
    survey.parties = sheet.column(column_for(:party_name)).
      drop(1).to_a.
      map(&:strip).uniq.map do |party_name|
      { name: party_name,
        slug: party_name.parameterize }
    end
  end

  def self.update_candidates_from_sheet(survey, sheet)
    survey.candidates = sheet.drop(1).map do |row|
      full_name, party_name, area_name = row[2..4]
      {
        name: full_name.strip,
        slug: full_name.strip.parameterize,
        party: party_name.strip.parameterize,
        area: area_name.strip.parameterize
      }
    end
  end

  def self.update_questions_from_sheet(survey, sheet)
    survey.questions = sheet.row(1).drop(5).map do |question|
      pos, body = question.scan(/(\d+). (.+?)$/).first
      {
        position: pos.to_i,
        body: body.strip
      }
    end.sort_by { |q| q[:position] }
  end

  def self.update_responses_from_sheet(survey, sheet)
    survey.responses = sheet.drop(1).map do |row|
      candidate = row[2].strip.parameterize
      row.drop(5).each_with_index.map do |response, i|
        next if response.nil? or response.strip.blank?
        pos = sheet.row(1).drop(5)[i].scan(/(\d+). (.+?)$/).first.first.to_i
        {
          candidate: candidate,
          question: pos,
          body: response
        }
      end.compact
    end.flatten.sort_by { |r| [r[:question], r[:candidate]] }
  end

  def self.errors_from_csv?(sheet)
    header = sheet.row(1)

    errors = []

    (errors << "Malformed CSV: incorrect length") unless (header.count.to_i == 15)
    (errors << "Malformed CSV: timestamp") unless (header[0].try(:downcase) == 'timestamp')
    (errors << "Malformed CSV: email address") unless (header[1].try(:downcase) == 'email address')
    (errors << "Malformed CSV: name") unless (header[2].try(:downcase) == 'name')
    (errors << "Malformed CSV: party") unless (header[3].try(:downcase) == 'party')
    (errors << "Malformed CSV: area") unless (header[4].try(:downcase) == 'area')

    errors
  end
end