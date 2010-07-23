module SoftwaresHelper

  # Perform RedCloth textile formatting
  def format_text(text)
    RedCloth.new(text).to_html(:textile)
  end
end
