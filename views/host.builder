xml.Response do
  xml.Gather(:action => '/clear') do
    xml.Say('Welcome to the contest host line, powered by Twilio.')
    xml.Say('We are now going to connect you with the first winner. After you are connected, you can press star to disconnect.')
    xml.Say('We will then select another winner.')
    xml.Say('You can also press 9 now to clear all the entrants.')
  end
  xml.Redirect('/winner')
end