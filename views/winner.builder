xml.Response do
  xml.Dial(@winner.number, :hangupOnStar)
  xml.Gather(:numDigits => '1') do
    xml.Say('Hangup now to stop selecting winners, press any key to select the next winner or just stay on the line.')
    xml.Pause()
  end
  xml.Redirect('/winner')
end